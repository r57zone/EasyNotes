object Settings: TSettings
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 386
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object InterfaceGB: TGroupBox
    Left = 264
    Top = 8
    Width = 248
    Height = 122
    Caption = #1048#1085#1090#1077#1088#1092#1077#1081#1089
    TabOrder = 0
    object DarkThemeStartHourLbl: TLabel
      Left = 8
      Top = 65
      Width = 121
      Height = 15
      Caption = #1053#1072#1095#1072#1083#1086' '#1090#1105#1084#1085#1086#1081' '#1090#1077#1084#1099':'
    end
    object DarkThemeEndHourLbl: TLabel
      Left = 8
      Top = 95
      Width = 113
      Height = 15
      Caption = #1050#1086#1085#1077#1094' '#1090#1105#1084#1085#1086#1081' '#1090#1077#1084#1099':'
    end
    object DarkThemeCB: TCheckBox
      Left = 8
      Top = 20
      Width = 97
      Height = 17
      Caption = #1058#1105#1084#1085#1072#1103' '#1090#1077#1084#1072
      TabOrder = 0
      OnClick = DarkThemeCBClick
    end
    object ThemeTimeCB: TCheckBox
      Left = 8
      Top = 40
      Width = 201
      Height = 17
      Caption = #1058#1077#1084#1072' '#1074' '#1079#1072#1074#1080#1089#1080#1084#1086#1089#1090#1080' '#1086#1090' '#1074#1088#1077#1084#1077#1085#1080
      TabOrder = 1
      OnClick = ThemeTimeCBClick
    end
    object DarkThemeStartHourEdt: TEdit
      Left = 170
      Top = 63
      Width = 48
      Height = 23
      TabOrder = 2
    end
    object DarkThemeEndHourEdt: TEdit
      Left = 170
      Top = 92
      Width = 48
      Height = 23
      TabOrder = 3
    end
  end
  object SyncGB: TGroupBox
    Left = 9
    Top = 8
    Width = 248
    Height = 338
    Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1072#1094#1080#1103
    TabOrder = 1
    object PortLbl: TLabel
      Left = 8
      Top = 26
      Width = 31
      Height = 15
      Caption = #1055#1086#1088#1090':'
    end
    object AllowedIPsLbl: TLabel
      Left = 8
      Top = 92
      Width = 133
      Height = 15
      Caption = #1056#1072#1079#1088#1077#1096#1105#1085#1085#1099#1077' IP '#1072#1076#1088#1077#1089#1072':'
    end
    object AllowedDevsLbl: TLabel
      Left = 8
      Top = 184
      Width = 144
      Height = 15
      Caption = #1056#1072#1079#1088#1077#1096#1105#1085#1085#1099#1077' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072':'
    end
    object PortEdt: TEdit
      Left = 56
      Top = 23
      Width = 48
      Height = 23
      TabOrder = 0
    end
    object AllowedIPsMemo: TMemo
      Left = 8
      Top = 113
      Width = 232
      Height = 65
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object AllowAnyIPsCB: TCheckBox
      Left = 8
      Top = 52
      Width = 232
      Height = 34
      Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1072#1094#1080#1103' '#1089' '#1083#1102#1073#1099#1084#1080' IP ('#1085#1077#1073#1077#1079#1086#1087#1072#1089#1085#1086')'
      TabOrder = 1
      WordWrap = True
      OnClick = AllowAnyIPsCBClick
    end
    object AllowedDevsLB: TListBox
      Left = 8
      Top = 205
      Width = 232
      Height = 62
      ItemHeight = 15
      TabOrder = 3
      OnKeyDown = AllowedDevsLBKeyDown
      OnMouseDown = AllowedDevsLBMouseDown
    end
    object AddManualDev: TButton
      Left = 8
      Top = 273
      Width = 34
      Height = 17
      Caption = '+'
      TabOrder = 4
      OnClick = AddManualDevClick
    end
    object BlockReqNewDevsCB: TCheckBox
      Left = 8
      Top = 296
      Width = 232
      Height = 33
      Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1088#1086#1089#1099' '#1085#1086#1074#1099#1093' '#1091#1089#1090#1088#1086#1081#1089#1090#1074
      TabOrder = 6
      WordWrap = True
    end
    object RemManualDev: TButton
      Left = 44
      Top = 273
      Width = 34
      Height = 17
      Caption = '-'
      TabOrder = 5
      OnClick = RemManualDevClick
    end
  end
  object OkBtn: TButton
    Left = 8
    Top = 353
    Width = 75
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    OnClick = OkBtnClick
  end
  object CancelBtn: TButton
    Left = 88
    Top = 353
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = CancelBtnClick
  end
  object AboutBtn: TButton
    Left = 488
    Top = 354
    Width = 25
    Height = 25
    Caption = '?'
    TabOrder = 4
    OnClick = AboutBtnClick
  end
  object NotesGB: TGroupBox
    Left = 264
    Top = 228
    Width = 248
    Height = 54
    Caption = #1047#1072#1084#1077#1090#1082#1080
    TabOrder = 5
    object ImportBtn: TButton
      Left = 8
      Top = 20
      Width = 75
      Height = 25
      Caption = #1048#1084#1087#1086#1088#1090
      TabOrder = 0
      OnClick = ImportBtnClick
    end
    object ExportBtn: TButton
      Left = 88
      Top = 20
      Width = 75
      Height = 25
      Caption = #1069#1082#1089#1087#1086#1088#1090
      TabOrder = 1
      OnClick = ExportBtnClick
    end
  end
  object CategoriesGB: TGroupBox
    Left = 263
    Top = 132
    Width = 249
    Height = 94
    Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1080
    TabOrder = 6
    object CategoriesMemo: TMemo
      Left = 8
      Top = 20
      Width = 232
      Height = 65
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object AllowedDevsPM: TPopupMenu
    Left = 184
    Top = 216
    object AllowedDevRemBtn: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = AllowedDevRemBtnClick
    end
  end
  object OpenDialog: TOpenDialog
    Left = 288
    Top = 301
  end
  object SaveDialog: TSaveDialog
    Left = 360
    Top = 301
  end
end
