object dlgEditPatient: TdlgEditPatient
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Patient'
  ClientHeight = 217
  ClientWidth = 529
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
  object pnlBottom: TPanel
    Left = 0
    Top = 168
    Width = 529
    Height = 49
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'pnlBottom'
    Ctl3D = True
    ParentCtl3D = False
    ShowCaption = False
    TabOrder = 6
    object btnOk: TButton
      Left = 349
      Top = 11
      Width = 75
      Height = 25
      Caption = '&Ok'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 430
      Top = 11
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object edName: TLabeledEdit
    Left = 24
    Top = 32
    Width = 233
    Height = 21
    EditLabel.Width = 63
    EditLabel.Height = 13
    EditLabel.Caption = 'Patient name'
    TabOrder = 0
  end
  object edTask: TLabeledEdit
    Left = 272
    Top = 128
    Width = 233
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = 'Task'
    TabOrder = 5
  end
  object edCompany: TLabeledEdit
    Left = 24
    Top = 128
    Width = 233
    Height = 21
    EditLabel.Width = 45
    EditLabel.Height = 13
    EditLabel.Caption = 'Company'
    TabOrder = 4
  end
  object edDateOfBirth: TLabeledEdit
    Left = 272
    Top = 32
    Width = 89
    Height = 21
    EditLabel.Width = 61
    EditLabel.Height = 13
    EditLabel.Caption = 'Date of birth'
    TabOrder = 1
  end
  object edId: TLabeledEdit
    Left = 376
    Top = 32
    Width = 89
    Height = 21
    EditLabel.Width = 10
    EditLabel.Height = 13
    EditLabel.Caption = 'Id'
    TabOrder = 2
  end
  object edIdDocument: TLabeledEdit
    Left = 24
    Top = 80
    Width = 233
    Height = 21
    EditLabel.Width = 127
    EditLabel.Height = 13
    EditLabel.Caption = 'Identity document number'
    TabOrder = 3
  end
end
