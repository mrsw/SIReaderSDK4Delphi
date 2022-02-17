object dlgEditOperator: TdlgEditOperator
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Operator'
  ClientHeight = 265
  ClientWidth = 291
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 110
    Width = 21
    Height = 13
    Caption = 'Test'
  end
  object edName: TLabeledEdit
    Left = 24
    Top = 32
    Width = 233
    Height = 21
    EditLabel.Width = 73
    EditLabel.Height = 13
    EditLabel.Caption = 'Operator name'
    TabOrder = 0
  end
  object edLocation: TLabeledEdit
    Left = 24
    Top = 80
    Width = 233
    Height = 21
    EditLabel.Width = 40
    EditLabel.Height = 13
    EditLabel.Caption = 'Location'
    TabOrder = 1
  end
  object cbTest: TComboBox
    Left = 24
    Top = 126
    Width = 233
    Height = 21
    Style = csDropDownList
    TabOrder = 2
  end
  object edLot: TLabeledEdit
    Left = 24
    Top = 176
    Width = 233
    Height = 21
    EditLabel.Width = 15
    EditLabel.Height = 13
    EditLabel.Caption = 'Lot'
    TabOrder = 3
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 216
    Width = 291
    Height = 49
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'pnlBottom'
    Ctl3D = True
    ParentCtl3D = False
    ShowCaption = False
    TabOrder = 4
    object btnOk: TButton
      Left = 101
      Top = 11
      Width = 75
      Height = 25
      Caption = '&Ok'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 182
      Top = 11
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
end
