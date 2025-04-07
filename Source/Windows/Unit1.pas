﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, IdContext,
  IdCustomHTTPServer, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdHTTPServer, SQLite3, SQLite3Wrap, ActiveX, DateUtils, IniFiles, Registry,
  XMLDoc, XMLIntf, MSHTML, Vcl.StdCtrls, Vcl.Menus, ClipBrd, LangFile;

type
  TMain = class(TForm)
    WebView: TWebBrowser;
    IdHTTPServer: TIdHTTPServer;
    PopupMenu: TPopupMenu;
    CutBtn: TMenuItem;
    CopyBtn: TMenuItem;
    PasteBtn: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure AddStyle(FileName: string);
    procedure ExportNotes(FileName: string);
    procedure ImportNotes(FileName: string);
    procedure ShowNotes(SearchValue: string);
    procedure ShowCategories;
    procedure WebViewBeforeNavigate2(ASender: TObject;
      const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure WebViewDocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure IdHTTPServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure CutBtnClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
    procedure PasteBtnClick(Sender: TObject);
  private
    procedure NewNote(MemoFocus: boolean);
    procedure NoteDone(UpdateList: integer);
    procedure MessageHandler(var Msg: TMsg; var Handled: Boolean);
    { Private declarations }
  public
    function SQLDBTableExists(TableName: string): boolean;
	  function SQLTBCount(TableName: string): integer;
    { Public declarations }
  end;

var
  Main: TMain;
  CloseDuplicate: boolean;
  SQLDB: TSQLite3Database;
  DBFileName: string;

  OldWidth, OldHeight, DarkThemeStartHour, DarkThemeEndHour: integer;
  NoteIndex, NoteTimeStamp: int64; LatestNote: string;

  FOleInPlaceActiveObject: IOleInPlaceActiveObject;
  SaveMessageHandler: TMessageEvent;

  IDS_NEW_NOTE, IDS_NOTES, IDS_TODAY, IDS_YESTERDAY, IDS_DAYSAGO, IDS_SEARCH: string;
  IDS_SYNC, IDS_DEV_SYNC_CONFIRM, IDS_CUT, IDS_COPY, IDS_PASTE, IDS_LAST_UPDATE: string;

  IDS_SETTINGS, IDS_INTERFACE, IDS_DARK_THEME, IDS_THEME_TIME, IDS_DARK_THEME_START, IDS_DARK_THEME_END,
  IDS_SYNCHRONIZATION, IDS_SYNC_PORT, IDS_SYNC_WITH_ANY_IPS, IDS_ALLOW_IPS, IDS_ALLOW_DEVS,
  IDS_ALLOW_DEV_REM, IDS_ENTER_DEV_ID, IDS_BLOCK_REQUEST_NEW_DEVS, IDS_IMPORT, IDS_EXPORT, IDS_CATEGORIES,
  IDS_DONE, IDS_OK, IDS_CANCEL: string;

  AllowedIPs, AuthorizedDevices, CategoriesList: TStringList;
  AllowAnyIPs, BlockReqNewDevs: boolean;
  UseDarkTheme, UseThemeTime: boolean;

const
  AppName = 'EasyNotes';
  AllowedIPsFile = 'AllowedIPs.txt';

implementation

{$R *.dfm}

uses Unit2;

//TimeStamp по Гринвичу GMT или UTC +0
function GetTimeStamp: int64;
var
 SystemTime: TSystemTime;
begin
  GetSystemTime(SystemTime);
  with SystemTime do
    Result:=DateTimeToUNIX(EncodeDate(wYear, wMonth, wDay) + EncodeTime(wHour, wMinute, wSecond, wMilliseconds));
end;

function StrToCharCodes(Str: string): string;
var
  i: integer;
begin
  Result:='';
  for i:=1 to Length(Str) do
    Result:=Result + 'x' + IntToStr( Ord( Str[i] ) );
end;

function CharCodesToStr(Str: string): string;
var
  i: integer;
begin
  Result:='';
  if Length(Str) = 0 then Exit;
  if Str[1] <> 'x' then Exit;
  Delete(Str, 1, 1);
  Str:=Str + 'x';
  while Pos('x', Str) > 0 do begin
    Result:=Result + Chr( StrToIntDef ( Copy( Str, 1, Pos('x', Str) - 1), 0 ) );
    Delete(Str, 1, Pos('x', Str));
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

function TMain.SQLDBTableExists(TableName: string): boolean;
var
  SQLTB: TSQLite3Statement;
begin
  Result:=false;
  SQLTB:=SQLDB.Prepare('SELECT * FROM sqlite_master WHERE name = "' + TableName + '" LIMIT 1');
  try
    if SQLTB.Step = SQLITE_ROW then
      Result:=true;
  finally
    SQLTB.Free;
  end;
end;

function TMain.SQLTBCount(TableName: string): integer;
var
  SQLTB: TSQLite3Statement;
begin
  Result:=0;
  SQLTB:=SQLDB.Prepare('SELECT * FROM ' + TableName);
  try
    while SQLTB.Step = SQLITE_ROW do begin
      Inc(Result);
    end;
  finally
    SQLTB.Free;
  end;
end;

procedure TMain.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  Reg: TRegistry;
  WND: HWND;

  CurDate: TDateTime;
  CurHour, NilTime: Word;

  i: integer;

  SQLTB: TSQLite3Statement;
  LangFileName: string;

  LangFile: TLangFile;
begin
  // Предотвращение повторого запуска
  WND:=FindWindow('TMain', AppName);
  if (WND <> 0) and (ParamStr(1) <> '-show') then begin
    SetForegroundWindow(WND);
    Halt;
  end;
  Caption:=AppName;

  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
  IdHTTPServer.DefaultPort:=Ini.ReadInteger('Main', 'Port', 735);
  AllowAnyIPs:=Ini.ReadBool('Sync', 'AllowAnyIPs', false);
  BlockReqNewDevs:=Ini.ReadBool('Sync', 'BlockRequestNewDevs', false);

  UseDarkTheme:=Ini.ReadBool('Main', 'DarkTheme', false);
  UseThemeTime:=Ini.ReadBool('Main', 'ThemeTime', false);

  CategoriesList:=TStringList.Create;
  CategoriesList.Text:=Ini.ReadString('Main', 'Categories', '');

  DarkThemeStartHour:=Ini.ReadInteger('Main', 'DarkThemeStartHour', 18);
  DarkThemeEndHour:=Ini.ReadInteger('Main', 'DarkThemeEndHour', 8);

  // Автоматическое изменение темы от времени суток
  if (UseDarkTheme = false) and (UseThemeTime) then begin
    DecodeTime(Now, CurHour, NilTime, NilTime, NilTime);
    if (CurHour < DarkThemeEndHour) or (CurHour >= DarkThemeStartHour) then
      UseDarkTheme:=true;
  end;

  Width:=Ini.ReadInteger('Main', 'Width', Width);
  Height:=Ini.ReadInteger('Main', 'Height', Height);
  OldWidth:=Width;
  OldHeight:=Height;
  if Ini.ReadBool('Main', 'FirstRun', true) then begin
    Ini.WriteBool('Main', 'FirstRun', false);
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION', true) then begin
        Reg.WriteInteger(ExtractFileName(ParamStr(0)), 11000);
      Reg.CloseKey;
    end;
    Reg.Free;
  end;
  Ini.Free;

  IdHTTPServer.Active:=true;

  // Перевод
  LangFileName:=GetLocaleInformation(LOCALE_SENGLANGUAGE) + '.txt';
  if not FileExists(ExtractFilePath(ParamStr(0)) + 'Languages\' + LangFileName) then
    LangFileName:='English.txt';
  //LangFileName:='English.txt';
  //LangFileName:='Chinese.txt';
  //LangFileName:='Spanish.txt';
  //LangFileName:='Portuguese.txt';
  //LangFileName:='French.txt';
  //LangFileName:='German.txt';
  //LangFileName:='Japanese.txt';
  //LangFileName:='Italian.txt';
  //LangFileName:='Korean.txt';

  LangFile:=TLangFile.Create(ExtractFilePath(ParamStr(0)) + 'Languages\' + LangFileName);
  try
    IDS_NEW_NOTE:=LangFile.GetString('NEW_NOTE', '');
    IDS_NOTES:=LangFile.GetString('NOTES', '');
    IDS_TODAY:=LangFile.GetString('TODAY', '');
    IDS_YESTERDAY:=LangFile.GetString('YESTERDAY', '');
    IDS_DAYSAGO:=LangFile.GetString('DAYSAGO', '');
    IDS_SEARCH:=LangFile.GetString('SEARCH', '');
    IDS_SYNC:=LangFile.GetString('SYNC', '');
    IDS_DEV_SYNC_CONFIRM:=LangFile.GetString('DEV_SYNC_CONFIRM', '');
    IDS_CUT:=LangFile.GetString('CUT', '');
    IDS_COPY:=LangFile.GetString('COPY', '');
    IDS_PASTE:=LangFile.GetString('PASTE', '');
    IDS_LAST_UPDATE:=LangFile.GetString('LAST_UPDATE', '');

    IDS_SETTINGS:=LangFile.GetString('SETTINGS', '');
    IDS_INTERFACE:=LangFile.GetString('INTERFACE', '');
    IDS_DARK_THEME:=LangFile.GetString('DARK_THEME', '');
    IDS_THEME_TIME:=LangFile.GetString('THEME_TIME', '');
    IDS_DARK_THEME_START:=LangFile.GetString('DARK_THEME_START', '');
    IDS_DARK_THEME_END:=LangFile.GetString('DARK_THEME_END', '');
    IDS_SYNCHRONIZATION:=LangFile.GetString('SYNCHRONIZATION', '');
    IDS_SYNC_PORT:=LangFile.GetString('SYNC_PORT', '');
    IDS_SYNC_WITH_ANY_IPS:=LangFile.GetString('SYNC_WITH_ANY_IPS', '');
    IDS_ALLOW_IPS:=LangFile.GetString('ALLOW_IPS', '');
    IDS_ALLOW_DEVS:=LangFile.GetString('ALLOW_DEVS', '');
    IDS_ALLOW_DEV_REM:=LangFile.GetString('ALLOW_DEV_REM', '');
    IDS_ENTER_DEV_ID:=LangFile.GetString('ENTER_DEV_ID', '');
    IDS_BLOCK_REQUEST_NEW_DEVS:=LangFile.GetString('BLOCK_REQUEST_NEW_DEVS', '');
    IDS_IMPORT:=LangFile.GetString('IMPORT', '');
    IDS_EXPORT:=LangFile.GetString('EXPORT', '');
    IDS_CATEGORIES:=LangFile.GetString('CATEGORIES', '');
    IDS_DONE:=LangFile.GetString('DONE', '');
    IDS_OK:=LangFile.GetString('OK', '');
    IDS_CANCEL:=LangFile.GetString('CANCEL', '');
    if CategoriesList.Text = '' then
      CategoriesList.Text:=LangFile.GetString('USER_CATEGORIES', '');
  finally
    LangFile.Free;
  end;

  CategoriesList.Text:=Trim(StringReplace(CategoriesList.Text, '\n', #13#10, [rfReplaceAll]));

  CutBtn.Caption:=IDS_CUT;
  CopyBtn.Caption:=IDS_COPY;
  PasteBtn.Caption:=IDS_PASTE;
  Application.Title:=Caption;
  Main.Visible:=false;
  WebView.Silent:=true;
  WebView.Navigate(ExtractFilePath(ParamStr(0)) + 'UI\main.html');

  DBFileName:='Notes.db';
  for i:=1 to ParamCount do
    if (LowerCase(ParamStr(i)) = '-db') and (Trim(ParamStr(i + 1)) <> '') then begin
      DBFileName:=ParamStr(i + 1);
      break;
    end;


  SQLDB:=TSQLite3Database.Create;
  SQLDB.Open(DBFileName);

  SQLDB.Execute('CREATE TABLE IF NOT EXISTS Notes (ID TIMESTAMP, Note TEXT, DateTime TIMESTAMP)');

  // Ограничение IP адресов для синхронизации
  AllowedIPs:=TStringList.Create;
  if FileExists(ExtractFilePath(ParamStr(0)) + AllowedIPsFile) then
    AllowedIPs.LoadFromFile(ExtractFilePath(ParamStr(0)) + AllowedIPsFile);

  // Авторизованные устройства
  AuthorizedDevices:=TStringList.Create;
  SQLTB:=SQLDB.Prepare('SELECT name FROM sqlite_master WHERE name <> "Notes"');
  try
    while SQLTB.Step = SQLITE_ROW do
      AuthorizedDevices.Add(Copy(SQLTB.ColumnText(0), 9, Length(SQLTB.ColumnText(0)))); //Actions_ не берем
  finally
    SQLTB.Free;
  end;

  // Экспорт, импорт
  for i:=1 to ParamCount do begin
    if (LowerCase(ParamStr(i)) = '-export') and (Trim(ParamStr(i + 1)) <> '') then
      ExportNotes(ParamStr(i + 1));

    if (LowerCase(ParamStr(i)) = '-import') and (Trim(ParamStr(i + 1)) <> '') then
      ImportNotes(ParamStr(i + 1));
  end;
end;

function ExtractTitle(Str: string): string;
begin
  Str:=Trim(Str);
  if Pos(#10, Str) > 0 then
    Str:=Copy(Str, 1, Pos(#10, Str) - 1);
  if (Length(Str) > 0) and (Str[Length(Str)] = ':') then
    Str:=Copy(Str, 1, Length(Str) - 1);
  if Length(Str) > 150 then
    Str:=Copy(Str, 1, 150) + '...';
  Result:=Str;
end;

function NoteDateTime(sDate: string): string; // Дата в заметке
var
  mTime, nYear: string;
begin
  sDate:=DateTimeToStr(UNIXToDateTime(StrToInt64(sDate))); // Перевод TimeStamp в DateTimeStr

  mTime:=Copy(sDate, Pos(' ', sDate) + 1, Length(sDate) - Pos(' ', sDate));
  nYear:=FormatDateTime('yyyy', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));

  if nYear = FormatDateTime('yyyy', Date) then
    Result:=FormatDateTime('d mmm.', StrToDate(Copy(sDate, 1, Pos(' ', sDate)))) + ' ' + Copy(mTime, 1, Length(mTime) - 3)
  else
    Result:=FormatDateTime('d.mm.yyyy', StrToDate(Copy(sDate, 1, Pos(' ', sDate)))) + ', ' + Copy(mTime, 1, Length(mTime) - 3);
end;

function ListDateTime(sDate: string): string;
var
  mTime, MyDate, nYear: string; DaysAgo: integer;
begin
  sDate:=DateTimeToStr(UNIXToDateTime(StrToInt64(sDate))); // Перевод TimeStamp в DateTimeStr

  DaysAgo:=DaysBetween(StrToDate(Copy(sDate, 1, Pos(' ', sDate) - 1)), Date);

  mTime:=Copy(sDate, Pos(' ', sDate) + 1, Length(sDate) - Pos(' ', sDate));

  MyDate:=FormatDateTime('d mmm.', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));

  if DaysAgo < DayOfTheWeek(Date) then begin
    MyDate:=FormatDateTime('dddd', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));
    MyDate[1]:=AnsiUpperCase(MyDate[1])[1];
  end;

  if DaysAgo = 0 then MyDate:=Copy(mTime, 1, Length(mTime) - 3);
  if DaysAgo = 1 then MyDate:=IDS_YESTERDAY;

  nYear:=FormatDateTime('yyyy', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));
  if nYear <> FormatDateTime('yyyy', Date) then
    MyDate:=FormatDateTime('d mmm. yyyy', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));

  Result:=MyDate;
end;

procedure TMain.ShowNotes(SearchValue: string);
var
  SQLTB: TSQLite3Statement;
  NotesCount: integer;
  NoteStr: string;
begin
  //if SearchValue = '' then
  SQLTB:=SQLDB.Prepare('SELECT * FROM Notes ORDER BY DateTime DESC');
  //else
    //SQLTB := SQLDB.Prepare('SELECT * FROM Notes WHERE Note LIKE ''%' + StrToCharCodes(Trim(SearchValue)) + '%'' ORDER BY DateTime DESC');
  SearchValue:=AnsiLowerCase(SearchValue);
  try
    NotesCount:=0;
    WebView.OleObject.Document.getElementById('NotesCount').innerHTML:=IDS_NOTES + ' (0)';
    WebView.OleObject.Document.getElementById('items').innerHTML:='';
    while SQLTB.Step = SQLITE_ROW do begin
      NoteStr:=CharCodesToStr(SQLTB.ColumnText(1));
      if (SearchValue <> '') and (Pos(SearchValue, AnsiLowerCase(NoteStr)) = 0) then Continue;

      WebView.OleObject.Document.getElementById('items').innerHTML:=WebView.OleObject.Document.getElementById('items').innerHTML +
      '<div onclick="document.location=''#note' + SQLTB.ColumnText(0) + ''';HideNoteCategories();" id="note"><div id="title">' + ExtractTitle(NoteStr) + '</div><div id="date">' + ListDateTime(SQLTB.ColumnText(2))  + '</div></div>';
      Inc(NotesCount);
    end;
  finally
    WebView.OleObject.Document.getElementById('NotesCount').innerHTML:=IDS_NOTES + ' (' + IntToStr(NotesCount) + ')';
    SQLTB.Free;
  end;
end;

procedure TMain.ShowCategories;
var
  i: integer;
begin
  WebView.OleObject.Document.getElementById('NotesCount').innerHTML:=IDS_CATEGORIES + ' (' + IntToStr(CategoriesList.Count) + ')';
  WebView.OleObject.Document.getElementById('items').innerHTML:='';
  for i:=0 to CategoriesList.Count - 1 do
    WebView.OleObject.Document.getElementById('items').innerHTML:=WebView.OleObject.Document.getElementById('items').innerHTML +
    '<div onclick="document.location=''#search=' + CategoriesList.Strings[i] + '''" id="note"><div id="title">' + CategoriesList.Strings[i] + '</div></div>';
end;

procedure TMain.NoteDone(UpdateList: integer);
var
  CurTimeStamp: int64; i: integer;
begin
  // Update
  if (NoteIndex <> -1) and ( Trim(LatestNote) <> Trim(WebView.OleObject.Document.getElementById('memo').innerHTML) ) then begin

    if (GetAsyncKeyState(VK_LSHIFT) and $8000 <> 0) or (GetAsyncKeyState(VK_RSHIFT) and $8000 <> 0) then begin // Если нажат Shift, то не обновляем дату
      SQLDB.Execute('UPDATE Notes SET Note="' + StrToCharCodes(WebView.OleObject.Document.getElementById('memo').innerHTML) + '" WHERE ID=' + IntToStr(NoteIndex));

      // Добавляем действие во все таблицы авторизованных устройств. Проверка доступности нужна для использования иных баз данных
      for i:=0 to AuthorizedDevices.Count - 1 do
        if SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[i]) then
          SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[i] + ' (Action, ID, Note, DateTime) values("UPDATE", "' + IntToStr(NoteIndex) + '", "' + StrToCharCodes(WebView.OleObject.Document.getElementById('memo').innerHTML) + '", "' + IntToStr(NoteTimeStamp) + '")');

    end else begin //По умолчанию (обновление текста и даты)
	    SQLDB.Execute('UPDATE Notes SET Note="' + StrToCharCodes(WebView.OleObject.Document.getElementById('memo').innerHTML) + '", DateTime="' + IntToStr(DateTimeToUnix(Now)) + '" WHERE ID=' + IntToStr(NoteIndex));

      //Добавляем действие во все таблицы авторизованных устройств. Проверка доступности нужна для использования иных баз данных
      for i:=0 to AuthorizedDevices.Count - 1 do
        if SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[i]) then
          SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[i] + ' (Action, ID, Note, DateTime) values("UPDATE", "' + IntToStr(NoteIndex) + '", "' + StrToCharCodes(WebView.OleObject.Document.getElementById('memo').innerHTML) + '", "' + IntToStr(DateTimeToUnix(Now)) + '")');
    end;
  end;

  // Add, обязательно под Update, потому что обновляется текущий NoteIndex
  if (NoteIndex = -1) and (Trim(WebView.OleObject.Document.getElementById('memo').innerHTML) <> '') then begin
	  CurTimeStamp:=GetTimeStamp;
	  SQLDB.Execute('INSERT INTO Notes (ID, Note, DateTime) values("' + IntToStr(CurTimeStamp) + '", "' + StrToCharCodes(WebView.OleObject.Document.getElementById('memo').innerHTML) + '", "' + IntToStr(DateTimeToUnix(Now)) + '")');
	  NoteIndex:=CurTimeStamp; //Для того, чтобы последняя запись не создавалась снова и снова

    //Добавляем действие во все базы авторизованных устройств. Проверка доступности нужна для использования иных баз данных
    for i:=0 to AuthorizedDevices.Count - 1 do
      if SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[i]) then
        SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[i] + ' (Action, ID, Note, DateTime) values("INSERT", "' + IntToStr(CurTimeStamp) + '", "' + StrToCharCodes(WebView.OleObject.Document.getElementById('memo').innerHTML) + '", "' + IntToStr(DateTimeToUnix(Now)) + '")');
  end;

  if UpdateList = 0 then begin
    ShowNotes('');
    NewNote(true); // Новая заметка
  end;
end;

function URLDecode(const S: string): string;
var
  i, idx: Integer;
  function WebHexToInt(HexChar: Char): Integer;
  begin
    case HexChar of
      '0'..'9': Result := Ord(HexChar) - Ord('0');
      'A'..'F': Result := Ord(HexChar) - Ord('A') + 10;
      'a'..'f': Result := Ord(HexChar) - Ord('a') + 10;
    else
      Result := 0; // Некорректный символ, по умолчанию 0
    end;
  end;
begin
  SetLength(Result, Length(S)); // Резервируем место под строку
  idx := 0;

  i := 1;
  while i <= Length(S) do
  begin
    case S[i] of
      '%':
        if (i + 2 <= Length(S)) then // Проверка на выход за границы
        begin
          Result[idx + 1] := Chr((WebHexToInt(S[i + 1]) shl 4) or WebHexToInt(S[i + 2]));
          Inc(idx);
          Inc(i, 2); // Пропускаем обработанные символы
        end;
      '+':
        begin
          Result[idx + 1] := ' ';
          Inc(idx);
        end;
    else
      begin
        Result[idx + 1] := S[i];
        Inc(idx);
      end;
    end;
    Inc(i);
  end;

  SetLength(Result, idx); // Урезаем строку до фактической длины
end;

procedure TMain.WebViewBeforeNavigate2(ASender: TObject;
  const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  sUrl: string;
  i, DaysAgo: integer;
  NoteDate, sDate: string;
  SQLTB: TSQLite3Statement;
begin
  sUrl:=ExtractFileName(StringReplace(Url, '/', '\', [rfReplaceAll]));

  if Pos('main.html', sUrl) = 0 then Cancel:=true;

  if Pos('main.html#note', sUrl) > 0 then begin
    Delete(sUrl, 1, Pos('#note', sUrl) + 4);
    NoteIndex:=StrToIntDef(sUrl, 0);
    SQLTB:=SQLDB.Prepare('SELECT * FROM Notes WHERE ID=' + sUrl);

    if SQLTB.Step = SQLITE_ROW then
      try
        WebView.OleObject.Document.getElementById('NoteTitle').innerHTML:=ExtractTitle(CharCodesToStr(SQLTB.ColumnText(1)));
        LatestNote:=CharCodesToStr(SQLTB.ColumnText(1));

        NoteTimeStamp:=StrToInt64(SQLTB.ColumnText(2)); // Запомнить для синхронизации

        sDate:=DateTimeToStr(UNIXToDateTime(StrToInt64(SQLTB.ColumnText(2)))); // Перевод TimeStamp в DateTimeStr
        NoteDate:=Copy(sDate, 1, Pos(' ', sDate) - 1);
        DaysAgo:=DaysBetween(StrToDate(NoteDate), Date);

        if IDS_DAYSAGO='дн. назад' then begin
          if DaysAgo mod 10 = 1 then NoteDate:=IntToStr(DaysAgo) + ' день назад';

          if (DaysAgo mod 10 >= 2) and (DaysAgo mod 10 <= 4) then
            NoteDate:=IntToStr(DaysAgo) + ' дня назад';

          if ( (DaysAgo mod 10 >= 5) and (DaysAgo mod 10 <= 9) ) or (DaysAgo mod 10 = 0) then
            NoteDate:=IntToStr(DaysAgo) + ' дней назад';
        end else
          NoteDate:=IntToStr(DaysAgo) + ' ' + IDS_DAYSAGO;

        if DaysAgo = 0 then NoteDate:=IDS_TODAY;
        if DaysAgo = 1 then NoteDate:=IDS_YESTERDAY;

        WebView.OleObject.Document.getElementById('DaysAgo').innerHTML:=NoteDate;
        WebView.OleObject.Document.getElementById('DateNote').innerHTML:=NoteDateTime(SQLTB.ColumnText(2));
        WebView.OleObject.Document.getElementById('memo').innerHTML:=CharCodesToStr(SQLTB.ColumnText(1));
      finally
        SQLTB.Free;
      end;
  end;

  if sUrl = 'main.html#new' then
    NewNote(true);

  if sUrl = 'main.html#settings' then
    Settings.ShowModal;

  if sUrl = 'main.html#done' then
    NoteDone(0); // Добавляем, обновляем, статус "0" обновляет список заметок в интерфейсе

  // Удаляем
  if (sUrl = 'main.html#rem') and (NoteIndex <> -1) then begin
    WebView.OleObject.Document.getElementById('memo').innerHTML:='';
    SQLDB.Execute('DELETE FROM Notes WHERE ID=' + IntToStr(NoteIndex));

    // Добавляем действие во все доступные таблицы авторизованных устройств. Проверка доступности нужна для использования иных баз данных
    for i:=0 to AuthorizedDevices.Count - 1 do
      if SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[i]) then
        SQLDB.Execute('INSERT INTO Actions_' +  AuthorizedDevices.Strings[i] + ' (Action, ID) values("DELETE", "' + IntToStr(NoteIndex) + '")');

    ShowNotes('');
    NewNote(false);
  end;

  if (sUrl = 'main.html#memo-menu') then begin
    PasteBtn.Enabled:=Clipboard.AsText <> '';
    CutBtn.Enabled:=WebView.OleObject.Document.getElementById('memo').selectionStart <> WebView.OleObject.Document.getElementById('memo').selectionEnd;
    CopyBtn.Enabled:=CutBtn.Enabled;
    PopupMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  end;

  if sUrl = 'main.html#show-categories' then
    ShowCategories;

  if Pos('main.html#search=', sUrl) > 0 then begin
    Delete(sUrl, 1, Pos('#search=', sUrl) + 7);
    ShowNotes(UrlDecode(sUrl));
  end;
end;

procedure TMain.WebViewDocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
var
  sUrl: string; i: integer;
begin
  sUrl := ExtractFileName(StringReplace(Url, '/', '\', [rfReplaceAll]));
  // Проверяем, является ли pDisp основным объектом TWebBrowser
  if Assigned(pDisp) and (pDisp = (ASender as TWebBrowser).DefaultInterface) then begin
    if sUrl = 'main.html' then begin
      Main.Visible := True;
      ShowNotes('');
      NewNote(True);
      WebView.OleObject.Document.getElementById('note-categories').innerHTML := '';
      WebView.OleObject.Document.getElementById('Search').setAttribute('placeholder', IDS_SEARCH);

      for i:=0 to CategoriesList.Count - 1 do
        WebView.OleObject.Document.getElementById('note-categories').innerHTML:=WebView.OleObject.Document.getElementById('note-categories').innerHTML +
          '<div onclick="AddNoteCategory(''' + CategoriesList.Strings[i] + ''')" id="item">' + CategoriesList.Strings[i] + '</div>';

      if UseDarkTheme then
        AddStyle(IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'UI\darktheme.css');
    end;
  end;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Ini: TIniFile;
begin
  if (Main.WindowState <> wsMaximized) then
    if (OldWidth <> Width) or (OldHeight <> Height) then begin
      Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
      Ini.WriteInteger('Main', 'Width', Width);
      Ini.WriteInteger('Main', 'Height', Height);
      Ini.Free;
    end;
  IdHTTPServer.Active:=false;

  // Добавляем, обновляем, статус "-1" не обновляет список заметок в интерфейсе
  NoteDone(-1);

  SQLDB.Free;
  Application.OnMessage:=SaveMessageHandler;
  FOleInPlaceActiveObject:=nil;
  AllowedIPs.Free;
  AuthorizedDevices.Free;
  CategoriesList.Free;
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
  Handled := (IsDialogMessage(WebView.Handle, Msg) = true);
  if (Handled) and (not WebView.Busy) then begin
    if FOleInPlaceActiveObject = nil then begin
      Dispatch := WebView.Application;
      if Dispatch <> nil then begin
        Dispatch.QueryInterface(IOleInPlaceActiveObject, iOIPAO);
        if iOIPAO <> nil then
          FOleInPlaceActiveObject:=iOIPAO;
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
  WebView.OleObject.Document.getElementById('NoteTitle').innerHTML:=IDS_NEW_NOTE;
  WebView.OleObject.Document.getElementById('DaysAgo').innerHTML:=IDS_TODAY;
  WebView.OleObject.Document.getElementById('DateNote').innerHTML:=FormatDateTime('d mmm. h:nn', Now);
  WebView.OleObject.Document.getElementById('memo').innerHTML:='';
  if MemoFocus then
    WebView.OleObject.Document.getElementById('memo').focus;
  NoteIndex:=-1;
  LatestNote:='';
end;

procedure TMain.IdHTTPServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
const
  AuthorizationSuccessfulStatus = 'auth:ok';
  AuthorizationDeniedStatus = 'auth:denied';
  SuccessStatus = 'ok';
  ErrorStatus = 'error';
var
  i, j: integer; SQLTB: TSQLite3Statement;
  XMLDoc: IXMLDocument;
  XMLNode: IXMLNode;
  RequestDocument, RequestFileExt, AuthDeviceID, PostData: string;

  PostDataStream: TStringStream;
begin
  CoInitialize(nil);

  if (AllowAnyIPs = false) and (Pos(AContext.Binding.PeerIP, AllowedIPs.Text) = 0) then begin CoUninitialize; Exit; end;

  AResponseInfo.CustomHeaders.Add('Access-Control-Allow-Origin: *'); // Политика безопасности браузеров

  AuthDeviceID:='';
  for i:=0 to ARequestInfo.Params.Count - 1 do begin
    if AnsiLowerCase(ARequestInfo.Params.Names[i]) = 'id' then
      AuthDeviceID:=ARequestInfo.Params.ValueFromIndex[i];
  end;

  // Авторизация
  if (AuthDeviceID <> '') and (ARequestInfo.Document = '/api/auth') then begin

    if Pos(AuthDeviceID, AuthorizedDevices.Text) = 0 then begin

      // Если блокировка новых устройств отключена
      if BlockReqNewDevs = false then begin
        case MessageBox(Handle, PChar(Format(IDS_DEV_SYNC_CONFIRM, [AuthDeviceID])), PChar(Caption), 35) of
          6: if Pos(AuthDeviceID, AuthorizedDevices.Text) = 0 then begin
                AuthorizedDevices.Add(AuthDeviceID);
                AResponseInfo.ContentText:=AuthorizationSuccessfulStatus;

                SQLDB.Execute('CREATE TABLE IF NOT EXISTS Actions_' + AuthDeviceID + ' (Action TEXT, ID TIMESTAMP, Note TEXT, DateTime TIMESTAMP)');

            end;
          7: AResponseInfo.ContentText:=AuthorizationDeniedStatus;
        end;

      // Если блокировка новых устройств включена
      end else
        AResponseInfo.ContentText:=AuthorizationDeniedStatus;


    end else // Успешная авторизация
      AResponseInfo.ContentText:=AuthorizationSuccessfulStatus;

    RequestDocument:='none';
  end;

  // Новые действия
  if (AuthDeviceID <> '') and (ARequestInfo.Document = '/api/actions') then begin
    if Pos(AuthDeviceID + #13#10, AuthorizedDevices.Text) > 0 then begin
      SQLTB:=SQLDB.Prepare('SELECT * FROM Actions_' + AuthDeviceID);
      try
        AResponseInfo.ContentText:='<actions>' + #13#10;
        while SQLTB.Step = SQLITE_ROW do begin
          if SQLTB.ColumnText(0) = 'INSERT' then
            AResponseInfo.ContentText:=AResponseInfo.ContentText + #9 + '<insert id="' + SQLTB.ColumnText(1) + '" datetime="' + SQLTB.ColumnText(3) + '">' + SQLTB.ColumnText(2) + '</insert>' + #13#10;

          if SQLTB.ColumnText(0) = 'UPDATE' then
            AResponseInfo.ContentText:=AResponseInfo.ContentText + #9 + '<update id="' + SQLTB.ColumnText(1) + '" datetime="' + SQLTB.ColumnText(3) + '">' + SQLTB.ColumnText(2) + '</update>' + #13#10;

          if SQLTB.ColumnText(0) = 'DELETE' then
              AResponseInfo.ContentText:=AResponseInfo.ContentText + #9 + '<delete id="' + SQLTB.ColumnText(1) + '"></delete>' + #13#10;
        end;
      finally
        AResponseInfo.ContentText:=AResponseInfo.ContentText + '</actions>';
        SQLTB.Free;
      end;

    end else
      AResponseInfo.ContentText:=AuthorizationDeniedStatus;

    RequestDocument:='none';
  end;

  // Удаление полученных действий
  if (AuthDeviceID <> '') and (ARequestInfo.Document = '/api/received') then begin
    if Pos(AuthDeviceID + #13#10, AuthorizedDevices.Text) > 0 then begin
      SQLDB.Execute('DELETE FROM Actions_' + AuthDeviceID);
      AResponseInfo.ContentText:=SuccessStatus;
    end else
      AResponseInfo.ContentText:=AuthorizationDeniedStatus;

    RequestDocument:='none';
  end;

  // Все заметки
  if (AuthDeviceID <> '') and (ARequestInfo.Document = '/api/notes') then begin

    if Pos(AuthDeviceID + #13#10, AuthorizedDevices.Text) > 0 then begin
      SQLTB:=SQLDB.Prepare('SELECT * FROM Notes ORDER BY DateTime DESC');
      try
        AResponseInfo.ContentText:='<notes>' + #13#10;
        while SQLTB.Step = SQLITE_ROW do
          AResponseInfo.ContentText:=AResponseInfo.ContentText + #9 + '<note id="' + SQLTB.ColumnText(0) + '" datetime="' + SQLTB.ColumnText(2) + '">' + SQLTB.ColumnText(1) + '</note>' + #13#10;
      finally
        AResponseInfo.ContentText:=AResponseInfo.ContentText + '</notes>';
        SQLTB.Free;
      end;
    end else
      AResponseInfo.ContentText:=AuthorizationDeniedStatus;

    RequestDocument:='none';
  end;

  // Проверка соединения
  if ARequestInfo.Document = '/api/connecttest' then begin
    AResponseInfo.ContentText:=SuccessStatus;
    RequestDocument:='none';
  end;

  if (AuthDeviceID <> '') and (Pos(AuthDeviceID, AuthorizedDevices.Text) > 0) and (ARequestInfo.Document = '/api/syncnotes') and (ARequestInfo.CommandType = hcPOST) then begin
    // NoteDone(1); // Сохранение текущий заметки, без обновления списка
    Caption:=AppName + ' - ' + IDS_SYNC;
    Application.Title:=Caption;
    XMLDoc:=TXMLDocument.Create(nil);

    PostData:='';
    PostDataStream:=TStringStream.Create('', TEncoding.UTF8);
    try
      if ARequestInfo.PostStream <> nil then begin
        // Перемещаем данные из PostStream в строку
        ARequestInfo.PostStream.Position := 0;
        PostDataStream.LoadFromStream(ARequestInfo.PostStream);
        PostData:=PostDataStream.DataString;
      end;
    finally
      PostDataStream.Free;
    end;

    try
      XMLDoc:=LoadXMLData(PostData);
      XMLDoc.Active:=true;
      AResponseInfo.ContentText:=SuccessStatus;
    except;
      AResponseInfo.ContentText:=ErrorStatus;
    end;

    XMLNode:=XMLDoc.DocumentElement;
    for i:=0 to XMLNode.ChildNodes.Count - 1 do
      try
        if (XMLNode.ChildNodes[i].NodeName = 'insert') and (Trim( StrToCharCodes( CharCodesToStr(XMLNode.ChildNodes[i].NodeValue) ) ) <> '') then begin
          SQLDB.Execute('INSERT INTO Notes (ID, Note, DateTime) values("' + XMLNode.ChildNodes[i].Attributes['id'] + '", "' + XMLNode.ChildNodes[i].NodeValue + '", "' + XMLNode.ChildNodes[i].Attributes['datetime'] + '")');

          // Добавляем действие во все таблицы авторизованных устройств. Проверка доступности нужна для использования иных баз данных
          for j:=0 to AuthorizedDevices.Count - 1 do
            if (AuthorizedDevices.Strings[j] <> AuthDeviceID) and (SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[j])) then // Исключаем устройств отправляющее действие
              SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[j] + ' (Action, ID, Note, DateTime) values("INSERT", "' + XMLNode.ChildNodes[i].Attributes['id'] + '", "' + XMLNode.ChildNodes[i].NodeValue + '", "' + XMLNode.ChildNodes[i].Attributes['datetime'] + '")');
        end;

        if XMLNode.ChildNodes[i].NodeName = 'update' then begin
          SQLDB.Execute('UPDATE Notes SET Note="' + XMLNode.ChildNodes[i].NodeValue + '", DateTime="' + XMLNode.ChildNodes[i].Attributes['datetime'] + '" WHERE ID=' + XMLNode.ChildNodes[i].Attributes['id']);

          // Добавляем действие во все таблицы авторизованных устройств. Проверка доступности нужна для использования иных баз данных
          for j:=0 to AuthorizedDevices.Count - 1 do
           if (AuthorizedDevices.Strings[j] <> AuthDeviceID) and (SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[j])) then // Исключаем устройств отправляющее действие
              SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[j] + ' (Action, ID, Note, DateTime) values("UPDATE", "' + XMLNode.ChildNodes[i].Attributes['id'] + '", "' + XMLNode.ChildNodes[i].NodeValue + '", "' + XMLNode.ChildNodes[i].Attributes['datetime'] + '")');
        end;

        if XMLNode.ChildNodes[i].NodeName = 'delete' then begin
          SQLDB.Execute('DELETE FROM Notes WHERE ID=' + XMLNode.ChildNodes[i].Attributes['id']);
          // Добавляем действие во все доступные таблицы авторизованных устройств. Проверка доступности нужна для использования иных баз данных
          for j:=0 to AuthorizedDevices.Count - 1 do
            if (AuthorizedDevices.Strings[j] <> AuthDeviceID) and (SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[j])) then // Исключаем устройств отправляющее действие
              SQLDB.Execute('INSERT INTO Actions_' +  AuthorizedDevices.Strings[j] + ' (Action, ID) values("DELETE", "' + XMLNode.ChildNodes[i].Attributes['id'] + '")');
        end;
      except
      end;

    // Проблема с мгновенным выводом, поэтому просто обновляем страницу и LoadNotes загружается снова.
    WebView.Navigate(ExtractFilePath(ParamStr(0)) + 'UI\main.html');

    Caption:=AppName;
    Application.Title:=Caption;
    XMLDoc.Active:=false;
    RequestDocument:='none';
  end;

  if (RequestDocument <> 'none') then begin
    RequestDocument:=ExtractFilePath(ParamStr(0)) + '\webapp' + StringReplace(ARequestInfo.Document, '/', '\', [rfReplaceAll]);
    RequestDocument:=StringReplace(RequestDocument, '\\', '\', [rfReplaceAll]);
    if ARequestInfo.Document = '/webapp' then // по webapp отдаем главный файл
      RequestDocument:=ExtractFilePath(ParamStr(0)) + 'webapp\index.html';

    if FileExists(RequestDocument) then begin
      RequestFileExt:=AnsiLowerCase(ExtractFileExt(ARequestInfo.Document));

      if (RequestFileExt = '.html') or (RequestFileExt = '') then
        AResponseInfo.ContentType := 'text/html'
      else if RequestFileExt = '.js' then
        AResponseInfo.ContentType := 'application/javascript'
      else if RequestFileExt = '.css' then
        AResponseInfo.ContentType := 'text/css'
      else if RequestFileExt = '.png' then
        AResponseInfo.ContentType := 'image/png'
      else if RequestFileExt = '.txt' then
        AResponseInfo.ContentType := 'text/plain'
      else if ARequestInfo.Document = '/app.manifest' then // Устаревший метод, однако кто-то все еще может использовать устройства на iOS 12
        AResponseInfo.ContentType:='text/cache-manifest'
      else
        AResponseInfo.ContentType := 'application/octet-stream';

     AResponseInfo.ContentType:=AResponseInfo.ContentType + '; charset=utf-8';

      // AResponseInfo.ContentType:=IdHTTPServer.MIMETable.GetDefaultFileExt(RequestDocument); какие-то проблемы с ним

      //Memo1.Lines.Add(AResponseInfo.ContentType + ' ' + RequestFileExt + ' ' + RequestDocument);
      try
        AResponseInfo.ContentStream:=TFileStream.Create(RequestDocument, fmOpenRead or fmShareDenyWrite);
        except
        end;
    end else
      AResponseInfo.ContentText:=ErrorStatus;
  end;

  CoUninitialize;
end;

procedure TMain.PasteBtnClick(Sender: TObject);
begin
  keybd_event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), 0, 0);
  keybd_event(Ord('V'), MapVirtualKey(Ord('V'), 0), 0, 0);
  keybd_event(Ord('V'), MapVirtualKey(Ord('V'), 0), KEYEVENTF_KEYUP, 0);
  keybd_event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), KEYEVENTF_KEYUP, 0);
end;

procedure TMain.CopyBtnClick(Sender: TObject);
begin
  keybd_event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), 0, 0);
  keybd_event(Ord('C'), MapVirtualKey(Ord('C'), 0), 0, 0);
  keybd_event(Ord('C'), MapVirtualKey(Ord('C'), 0), KEYEVENTF_KEYUP, 0);
  keybd_event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), KEYEVENTF_KEYUP, 0);
end;

procedure TMain.CutBtnClick(Sender: TObject);
begin
  keybd_event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), 0, 0);
  keybd_event(Ord('X'), MapVirtualKey(Ord('X'), 0), 0, 0);
  keybd_event(Ord('X'), MapVirtualKey(Ord('X'), 0), KEYEVENTF_KEYUP, 0);
  keybd_event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), KEYEVENTF_KEYUP, 0);
end;

procedure TMain.AddStyle(FileName: string);
var
  HTMLDocument: IHTMLDocument2;
  StyleSheet: IHTMLStyleSheet;
  StyleSheetIndex: integer;
  StyleFile: TStringList;
begin
  if not FileExists(FileName) then Exit;
  StyleFile:=TStringList.Create;
  StyleFile.LoadFromFile(FileName);
  HTMLDocument:=WebView.Document as IHTMLDocument2;
  StyleSheetIndex:=HTMLDocument.styleSheets.length;
  if StyleSheetIndex > 31 then
    raise Exception.Create('Already have the maximum amount of CSS stylesheets');
  StyleSheet:=HTMLDocument.createStyleSheet('', StyleSheetIndex);
  StyleSheet.cssText:=StyleFile.Text;
  StyleFile.Free;
end;

procedure TMain.ExportNotes(FileName: string);
var
  i: integer; SQLTB: TSQLite3Statement; Notes: TStringList;
begin
  Notes:=TStringList.Create;
  SQLTB:=SQLDB.Prepare('SELECT * FROM Notes ORDER BY DateTime DESC');
  try
    while SQLTB.Step = SQLITE_ROW do
      Notes.Text:=Notes.Text + DateTimeToStr(UNIXToDateTime(StrToInt64(SQLTB.ColumnText(2)))) + #9 + SQLTB.ColumnText(2) + #9 + StringReplace( CharCodesToStr(SQLTB.ColumnText(1)), #10, ' \n ', [rfReplaceAll]) + #13#10;
  finally
    SQLTB.Free;
  end;
  Notes.SaveToFile(FileName, TEncoding.UTF8);
  Notes.Free;
end;

procedure TMain.ImportNotes(FileName: string);
var
  Notes: TStringList;
  i, j: integer;
  ImportNote, ImportNoteDateTime, ImportNoteText: string;
begin
  if not FileExists(FileName) then Exit;
  Notes:=TStringList.Create;

  try
    Notes.LoadFromFile(FileName, TEncoding.UTF8);
  except
    Notes.LoadFromFile(FileName);
  end;

  for i:=Notes.Count - 1 downto 0 do begin
    ImportNote:=Notes.Strings[i];
    Delete(ImportNote, 1, Pos(#9, ImportNote));
    if Pos(#9, ImportNote) > 0 then begin
      ImportNoteDateTime:=Copy(ImportNote, 1, Pos(#9, ImportNote) - 1);
      Delete(ImportNote, 1, Pos(#9, ImportNote));
      ImportNoteText:=StringReplace(ImportNote, ' \n ', #10, [rfReplaceAll]);
    end;

    if (Trim(ImportNoteDateTime) <> '') and (Trim(ImportNoteText) <> '') then begin
      SQLDB.Execute('INSERT INTO Notes (ID, Note, DateTime) values("' + ImportNoteDateTime + '", "' + StrToCharCodes(ImportNoteText) + '", "' + ImportNoteDateTime + '")');

      // Добавляем действия во все таблицы авторизованных устройств. Проверка доступности нужна для использования иных баз данных
      for j:=0 to AuthorizedDevices.Count - 1 do
        if SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[j]) then
          SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[j] + ' (Action, ID, Note, DateTime) values("INSERT", "' + ImportNoteDateTime + '", "' + StrToCharCodes(ImportNoteText) + '", "' + ImportNoteDateTime + '")');
    end;
  end;

  Notes.Free;
end;

initialization
 OleInitialize(nil);

finalization
 OleUninitialize;

end.
