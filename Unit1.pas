unit Unit1;

interface

{eNotes 0.5.1, последнее обновление 16.11.2016
https://github.com/r57zone/eNotes}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, ExtCtrls, StdCtrls, SQLite3, SQLiteTable3, SHDocVw, ActiveX,
  DateUtils, ClipBRD;

type
  TMain = class(TForm)
    WebView: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure WebViewBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure WebViewDocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    procedure LoadNotes;
    procedure MessageHandler(var Msg: TMsg; var Handled: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;
  SQLDB: TSQLiteDatabase;
  NoteIndex: string;
  FOleInPlaceActiveObject: IOleInPlaceActiveObject;
  SaveMessageHandler: TMessageEvent;
  RuLang: boolean;

implementation

{$R *.dfm}

function EncodeBase64(const inStr: string): string;  //sqlite_escape_string
  function Encode_Byte(b: Byte): char;
  const
    Base64Code: string[64] =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  begin
    Result := Base64Code[(b and $3F)+1];
  end;

var
  i: Integer;
begin
  i := 1;
  Result := '';
  while i <= Length(InStr) do
  begin
    Result := Result + Encode_Byte(Byte(inStr[i]) shr 2);
    Result := Result + Encode_Byte((Byte(inStr[i]) shl 4) or (Byte(inStr[i+1]) shr 4));
    if i+1 <= Length(inStr) then
      Result := Result + Encode_Byte((Byte(inStr[i+1]) shl 2) or (Byte(inStr[i+2]) shr 6))
    else
      Result := Result + '=';
    if i+2 <= Length(inStr) then
      Result := Result + Encode_Byte(Byte(inStr[i+2]))
    else
      Result := Result + '=';
    Inc(i, 3);
  end;
end;

function DecodeBase64(const CinLine: string): string;
const
  RESULT_ERROR = -2;
var
  inLineIndex: Integer;
  c: Char;
  x: SmallInt;
  c4: Word;
  StoredC4: array[0..3] of SmallInt;
  InLineLength: Integer;
begin
  Result := '';
  inLineIndex := 1;
  c4 := 0;
  InLineLength := Length(CinLine);

  while inLineIndex <= InLineLength do
  begin
    while (inLineIndex <= InLineLength) and (c4 < 4) do
    begin
      c := CinLine[inLineIndex];
      case c of
        '+'     : x := 62;
        '/'     : x := 63;
        '0'..'9': x := Ord(c) - (Ord('0')-52);
        '='     : x := -1;
        'A'..'Z': x := Ord(c) - Ord('A');
        'a'..'z': x := Ord(c) - (Ord('a')-26);
      else
        x := RESULT_ERROR;
      end;
      if x <> RESULT_ERROR then
      begin
        StoredC4[c4] := x;
        Inc(c4);
      end;
      Inc(inLineIndex);
    end;

    if c4 = 4 then
    begin
      c4 := 0;
      Result := Result + Char((StoredC4[0] shl 2) or (StoredC4[1] shr 4));
      if StoredC4[2] = -1 then Exit;
      Result := Result + Char((StoredC4[1] shl 4) or (StoredC4[2] shr 2));
      if StoredC4[3] = -1 then Exit;
      Result := Result + Char((StoredC4[2] shl 6) or (StoredC4[3]));
    end;
  end;
end;

function GetLocaleInformation(Flag: Integer): string;
var
  pcLCA: array [0..20] of Char;
begin
  if GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, Flag, pcLCA, 19)<=0 then
    pcLCA[0]:=#0;
  Result:=pcLCA;
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  if GetLocaleInformation(LOCALE_SENGLANGUAGE)='Russian' then RuLang:=true;
  Application.Title:=Caption;
  Main.Visible:=false;
  WebView.Silent:=true;
  WebView.Navigate(ExtractFilePath(ParamStr(0))+'main.htm');
  SQLDB:=TSQLiteDatabase.Create('Notes.db');
  if not SQLDB.TableExists('notes') then
    SQLDB.ExecSQL('CREATE TABLE Notes (ID INTEGER PRIMARY KEY, Note TEXT, DateTime DATETIME)');
end;

function ExtractTitle(Text: string; InList: boolean):string;
var
  CountChar: integer;
begin
  if InList then CountChar:=72 else CountChar:=40;
  Result:=Text;
  if Length(Text)>CountChar-1 then Result:=Copy(Text, 1, CountChar-3)+'...';
end;

function MyDateTime(sDate: string): string;
var
  mTime, nYear: string;
begin
  mTime:=Copy(sDate, Pos(' ', sDate)+1, Length(sDate)-Pos(' ', sDate));
  nYear:=FormatDateTime('yyyy', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));
  
  if nYear = FormatDateTime('yyyy', Date) then
    Result:=FormatDateTime('d mmm.', StrToDate(Copy(sDate, 1, Pos(' ', sDate))))+' '+Copy(mTime, 1, Length(mTime)-3)
  else
    Result:=FormatDateTime('d.mm.yyyy', StrToDate(Copy(sDate, 1, Pos(' ', sDate))))+' '+Copy(mTime, 1, Length(mTime)-3);
end;


function MyDateTime2(sDate: string): string;
var
  mTime, MyDate, nYear: string; DaysAgo: integer;
begin
  DaysAgo:=DaysBetween(StrToDate(Copy(sDate,1,Pos(' ',sDate)-1)), Date);

  mTime:=Copy(sDate, Pos(' ', sDate)+1, Length(sDate)-Pos(' ', sDate));

  MyDate:=FormatDateTime('d mmm.', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));

  if DaysAgo < DayOfTheWeek(Date) then begin
    MyDate:=FormatDateTime('dddd', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));
    MyDate[1]:=AnsiUpperCase(MyDate[1])[1];
  end;

  if DaysAgo = 0 then MyDate:=Copy(mTime, 1, Length(mTime)-3);
  if DaysAgo = 1 then if RuLang then MyDate:='Вчера' else MyDate:='Yesterday';

  nYear:=FormatDateTime('yyyy', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));
  if nYear <> FormatDateTime('yyyy', Date) then
    MyDate:=FormatDateTime('d mmm. yyyy', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));

  Result:=MyDate;
end;

procedure TMain.LoadNotes;
var
i: integer; SQLTB: TSQLiteTable;
begin
  SQLTB:=SQLDB.GetTable('SELECT * FROM Notes ORDER BY ID DESC');
    try
      if RuLang then
        WebView.OleObject.Document.getElementById('MainTitle').innerHTML:='Заметки ('+IntToStr(SQLTB.Count)+')'
      else
        WebView.OleObject.Document.getElementById('MainTitle').innerHTML:='Notes ('+IntToStr(SQLTB.Count)+')';
      WebView.OleObject.Document.getElementById('list').innerHTML:='';
      for i:=0 to SQLTB.Count-1 do begin
        WebView.OleObject.Document.getElementById('list').innerHTML:=WebView.OleObject.Document.getElementById('list').innerHTML+
        '<div onclick="document.location=''#note'+SQLTB.FieldAsString(0)+''';" id="note"><div id="title">'+ExtractTitle(DecodeBase64(SQLTB.FieldAsString(1)),true)+'</div><div id="date">'+MyDateTime2(SQLTB.FieldAsString(2))+'</div></div>';
        SQLTB.Next;
      end;
    finally
      SQLTB.Free;
    end;
end;

procedure TMain.WebViewBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  sUrl, fUrl: string; i, DaysAgo: integer; all: OleVariant;
  NoteDate: string;

  SQLTB: TSQLiteTable;
begin
  sUrl:=ExtractFileName(StringReplace(url,'/','\',[rfReplaceAll]));

  if pos('main.htm',sUrl) = 0 then Cancel:=true;

  if pos('main.htm#note',sUrl) > 0 then begin
    Delete(sUrl,1,pos('#note',sUrl)+4);
    NoteIndex:=sUrl;
    SQLTB:=SQLDB.GetTable('SELECT ID, Note, DateTime FROM NOTES WHERE ID='+sURL);

    WebView.OleObject.Document.getElementById('meta').style.display:='block';
    WebView.OleObject.Document.getElementById('memo').style.display:='block';
    WebView.OleObject.Document.getElementById('list').style.display:='none';
    if RuLang then
      WebView.OleObject.Document.getElementById('button').innerHTML:='Удалить'
    else
      WebView.OleObject.Document.getElementById('button').innerHTML:='Delete';

    WebView.OleObject.Document.getElementById('Clipbrd_value').value:='';

    if RuLang then
      WebView.OleObject.Document.getElementById('back').innerHTML:='<div onclick="document.location=''#all'';" id="back_btn">Назад</div>'
    else
      WebView.OleObject.Document.getElementById('back').innerHTML:='<div onclick="document.location=''#all'';" id="back_btn">Back</div>';

    WebView.OleObject.Document.getElementById('MainTitle').innerHTML:=ExtractTitle(DecodeBase64(SQLTB.FieldAsString(1)), false);

    NoteDate:=Copy(SQLTB.FieldAsString(2),1,Pos(' ',SQLTB.FieldAsString(2))-1);
    DaysAgo:=DaysBetween(StrToDate(NoteDate), Date);

    if RuLang then begin

      if IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '1' then NoteDate:=IntToStr(DaysAgo)+' день назад';
    
      if (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '2') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '3') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '4') then NoteDate:=IntToStr(DaysAgo)+' дня назад';

      if (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))]= '5') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '6') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '7') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '8') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '9') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '0') then NoteDate:=IntToStr(DaysAgo)+' дней назад';

      if DaysAgo = 0 then NoteDate:='Сегодня';
      if DaysAgo = 1 then NoteDate:='Вчера';
    end else begin
    
      NoteDate:=IntToStr(DaysAgo)+' days ago';
      if DaysAgo = 0 then NoteDate:='Today';
      if DaysAgo = 1 then NoteDate:='Yesterday';
    end;

    WebView.OleObject.Document.getElementById('DayAgo').innerHTML:=NoteDate;
    WebView.OleObject.Document.getElementById('DateNote').innerHTML:=MyDateTime(SQLTB.FieldAsString(2));
    WebView.OleObject.Document.getElementById('text').innerHTML:=DecodeBase64(SQLTB.FieldAsString(1));

  end else begin

    if (sUrl = 'main.htm#new') and (WebView.OleObject.Document.getElementById('button').innerHTML = '+') then begin
      WebView.OleObject.Document.getElementById('meta').style.display:='block';
      WebView.OleObject.Document.getElementById('memo').style.display:='block';
      WebView.OleObject.Document.getElementById('list').style.display:='none';
      
      if RuLang then begin
        WebView.OleObject.Document.getElementById('button').innerHTML:='Готово';
        WebView.OleObject.Document.getElementById('MainTitle').innerHTML:='Заметка';
        WebView.OleObject.Document.getElementById('DayAgo').innerHTML:='Сегодня';
        WebView.OleObject.Document.getElementById('back').innerHTML:='<div onclick="document.location=''#all'';" id="back_btn">Назад</div>';
      end else begin
        WebView.OleObject.Document.getElementById('button').innerHTML:='Done';
        WebView.OleObject.Document.getElementById('MainTitle').innerHTML:='Note';
        WebView.OleObject.Document.getElementById('DayAgo').innerHTML:='Today';
        WebView.OleObject.Document.getElementById('back').innerHTML:='<div onclick="document.location=''#all'';" id="back_btn">Back</div>';
      end;

      WebView.OleObject.Document.getElementById('text').innerHTML:='';
      WebView.OleObject.Document.getElementById('text').focus;
      WebView.OleObject.Document.getElementById('Clipbrd_value').value:='';
      WebView.OleObject.Document.getElementById('DateNote').innerHTML:=FormatDateTime('d mmm. h:nn', now);
      NoteIndex:='-1';
    end;

    if (sUrl = 'main.htm#button') and ((WebView.OleObject.Document.getElementById('button').innerHTML = 'Готово') or (WebView.OleObject.Document.getElementById('button').innerHTML='Done')) then begin
      WebView.OleObject.Document.getElementById('additional').style.display:='none';
      WebView.OleObject.Document.getElementById('meta').style.display:='none';
      WebView.OleObject.Document.getElementById('memo').style.display:='none';
      WebView.OleObject.Document.getElementById('list').style.display:='block';
      WebView.OleObject.Document.getElementById('back').innerHTML:='';
      WebView.OleObject.Document.getElementById('button').innerHTML:='+';
      SQLDB.ExecSQL('INSERT INTO Notes (ID, Note, DateTime) values(NULL, "'+EncodeBase64(WebView.OleObject.Document.getElementById('text').innerHTML)+'", "'+DateToStr(Date)+' '+TimeToStr(Time)+'")');
      LoadNotes;
    end;

    if (sUrl = 'main.htm#copy') and (WebView.OleObject.Document.getElementById('Clipbrd_value').value <> '') then begin
      Clipboard.AsText:=WebView.OleObject.Document.getElementById('Clipbrd_value').value;
      WebView.OleObject.Document.getElementById('Clipbrd_value').value:='';
    end;

    if (sUrl = 'main.htm#button') and ((WebView.OleObject.Document.getElementById('button').innerHTML = 'Обновить') or (WebView.OleObject.Document.getElementById('button').innerHTML = 'Update')) then begin
      WebView.OleObject.Document.getElementById('additional').style.display:='none';
      WebView.OleObject.Document.getElementById('meta').style.display:='none';
      WebView.OleObject.Document.getElementById('memo').style.display:='none';
      WebView.OleObject.Document.getElementById('list').style.display:='block';
      WebView.OleObject.Document.getElementById('back').innerHTML:='';
      WebView.OleObject.Document.getElementById('button').innerHTML:='+';
      SQLDB.ExecSQL('UPDATE Notes SET Note="'+EncodeBase64(WebView.OleObject.Document.getElementById('text').innerHTML)+'", DateTime="'+DateToStr(Date)+' '+TimeToStr(Time)+'" WHERE ID='+NoteIndex);
      LoadNotes;
    end;

    if (sUrl = 'main.htm#button') and ((WebView.OleObject.Document.getElementById('button').innerHTML = 'Удалить') or (WebView.OleObject.Document.getElementById('button').innerHTML = 'Delete')) then begin
      WebView.OleObject.Document.getElementById('additional').style.display:='none';
      WebView.OleObject.Document.getElementById('meta').style.display:='none';
      WebView.OleObject.Document.getElementById('memo').style.display:='none';
      WebView.OleObject.Document.getElementById('list').style.display:='block';
      WebView.OleObject.Document.getElementById('button').innerHTML:='+';
      WebView.OleObject.Document.getElementById('back').innerHTML:='';
      SQLDB.ExecSQL('DELETE FROM Notes WHERE ID='+NoteIndex);
      LoadNotes;
    end;

    if sUrl = 'main.htm#all' then begin
      WebView.OleObject.Document.getElementById('additional').style.display:='none';
      WebView.OleObject.Document.getElementById('meta').style.display:='none';
      WebView.OleObject.Document.getElementById('memo').style.display:='none';
      WebView.OleObject.Document.getElementById('list').style.display:='block';
      WebView.OleObject.Document.getElementById('button').innerHTML:='+';
      WebView.OleObject.Document.getElementById('back').innerHTML:='';
      LoadNotes;
    end;

  end;
end;

procedure TMain.WebViewDocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  sUrl: string;
begin
  sUrl:=ExtractFileName(StringReplace(url,'/','\',[rfReplaceAll]));
  if pDisp=(Sender as TWebBrowser).Application then
    if sUrl = 'main.htm' then begin
      Main.Visible:=true;
      WebView.OleObject.Document.getElementById('back').innerHTML:='';
      if RuLang=false then WebView.OleObject.Document.getElementById('add_btn').innerHTML:='Copy';
      LoadNotes;
    end;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (WebView.OleObject.Document.getElementById('button').innerHTML = 'Обновить') then
    SQLDB.ExecSQL('UPDATE Notes SET Note="'+EncodeBase64(WebView.OleObject.Document.getElementById('text').innerHTML)+'", DateTime="'+DateToStr(Date)+' '+TimeToStr(Time)+'" WHERE ID='+NoteIndex);
  SQLDB.Free;
  Application.OnMessage:=SaveMessageHandler;
  FOleInPlaceActiveObject:=nil;
end;

procedure TMain.MessageHandler(var Msg: TMsg; var Handled: Boolean);
var
  iOIPAO: IOleInPlaceActiveObject;
  Dispatch: IDispatch;
begin
  if not Assigned(WebView) then
  begin
    Handled := False;
    Exit;
  end;
  Handled := (IsDialogMessage(WebView.Handle, Msg) = True);
  if (Handled) and (not WebView.Busy) then
  begin
    if FOleInPlaceActiveObject = nil then
    begin
      Dispatch := WebView.Application;
      if Dispatch <> nil then
      begin
        Dispatch.QueryInterface(IOleInPlaceActiveObject, iOIPAO);
        if iOIPAO <> nil then
          FOleInPlaceActiveObject := iOIPAO;
      end;
    end;
    if FOleInPlaceActiveObject <> nil then
      if ((Msg.message = WM_KEYDOWN) or (Msg.message = WM_KEYUP)) and
        ((Msg.wParam = VK_BACK) or (Msg.wParam = VK_LEFT) or (Msg.wParam = VK_RIGHT)
        or (Msg.wParam = VK_UP) or (Msg.wParam = VK_DOWN)) then begin
        exit;
        end;
        FOleInPlaceActiveObject.TranslateAccelerator(Msg);
  end;
end;

procedure TMain.FormActivate(Sender: TObject);
begin
  SaveMessageHandler:=Application.OnMessage;
  Application.OnMessage:=MessageHandler;
end;

procedure TMain.FormDeactivate(Sender: TObject);
begin
  Application.OnMessage:=SaveMessageHandler;
end;

end.
