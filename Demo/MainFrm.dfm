object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Screen Reader SDK Test'
  ClientHeight = 595
  ClientWidth = 681
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 280
    Top = 223
    Width = 57
    Height = 13
    Caption = 'Operators'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 223
    Width = 84
    Height = 13
    Caption = 'Available tests'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 480
    Top = 223
    Width = 47
    Height = 13
    Caption = 'Patients'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbOperators: TListBox
    Left = 280
    Top = 240
    Width = 185
    Height = 175
    ItemHeight = 13
    TabOrder = 7
  end
  object lbAvailableTests: TListBox
    Left = 16
    Top = 240
    Width = 249
    Height = 175
    ItemHeight = 13
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 16
    Width = 649
    Height = 193
    Caption = 'Reader process'
    TabOrder = 0
    object chUiVisible: TCheckBox
      Left = 510
      Top = 42
      Width = 97
      Height = 17
      Caption = 'UI Visible'
      TabOrder = 2
      OnClick = chUiVisibleClick
    end
    object btnOpenUI: TButton
      Left = 510
      Top = 120
      Width = 121
      Height = 25
      Caption = 'Open'
      TabOrder = 3
      OnClick = btnOpenUIClick
    end
    object btnCloseUI: TButton
      Left = 510
      Top = 151
      Width = 121
      Height = 25
      Caption = 'Close'
      TabOrder = 4
      OnClick = btnCloseUIClick
    end
    object edReaderFileName: TLabeledEdit
      Left = 16
      Top = 45
      Width = 457
      Height = 21
      EditLabel.Width = 81
      EditLabel.Height = 13
      EditLabel.Caption = 'Reader FileName'
      ReadOnly = True
      TabOrder = 0
    end
    object edReaderFilePath: TLabeledEdit
      Left = 16
      Top = 97
      Width = 457
      Height = 21
      EditLabel.Width = 76
      EditLabel.Height = 13
      EditLabel.Caption = 'Reader FilePath'
      ReadOnly = True
      TabOrder = 1
    end
    object edScanner: TLabeledEdit
      Left = 16
      Top = 153
      Width = 273
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = 'Scanner'
      TabOrder = 5
    end
    object btnGetActiveScanner: TButton
      Left = 305
      Top = 151
      Width = 81
      Height = 25
      Action = actGetActiveScanner
      TabOrder = 6
    end
    object btnSetActiveScanner: TButton
      Left = 392
      Top = 151
      Width = 81
      Height = 25
      Action = actSetActiveScanner
      TabOrder = 7
    end
    object chAutoOpenReader: TCheckBox
      Left = 510
      Top = 65
      Width = 121
      Height = 17
      Caption = 'Auto open reader'
      TabOrder = 8
      OnClick = chAutoOpenReaderClick
    end
  end
  object btnRefreshAvailableTests: TButton
    Left = 16
    Top = 429
    Width = 249
    Height = 25
    Action = actRefreshAvailableTests
    TabOrder = 2
  end
  object btnRefreshOperators: TButton
    Left = 280
    Top = 429
    Width = 185
    Height = 25
    Action = actRefreshOperators
    TabOrder = 8
  end
  object lbPatients: TListBox
    Left = 480
    Top = 240
    Width = 185
    Height = 175
    ItemHeight = 13
    TabOrder = 13
    OnDblClick = lbPatientsDblClick
  end
  object btnRefreshPatients: TButton
    Left = 480
    Top = 429
    Width = 185
    Height = 25
    Action = actRefreshPatients
    TabOrder = 14
  end
  object btnAddOperator: TButton
    Left = 280
    Top = 460
    Width = 185
    Height = 25
    Action = actAddOperator
    TabOrder = 9
  end
  object btnRemoveOperator: TButton
    Left = 280
    Top = 491
    Width = 185
    Height = 25
    Action = actRemoveOperator
    TabOrder = 10
  end
  object btnAddPatient: TButton
    Left = 480
    Top = 460
    Width = 185
    Height = 25
    Action = actAddPatient
    TabOrder = 15
  end
  object btnRemovePatient: TButton
    Left = 480
    Top = 491
    Width = 185
    Height = 25
    Action = actRemovePatient
    TabOrder = 16
  end
  object btnSetActiveTest: TButton
    Left = 16
    Top = 491
    Width = 249
    Height = 25
    Action = actSetActiveTest
    TabOrder = 4
  end
  object btnSetActiveoperator: TButton
    Left = 280
    Top = 553
    Width = 185
    Height = 25
    Action = actSetActiveOperator
    TabOrder = 12
  end
  object btnSetActivePatient: TButton
    Left = 480
    Top = 553
    Width = 185
    Height = 25
    Action = actSetActivePatient
    TabOrder = 18
  end
  object btnGetActiveOperator: TButton
    Left = 280
    Top = 522
    Width = 185
    Height = 25
    Action = actGetActiveOperator
    TabOrder = 11
  end
  object btnGetActivePatient: TButton
    Left = 480
    Top = 522
    Width = 185
    Height = 25
    Action = actGetActivePatient
    TabOrder = 17
  end
  object btnGetActiveTest: TButton
    Left = 16
    Top = 460
    Width = 249
    Height = 25
    Action = actGetActiveTest
    TabOrder = 3
  end
  object btnReadTest: TButton
    Left = 16
    Top = 522
    Width = 249
    Height = 25
    Action = actReadTest
    TabOrder = 5
  end
  object btnShowLastTestResult: TButton
    Left = 16
    Top = 553
    Width = 249
    Height = 25
    Action = actShowLastTestResults
    TabOrder = 6
  end
  object alCommands: TActionList
    Left = 48
    Top = 253
    object actRefreshOperators: TAction
      Category = 'Operators'
      Caption = 'Refresh Operators'
      OnExecute = actRefreshOperatorsExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actRefreshAvailableTests: TAction
      Category = 'Tests'
      Caption = 'Refresh Available Tests'
      OnExecute = actRefreshAvailableTestsExecute
    end
    object actRefreshPatients: TAction
      Category = 'Patients'
      Caption = 'Refresh Patients'
      OnExecute = actRefreshPatientsExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actAddOperator: TAction
      Category = 'Operators'
      Caption = 'Add Operator'
      OnExecute = actAddOperatorExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actRemoveOperator: TAction
      Category = 'Operators'
      Caption = 'Remove Operator'
      OnExecute = actRemoveOperatorExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actAddPatient: TAction
      Category = 'Patients'
      Caption = 'Add Patient'
      OnExecute = actAddPatientExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actRemovePatient: TAction
      Category = 'Patients'
      Caption = 'Remove Patient'
      OnExecute = actRemovePatientExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actSetActiveTest: TAction
      Category = 'Tests'
      Caption = 'Set Active Test'
      OnExecute = actSetActiveTestExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actSetActiveOperator: TAction
      Category = 'Operators'
      Caption = 'Set Active Operator'
      OnExecute = actSetActiveOperatorExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actSetActivePatient: TAction
      Category = 'Patients'
      Caption = 'Set Active Patient'
      OnExecute = actSetActivePatientExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actGetActivePatient: TAction
      Category = 'Patients'
      Caption = 'Get Active Patient'
      OnExecute = actGetActivePatientExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actGetActiveOperator: TAction
      Category = 'Operators'
      Caption = 'Get Active Operator'
      OnUpdate = actReaderOpenedUpdate
    end
    object actGetActiveTest: TAction
      Category = 'Tests'
      Caption = 'Get Active Test'
      OnExecute = actGetActiveTestExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actReadTest: TAction
      Category = 'Tests'
      Caption = 'Read Test'
      OnExecute = actReadTestExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actShowLastTestResults: TAction
      Category = 'Tests'
      Caption = 'Show Last Test Results'
      OnExecute = actShowLastTestResultsExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actGetActiveScanner: TAction
      Category = 'Scanner'
      Caption = 'Get'
      OnExecute = actGetActiveScannerExecute
      OnUpdate = actReaderOpenedUpdate
    end
    object actSetActiveScanner: TAction
      Category = 'Scanner'
      Caption = 'Set'
      OnExecute = actSetActiveScannerExecute
      OnUpdate = actReaderOpenedUpdate
    end
  end
end
