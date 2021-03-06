object Settings: TSettings
  Left = 192
  Top = 125
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 357
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object InterfaceGB: TGroupBox
    Left = 272
    Top = 8
    Width = 257
    Height = 65
    Caption = #1048#1085#1090#1077#1088#1092#1077#1081#1089
    TabOrder = 0
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
  end
  object SyncGB: TGroupBox
    Left = 8
    Top = 8
    Width = 257
    Height = 310
    Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1072#1094#1080#1103
    TabOrder = 1
    object PortLbl: TLabel
      Left = 8
      Top = 26
      Width = 28
      Height = 13
      Caption = #1055#1086#1088#1090':'
    end
    object AllowedIPsLbl: TLabel
      Left = 8
      Top = 84
      Width = 126
      Height = 13
      Caption = #1056#1072#1079#1088#1077#1096#1105#1085#1085#1099#1077' IP '#1072#1076#1088#1077#1089#1072':'
    end
    object AllowedDevsLbl: TLabel
      Left = 8
      Top = 176
      Width = 134
      Height = 13
      Caption = #1056#1072#1079#1088#1077#1096#1105#1085#1085#1099#1077' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072':'
    end
    object PortEdt: TEdit
      Left = 40
      Top = 24
      Width = 49
      Height = 21
      TabOrder = 0
    end
    object AllowedIPsMemo: TMemo
      Left = 8
      Top = 104
      Width = 241
      Height = 65
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object AllowAnyIPsCB: TCheckBox
      Left = 8
      Top = 55
      Width = 241
      Height = 17
      Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1072#1094#1080#1103' '#1089' '#1083#1102#1073#1099#1084#1080' IP ('#1085#1077#1073#1077#1079#1086#1087#1072#1089#1085#1086')'
      TabOrder = 1
      OnClick = AllowAnyIPsCBClick
    end
    object AllowedDevsLB: TListBox
      Left = 8
      Top = 195
      Width = 241
      Height = 62
      ItemHeight = 13
      TabOrder = 3
      OnKeyDown = AllowedDevsLBKeyDown
      OnMouseDown = AllowedDevsLBMouseDown
    end
    object AddManualDev: TButton
      Left = 7
      Top = 260
      Width = 34
      Height = 17
      Caption = '+'
      TabOrder = 4
      OnClick = AddManualDevClick
    end
    object BlockReqNewDevsCB: TCheckBox
      Left = 8
      Top = 285
      Width = 241
      Height = 17
      Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1088#1086#1089#1099' '#1085#1086#1074#1099#1093' '#1091#1089#1090#1088#1086#1081#1089#1090#1074
      TabOrder = 6
    end
    object RemManualDev: TButton
      Left = 40
      Top = 260
      Width = 34
      Height = 17
      Caption = '-'
      TabOrder = 5
      OnClick = RemManualDevClick
    end
  end
  object OkBtn: TButton
    Left = 8
    Top = 325
    Width = 75
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    OnClick = OkBtnClick
  end
  object CancelBtn: TButton
    Left = 88
    Top = 325
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = CancelBtnClick
  end
  object AboutBtn: TButton
    Left = 504
    Top = 325
    Width = 25
    Height = 25
    Caption = '?'
    TabOrder = 4
    OnClick = AboutBtnClick
  end
  object NotesGB: TGroupBox
    Left = 272
    Top = 80
    Width = 257
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
  object AllowedDevsPM: TPopupMenu
    Left = 24
    Top = 120
    object AllowedDevRemBtn: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = AllowedDevRemBtnClick
    end
  end
  object OpenDialog: TOpenDialog
    Left = 456
    Top = 96
  end
  object SaveDialog: TSaveDialog
    Left = 488
    Top = 96
  end
end
