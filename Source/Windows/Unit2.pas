unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles;

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
    procedure FormCreate(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure AllowAnyIPsCBClick(Sender: TObject);
    procedure ThemeTimeCBClick(Sender: TObject);
    procedure DarkThemeCBClick(Sender: TObject);
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
  AllowedIPsMemo.Text:=AllowIPs.Text;
  Ini.Free;
end;

procedure TSettings.CancelBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TSettings.AboutBtnClick(Sender: TObject);
begin
  Application.MessageBox(PChar(Caption + ' 0.8.6' + #13#10 +
    IDS_LAST_UPDATE + ' 28.09.20' + #13#10 +
    'https://r57zone.github.io' + #13#10 +
    'r57zone@gmail.com'), PChar(Caption), MB_ICONINFORMATION);
end;

procedure TSettings.OkBtnClick(Sender: TObject);
var
  Ini: TIniFile;
begin
  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
  Ini.WriteInteger('Sync', 'Port', StrToIntDef(PortEdt.Text, 735));
  if ThemeTimeCB.Checked then
    DarkThemeCB.Checked:=false;
  Ini.WriteBool('Main', 'DarkTheme', DarkThemeCB.Checked);
  Ini.WriteBool('Main', 'ThemeTime', ThemeTimeCB.Checked);
  Ini.WriteBool('Sync', 'AllowAnyIPs', AllowAnyIPsCB.Checked);
  AllowedIPsMemo.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'AllowIPs.txt');
  Ini.Free;
  Main.IdHTTPServer.Active:=false;
  WinExec(PChar(ParamStr(0) + ' -show'), SW_SHOW);
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

end.
