unit Unit1;

interface

{eNotes 0.7, последнее обновление 21.02.2018
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
    procedure NewNote(MemoFocus: boolean);
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
  ID_NEW_NOTE, ID_NOTES, ID_TODAY, ID_YESTERDAY, ID_DAYSAGO: string;

implementation

{$R *.dfm}

function EncodeBase64(const inStr: string): string;  //sqlite escape string
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
  if GetLocaleInformation(LOCALE_SENGLANGUAGE) = 'Russian' then begin
    ID_NEW_NOTE:='Новая заметка';
    ID_NOTES:='Заметки';
    ID_TODAY:='Сегодня';
    ID_YESTERDAY:='Вчера';
    ID_DAYSAGO:='дн. назад';
  end else begin
    ID_NEW_NOTE:='New note';
    ID_NOTES:='Notes';
    ID_TODAY:='Today';
    ID_YESTERDAY:='Yesterday';
    ID_DAYSAGO:='day ago';
  end;
  Application.Title:=Caption;
  Main.Visible:=false;
  WebView.Silent:=true;
  WebView.Navigate(ExtractFilePath(ParamStr(0)) + 'main.htm');
  SQLDB:=TSQLiteDatabase.Create('Notes.db');
  if not SQLDB.TableExists('notes') then
    SQLDB.ExecSQL('CREATE TABLE Notes (ID INTEGER PRIMARY KEY, Note TEXT, DateTime DATETIME)');
end;

function ExtractTitle(Str: string): string;
begin
  if Pos(#10, Str) > 0 then
    Result:=Copy(Str, 1, Pos(#10, Str) - 1)
  else
    Result:=Copy(Str, 1, 150);
end;

function NoteDateTime(sDate: string): string;
var
  mTime, nYear: string;
begin
  mTime:=Copy(sDate, Pos(' ', sDate) + 1, Length(sDate) - Pos(' ', sDate));
  nYear:=FormatDateTime('yyyy', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));
  
  if nYear = FormatDateTime('yyyy', Date) then
    Result:=FormatDateTime('d mmm.', StrToDate(Copy(sDate, 1, Pos(' ', sDate)))) + ' ' + Copy(mTime, 1, Length(mTime) - 3)
  else
    Result:=FormatDateTime('d.mm.yyyy', StrToDate(Copy(sDate, 1, Pos(' ', sDate)))) + ' ' + Copy(mTime, 1, Length(mTime) - 3);
end;

function ListDateTime(sDate: string): string;
var
  mTime, MyDate, nYear: string; DaysAgo: integer;
begin
  DaysAgo:=DaysBetween(StrToDate(Copy(sDate, 1, Pos(' ', sDate) - 1)), Date);

  mTime:=Copy(sDate, Pos(' ', sDate) + 1, Length(sDate) - Pos(' ', sDate));

  MyDate:=FormatDateTime('d mmm.', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));

  if DaysAgo < DayOfTheWeek(Date) then begin
    MyDate:=FormatDateTime('dddd', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));
    MyDate[1]:=AnsiUpperCase(MyDate[1])[1];
  end;

  if DaysAgo = 0 then MyDate:=Copy(mTime, 1, Length(mTime) - 3);
  if DaysAgo = 1 then MyDate:=ID_YESTERDAY;

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
    WebView.OleObject.Document.getElementById('NotesCount').innerHTML:=ID_NOTES + ' (' + IntToStr(SQLTB.Count) + ')';
    WebView.OleObject.Document.getElementById('items').innerHTML:='';
    for i:=0 to SQLTB.Count - 1 do begin
      WebView.OleObject.Document.getElementById('items').innerHTML:=WebView.OleObject.Document.getElementById('items').innerHTML +
      '<div onclick="document.location=''#note' + SQLTB.FieldAsString(0) + ''';" id="note"><div id="title">' + ExtractTitle(DecodeBase64(SQLTB.FieldAsString(1))) + '</div><div id="date">' + ListDateTime(SQLTB.FieldAsString(2)) + '</div></div>';
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
  sUrl: string;
  i, DaysAgo: integer;
  NoteDate: string;
  SQLTB: TSQLiteTable;
begin
  sUrl:=ExtractFileName(StringReplace(Url, '/', '\', [rfReplaceAll]));

  if Pos('main.htm', sUrl) = 0 then Cancel:=true;

  if Pos('main.htm#note', sUrl) > 0 then begin
    Delete(sUrl, 1, Pos('#note', sUrl) + 4);
    NoteIndex:=sUrl;
    SQLTB:=SQLDB.GetTable('SELECT ID, Note, DateTime FROM NOTES WHERE ID=' + sURL);

    WebView.OleObject.Document.getElementById('NoteTitle').innerHTML:=ExtractTitle(DecodeBase64(SQLTB.FieldAsString(1)));

    NoteDate:=Copy(SQLTB.FieldAsString(2), 1, Pos(' ', SQLTB.FieldAsString(2)) - 1);
    DaysAgo:=DaysBetween(StrToDate(NoteDate), Date);

    if ID_DAYSAGO='дн. назад' then begin

      if IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '1' then NoteDate:=IntToStr(DaysAgo) + ' день назад';
    
      if (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '2') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '3') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '4') then NoteDate:=IntToStr(DaysAgo) + ' дня назад';

      if (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))]= '5') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '6') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '7') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '8') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '9') or
      (IntToStr(DaysAgo)[Length(IntToStr(DaysAgo))] = '0') then NoteDate:=IntToStr(DaysAgo) + ' дней назад';
    end else
      NoteDate:=IntToStr(DaysAgo) + ' ' + ID_DAYSAGO;

    if DaysAgo = 0 then NoteDate:=ID_TODAY;
    if DaysAgo = 1 then NoteDate:=ID_YESTERDAY;

    WebView.OleObject.Document.getElementById('DayAgo').innerHTML:=NoteDate;
    WebView.OleObject.Document.getElementById('DateNote').innerHTML:=NoteDateTime(SQLTB.FieldAsString(2));
    WebView.OleObject.Document.getElementById('memo').innerHTML:=DecodeBase64(SQLTB.FieldAsString(1));

  end else begin

    if sUrl = 'main.htm#new' then
      NewNote(true);

    if sUrl = 'main.htm#done' then begin
      //Add
      if (NoteIndex = '-1') and (Trim(WebView.OleObject.Document.getElementById('memo').innerHTML) <> '') then begin
        SQLDB.ExecSQL('INSERT INTO Notes (ID, Note, DateTime) values(NULL, "'+EncodeBase64(WebView.OleObject.Document.getElementById('memo').innerHTML)+'", "'+DateToStr(Date) + ' ' + TimeToStr(Time) + '")');
        NewNote(false);
      end;

      //Update
      if NoteIndex <> '-1' then
        SQLDB.ExecSQL('UPDATE Notes SET Note="' + EncodeBase64(WebView.OleObject.Document.getElementById('memo').innerHTML) + '", DateTime="' + DateToStr(Date) + ' ' + TimeToStr(Time) + '" WHERE ID=' + NoteIndex);
      LoadNotes;
    end;

    //Delete
    if (sUrl = 'main.htm#rem') and (NoteIndex <> '-1') then begin
      WebView.OleObject.Document.getElementById('memo').innerHTML:='';
      SQLDB.ExecSQL('DELETE FROM Notes WHERE ID=' + NoteIndex);
      LoadNotes;
      NewNote(false);
    end;

  end;
end;

procedure TMain.WebViewDocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  sUrl: string;
begin
  sUrl:=ExtractFileName(StringReplace(Url, '/', '\', [rfReplaceAll]));
  if pDisp=(Sender as TWebBrowser).Application then
    if sUrl = 'main.htm' then begin
      Main.Visible:=true;
      LoadNotes;
      NewNote(false);
    end;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if NoteIndex <> '-1' then
    SQLDB.ExecSQL('UPDATE Notes SET Note="' + EncodeBase64(WebView.OleObject.Document.getElementById('memo').innerHTML) + '", DateTime="' + DateToStr(Date) + ' ' + TimeToStr(Time) + '" WHERE ID=' + NoteIndex);
  SQLDB.Free;
  Application.OnMessage:=SaveMessageHandler;
  FOleInPlaceActiveObject:=nil;
end;

procedure TMain.MessageHandler(var Msg: TMsg; var Handled: Boolean);
var
  iOIPAO: IOleInPlaceActiveObject;
  Dispatch: IDispatch;
begin
  if not Assigned(WebView) then begin
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
        or (Msg.wParam = VK_UP) or (Msg.wParam = VK_DOWN)) then exit;
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

procedure TMain.NewNote(MemoFocus: boolean);
begin
  WebView.OleObject.Document.getElementById('NoteTitle').innerHTML:=ID_NEW_NOTE;
  WebView.OleObject.Document.getElementById('DayAgo').innerHTML:=ID_TODAY;
  WebView.OleObject.Document.getElementById('DateNote').innerHTML:=FormatDateTime('d mmm. h:nn', Now);
  WebView.OleObject.Document.getElementById('memo').innerHTML:='';
  if MemoFocus then
    WebView.OleObject.Document.getElementById('memo').focus;
  NoteIndex:='-1';
end;

initialization
 OleInitialize(nil);

finalization
 OleUninitialize;

end.
