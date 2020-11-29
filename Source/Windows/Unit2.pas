unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, Menus, SQLite3, SQLiteTable3;

type
  TSettings = class(TForm)
    InterfaceGB: TGroupBox;
    SyncGB: TGroupBox;
    DarkThemeCB: TCheckBox;
    PortEdt: TEdit;
    PortLbl: TLabel;
    AllowedIPsLbl: TLabel;
    OkBtn: TButton;
    CancelBtn: TButton;
    AllowedIPsMemo: TMemo;
    AboutBtn: TButton;
    AllowAnyIPsCB: TCheckBox;
    ThemeTimeCB: TCheckBox;
    AllowedDevsPM: TPopupMenu;
    AllowedDevRemBtn: TMenuItem;
    AllowedDevsLB: TListBox;
    AllowedDevsLbl: TLabel;
    AddManualDev: TButton;
    BlockReqNewDevsCB: TCheckBox;
    RemManualDev: TButton;
    NotesGB: TGroupBox;
    ImportBtn: TButton;
    ExportBtn: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure AllowAnyIPsCBClick(Sender: TObject);
    procedure ThemeTimeCBClick(Sender: TObject);
    procedure DarkThemeCBClick(Sender: TObject);
    procedure AllowedDevRemBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AllowedDevsLBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AllowedDevsLBKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AddManualDevClick(Sender: TObject);
    procedure RemManualDevClick(Sender: TObject);
    procedure ExportBtnClick(Sender: TObject);
    procedure ImportBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Settings: TSettings;

implementation

uses Unit1;

{$R *.dfm}

procedure TSettings.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
begin
  SetWindowLong(PortEdt.Handle, GWL_STYLE, GetWindowLong(PortEdt.Handle, GWL_STYLE) or ES_NUMBER);

  Caption:=ID_SETTINGS;
  InterfaceGB.Caption:=ID_INTERFACE;
  DarkThemeCB.Caption:=ID_DARK_THEME;
  ThemeTimeCB.Caption:=IDS_THEME_TIME;
  SyncGB.Caption:=ID_SYNCHRONIZATION;
  PortLbl.Caption:=ID_SYNC_PORT;
  AllowAnyIPsCB.Caption:=ID_SYNC_WITH_ANY_IPS;
  AllowedIPSLbl.Caption:=ID_ALLOW_IPS;
  AllowedDevsLbl.Caption:=ID_ALLOW_DEVS;
  AllowedDevRemBtn.Caption:=ID_ALLOW_DEV_REM;
  BlockReqNewDevsCB.Caption:=ID_BLOCK_REQUEST_NEW_DEVS;

  NotesGB.Caption:=ID_NOTES;
  OpenDialog.Filter:=ID_NOTES + ' (*.ntxt)|*.ntxt';
  SaveDialog.Filter:=OpenDialog.Filter;
  SaveDialog.DefaultExt:=SaveDialog.Filter;
  ImportBtn.Caption:=ID_IMPORT;
  ExportBtn.Caption:=ID_EXPORT;

  OkBtn.Caption:=ID_OK;
  CancelBtn.Caption:=ID_CANCEL;

  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
  PortEdt.Text:=IntToStr(Main.IdHTTPServer.DefaultPort);
  DarkThemeCB.Checked:=UseDarkTheme;
  ThemeTimeCB.Checked:=UseThemeTime;
  if AllowAnyIPs then begin
    AllowAnyIPsCB.Checked:=true;
    AllowedIPsMemo.Enabled:=false;
  end;
  BlockReqNewDevsCB.Checked:=BlockReqNewDevs;
  AllowedIPsMemo.Text:=AllowedIPs.Text;
  Ini.Free;
end;

procedure TSettings.CancelBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TSettings.AboutBtnClick(Sender: TObject);
begin
  Application.MessageBox(PChar(Main.Caption + ' 1.0' + #13#10 +
    IDS_LAST_UPDATE + ' 27.11.20' + #13#10 +
    'https://r57zone.github.io' + #13#10 +
    'r57zone@gmail.com'), PChar(Main.Caption), MB_ICONINFORMATION);
end;

procedure TSettings.OkBtnClick(Sender: TObject);
var
  Ini: TIniFile; ParamsStr: string; i: integer;
begin
  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
  Ini.WriteInteger('Sync', 'Port', StrToIntDef(PortEdt.Text, 735));
  if ThemeTimeCB.Checked then
    DarkThemeCB.Checked:=false;
  Ini.WriteBool('Main', 'DarkTheme', DarkThemeCB.Checked);
  Ini.WriteBool('Main', 'ThemeTime', ThemeTimeCB.Checked);
  Ini.WriteBool('Sync', 'AllowAnyIPs', AllowAnyIPsCB.Checked);
  Ini.WriteBool('Sync', 'BlockRequestNewDevs', BlockReqNewDevsCB.Checked);
  AllowedIPsMemo.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + AllowedIPsFile);
  Ini.Free;
  Main.IdHTTPServer.Active:=false;
  for i:=1 to ParamCount do
    if (LowerCase(ParamStr(i)) = '-db') and (Trim(ParamStr(i + 1)) <> '') then begin
      ParamsStr:=' -db ' + ParamStr(i + 1);
      break;
    end;
  WinExec(PChar(ParamStr(0) + ' -show' + ParamsStr), SW_SHOW);
  Main.Close;
end;

procedure TSettings.AllowAnyIPsCBClick(Sender: TObject);
begin
  AllowedIPsMemo.Enabled:=not AllowAnyIPsCB.Checked;
end;

procedure TSettings.ThemeTimeCBClick(Sender: TObject);
begin
  if (ThemeTimeCB.Checked) and (DarkThemeCB.Checked) then
    DarkThemeCB.Checked:=false;
end;

procedure TSettings.DarkThemeCBClick(Sender: TObject);
begin
  if (DarkThemeCB.Checked) and (ThemeTimeCB.Checked) then
    ThemeTimeCB.Checked:=false;
end;

procedure TSettings.AllowedDevRemBtnClick(Sender: TObject);
begin
  if AllowedDevsLB.ItemIndex <> -1 then begin
    if SQLDB.TableExists('Actions_' + AllowedDevsLB.Items[AllowedDevsLB.ItemIndex]) then
      SQLDB.ExecSQL('DROP TABLE Actions_' + AllowedDevsLB.Items[AllowedDevsLB.ItemIndex]);

    AllowedDevsLB.Items.Delete(AllowedDevsLB.ItemIndex);
    AuthorizedDevices.Text:=AllowedDevsLB.Items.Text;
  end;
end;

procedure TSettings.FormShow(Sender: TObject);
begin
  AllowedDevsLB.Items.Text:=AuthorizedDevices.Text;
end;

procedure TSettings.AllowedDevsLBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbRight) and (AllowedDevsLB.ItemIndex <> -1) then
    AllowedDevsPM.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TSettings.AllowedDevsLBKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: integer; SQLTB: TSQLiteTable; TablesNames: string;
begin
  if (Key = VK_DELETE) or (Key = VK_DECIMAL) then
    AllowedDevRemBtn.Click;

  if (Key = VK_F7) then begin
    SQLTB:=SQLDB.GetTable('SELECT name FROM sqlite_master WHERE name <> "Notes"');
    for i:=0 to SQLTB.Count - 1 do begin
      TablesNames:=TablesNames + SQLTB.FieldAsString(0) + #13#10;
      SQLTB.Next;
    end;
    SQLTB.Free;
    Application.MessageBox(PChar('Tables: ' + IntToStr(SQLTB.Count) + #13#10 + Trim(TablesNames)), PChar(Main.Caption), MB_ICONINFORMATION);
  end;
end;

procedure TSettings.AddManualDevClick(Sender: TObject);
var
  AllowDeviceName: string;
begin
  if InputQuery(Main.Caption, ID_ENTER_DEV_ID, AllowDeviceName) and (Trim(AllowDeviceName) <> '') then begin
    AllowedDevsLB.Items.Add(AllowDeviceName);
    AuthorizedDevices.Text:=AllowedDevsLB.Items.Text;

    if not SQLDB.TableExists('Actions_' + AllowDeviceName) then
      SQLDB.ExecSQL('CREATE TABLE Actions_' + AllowDeviceName + ' (Action TEXT, ID TIMESTAMP, Note TEXT, DateTime TIMESTAMP)');
  end;
end;

procedure TSettings.RemManualDevClick(Sender: TObject);
begin
  AllowedDevRemBtn.Click;
end;

procedure TSettings.ImportBtnClick(Sender: TObject);
begin
  if OpenDialog.Execute then begin
    Main.ImportNotes(OpenDialog.FileName);
    Main.LoadNotes;
    Application.MessageBox(PChar(ID_DONE), PChar(Main.Caption), MB_ICONINFORMATION);
  end;
end;

procedure TSettings.ExportBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute then begin
    Main.ExportNotes(SaveDialog.FileName);
    Application.MessageBox(PChar(ID_DONE), PChar(Main.Caption), MB_ICONINFORMATION);
  end;
end;

end.
