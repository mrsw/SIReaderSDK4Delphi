object dlgTestResults: TdlgTestResults
  Left = 0
  Top = 0
  Caption = 'Test Results'
  ClientHeight = 433
  ClientWidth = 762
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
  object imgTestImage: TImage
    Left = 496
    Top = 29
    Width = 249
    Height = 300
    Center = True
    Proportional = True
    Stretch = True
  end
  object Label1: TLabel
    Left = 16
    Top = 64
    Width = 69
    Height = 13
    Caption = 'Full result text'
  end
  object lblImagesCount: TLabel
    Left = 496
    Top = 13
    Width = 69
    Height = 13
    Caption = 'Full result text'
  end
  object edPDFResultFullPath: TLabeledEdit
    Left = 16
    Top = 29
    Width = 457
    Height = 21
    EditLabel.Width = 96
    EditLabel.Height = 13
    EditLabel.Caption = 'PDF Result Full Path'
    ReadOnly = True
    TabOrder = 0
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 384
    Width = 762
    Height = 49
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'pnlBottom'
    Ctl3D = True
    ParentCtl3D = False
    ShowCaption = False
    TabOrder = 1
    object btnOk: TButton
      Left = 343
      Top = 11
      Width = 75
      Height = 25
      Caption = '&Ok'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
  object edFullResultText: TMemo
    Left = 16
    Top = 80
    Width = 457
    Height = 289
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object btnPreviousImage: TButton
    Left = 496
    Top = 344
    Width = 122
    Height = 25
    Action = actPreviousTestImage
    TabOrder = 3
  end
  object btnNExtImage: TButton
    Left = 624
    Top = 344
    Width = 121
    Height = 25
    Action = actNextTestImage
    TabOrder = 4
  end
  object alCommands: TActionList
    Left = 48
    Top = 104
    object actNextTestImage: TAction
      Caption = 'Next'
      OnUpdate = actNextTestImageUpdate
    end
    object actPreviousTestImage: TAction
      Caption = 'Previous'
      OnUpdate = actPreviousTestImageUpdate
    end
  end
end
