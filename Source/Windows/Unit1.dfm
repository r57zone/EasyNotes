object Main: TMain
  Left = 0
  Top = 0
  ClientHeight = 446
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  TextHeight = 15
  object WebView: TWebBrowser
    Left = 0
    Top = 0
    Width = 601
    Height = 446
    Align = alClient
    TabOrder = 0
    OnBeforeNavigate2 = WebViewBeforeNavigate2
    OnDocumentComplete = WebViewDocumentComplete
    ControlData = {
      4C0000001D3E0000182E00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object IdHTTPServer: TIdHTTPServer
    Bindings = <>
    DefaultPort = 735
    OnCommandGet = IdHTTPServerCommandGet
    Left = 24
    Top = 8
  end
  object PopupMenu: TPopupMenu
    Left = 104
    Top = 8
    object CutBtn: TMenuItem
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      OnClick = CutBtnClick
    end
    object CopyBtn: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      OnClick = CopyBtnClick
    end
    object PasteBtn: TMenuItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      OnClick = PasteBtnClick
    end
  end
end
