unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, ExtCtrls,

  SIScreenReader,
  SIScreenReader.Classes
  ;



type
  TfrmMain = class(TForm)
    lbOperators: TListBox;
    Label1: TLabel;
    lbAvailableTests: TListBox;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    chUiVisible: TCheckBox;
    btnOpenUI: TButton;
    btnCloseUI: TButton;
    btnRefreshAvailableTests: TButton;
    btnRefreshOperators: TButton;
    alCommands: TActionList;
    actRefreshOperators: TAction;
    actRefreshAvailableTests: TAction;
    lbPatients: TListBox;
    Label3: TLabel;
    btnRefreshPatients: TButton;
    actRefreshPatients: TAction;
    btnAddOperator: TButton;
    btnRemoveOperator: TButton;
    btnAddPatient: TButton;
    btnRemovePatient: TButton;
    actAddOperator: TAction;
    actRemoveOperator: TAction;
    actAddPatient: TAction;
    actRemovePatient: TAction;
    btnSetActiveTest: TButton;
    actSetActiveTest: TAction;
    btnSetActiveoperator: TButton;
    actSetActiveOperator: TAction;
    btnSetActivePatient: TButton;
    actSetActivePatient: TAction;
    btnGetActiveOperator: TButton;
    btnGetActivePatient: TButton;
    actGetActivePatient: TAction;
    actGetActiveOperator: TAction;
    actGetActiveTest: TAction;
    btnGetActiveTest: TButton;
    edReaderFileName: TLabeledEdit;
    edReaderFilePath: TLabeledEdit;
    btnReadTest: TButton;
    actReadTest: TAction;
    btnShowLastTestResult: TButton;
    actShowLastTestResults: TAction;
    edScanner: TLabeledEdit;
    btnGetActiveScanner: TButton;
    btnSetActiveScanner: TButton;
    actGetActiveScanner: TAction;
    actSetActiveScanner: TAction;
    chAutoOpenReader: TCheckBox;
    procedure btnOpenUIClick(Sender: TObject);
    procedure btnCloseUIClick(Sender: TObject);
    procedure btnRefreshAvailableTestsClick(Sender: TObject);
    procedure actRefreshOperatorsExecute(Sender: TObject);
    procedure actRefreshAvailableTestsExecute(Sender: TObject);
    procedure actReaderOpenedUpdate(Sender: TObject);
    procedure actAddOperatorExecute(Sender: TObject);
    procedure actRemoveOperatorExecute(Sender: TObject);
    procedure actRefreshPatientsExecute(Sender: TObject);
    procedure actAddPatientExecute(Sender: TObject);
    procedure actRemovePatientExecute(Sender: TObject);
    procedure lbPatientsDblClick(Sender: TObject);
    procedure actGetActiveTestExecute(Sender: TObject);
    procedure actSetActiveTestExecute(Sender: TObject);
    procedure actSetActiveOperatorExecute(Sender: TObject);
    procedure actSetActivePatientExecute(Sender: TObject);
    procedure actGetActivePatientExecute(Sender: TObject);
    procedure actGetActiveScannerExecute(Sender: TObject);
    procedure actSetActiveScannerExecute(Sender: TObject);
    procedure chUiVisibleClick(Sender: TObject);
    procedure chAutoOpenReaderClick(Sender: TObject);
    procedure actReadTestExecute(Sender: TObject);
    procedure actShowLastTestResultsExecute(Sender: TObject);
  private
    FScreenReader: TSIScreenReader;
    procedure AddOperator;
    procedure AddPatient;
    procedure FillAvailableTests;
    procedure FillOperatorsList;
    procedure FillPatientsList;
    procedure RemoveOperator;
    procedure RemovePatient;
    procedure ShowPatientDataByName(AName: string);
    procedure ShowPatientDataByIdDocument(AIdDocument: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  EditOperatorDlg,
  EditPatientDlg,
  TestResultsDlg
  ;


{ TForm1 }

procedure TfrmMain.actAddOperatorExecute(Sender: TObject);
begin
  AddOperator;
end;

procedure TfrmMain.actRefreshAvailableTestsExecute(Sender: TObject);
begin
  FScreenReader.RefreshAvailableTests;

  FillAvailableTests;
end;

procedure TfrmMain.actRefreshOperatorsExecute(Sender: TObject);
begin
  FScreenReader.RefreshOperators;

  FillOperatorsList;
end;

procedure TfrmMain.actRefreshPatientsExecute(Sender: TObject);
begin
  FScreenReader.RefreshPatients;

  FillPatientsList;
end;

procedure TfrmMain.actAddPatientExecute(Sender: TObject);
begin
  AddPatient;
end;

procedure TfrmMain.actGetActivePatientExecute(Sender: TObject);
var
  ActivePatient: TSIScreenReaderPatient;
begin
  ActivePatient := FScreenReader.ActivePatient;

  if Assigned(ActivePatient) then
    lbPatients.ItemIndex := lbPatients.Items.IndexOf(ActivePatient.Name)
  else
    lbPatients.ItemIndex := -1;
end;

procedure TfrmMain.actGetActiveScannerExecute(Sender: TObject);
begin
  edScanner.Text := FSCreenREader.ActiveScanner;
end;

procedure TfrmMain.actGetActiveTestExecute(Sender: TObject);
begin
  lbAvailableTests.ItemIndex := lbAvailableTests.Items.IndexOf(FScreenReader.ActiveTest);
end;

procedure TfrmMain.actReaderOpenedUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := FScreenReader.OpenReaderWhenNeeded or FScreenReader.ReaderOpened;
end;

procedure TfrmMain.actReadTestExecute(Sender: TObject);
begin
  FScreenReader.ReadTest;

  actShowLastTestResults.Execute;
end;

procedure TfrmMain.actRemoveOperatorExecute(Sender: TObject);
begin
  RemoveOperator;
end;

procedure TfrmMain.actRemovePatientExecute(Sender: TObject);
begin
  RemovePatient;
end;

procedure TfrmMain.actSetActiveOperatorExecute(Sender: TObject);
begin
  if lbOperators.ItemIndex = -1 then
  begin
    MessageDlg('You must select an operator first.', mtInformation, [mbOK], 0);
    exit;
  end;

  FScreenReader.ActiveOperator := TSIScreenReaderOperator(lbOperators.Items.Objects[lbOperators.ItemIndex]);
end;

procedure TfrmMain.actSetActivePatientExecute(Sender: TObject);
begin
  if lbPatients.ItemIndex = -1 then
  begin
    MessageDlg('You must select a patient first.', mtInformation, [mbOk], 0);
    exit;
  end;

  FScreenReader.ActivePatient := TSIScreenReaderPatient(lbPatients.Items.Objects[lbPatients.ItemIndex]);
end;

procedure TfrmMain.actSetActiveScannerExecute(Sender: TObject);
begin
  FScreenReader.ActiveScanner := edScanner.Text;
end;

procedure TfrmMain.actSetActiveTestExecute(Sender: TObject);
begin
  if lbAvailableTests.ItemIndex = -1 then
  begin
    MessageDlg('You must select a test first.', mtInformation, [mbOk], 0);
    exit;
  end;

  FScreenReader.ActiveTest := lbAvailableTests.Items[lbAvailableTests.ItemIndex];
end;

procedure TfrmMain.actShowLastTestResultsExecute(Sender: TObject);
var
  Dlg: TdlgTestResults;
begin
  if Assigned(FScreenReader.LastTestResult) then
  begin
    Dlg := TdlgTestResults.Create(nil);

    try
      Dlg.TestResult := FScreenReader.LastTestResult;
      Dlg.ShowModal;
    finally
      Dlg.Free;
    end;
  end;
end;

procedure TfrmMain.AddOperator;
var
  NewOperator: TSIScreenReaderOperator;
  Dlg: TdlgEditOperator;
begin
  Dlg := TdlgEditOperator.Create(nil);

  try
    if Dlg.ShowModal = mrOk then
    begin
      NewOperator := TSIScreenReaderOperator.Create(Dlg.OperatorName);

      NewOperator.Location := Dlg.Location;
      NewOperator.Lot := Dlg.Lot;
      NewOperator.Test := Dlg.Test;

      FScreenReader.AddOperator(NewOperator);
      lbOperators.Items.AddObject(NewOperator.Name, NewOperator);
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TfrmMain.AddPatient;
var
  NewPatient: TSIScreenReaderPatient;
  Dlg: TdlgEditPatient;
begin
  Dlg := TdlgEditPatient.Create(nil);

  try
    if Dlg.ShowModal = mrOk then
    begin
      NewPatient := TSIScreenReaderPatient.Create(Dlg.Name);
      NewPatient.Company := Dlg.Company;
      NewPatient.Task := Dlg.Task;
      NewPatient.DateOfBirth := Dlg.DateOfBirth;
      NewPatient.Id := Dlg.Id;
      NewPatient.IdDocument := Dlg.IdDocument;

      FScreenReader.AddPatient(NewPatient);
      lbPatients.Items.AddObject(NewPatient.Name, NewPatient);
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TfrmMain.btnCloseUIClick(Sender: TObject);
begin
  if FScreenReader.ReaderOpened then
    FScreenReader.CloseReader;
end;

procedure TfrmMain.btnOpenUIClick(Sender: TObject);
begin
  FScreenReader.OpenReader;

  FillOperatorsList;
end;

procedure TfrmMain.btnRefreshAvailableTestsClick(Sender: TObject);
begin
  FScreenReader.RefreshAvailableTests;
end;

procedure TfrmMain.chAutoOpenReaderClick(Sender: TObject);
begin
  FScreenReader.OpenReaderWhenNeeded := TCheckBox(Sender).Checked;
end;

procedure TfrmMain.chUiVisibleClick(Sender: TObject);
begin
  FScreenReader.ShowUI := TCheckBox(Sender).Checked;
end;

constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited;

  FScreenReader := TSIScreenReader.Create;
  FScreenReader.RefreshAvailableTests;

  chUiVisible.Checked := True;
  chAutoOpenReader.Checked := True;

  edReaderFileName.Text := FScreenReader.ReaderFileName;
  edReaderFilePath.Text := FScreenReader.ReaderFilePath;

  FillAvailableTests;
end;

destructor TfrmMain.Destroy;
begin
  FScreenReader.Free;

  inherited;
end;

procedure TfrmMain.FillAvailableTests;
var
  I: Integer;
begin
  lbAvailableTests.Items.Clear;

  for I := 0 to FScreenReader.AvailableTests.Count - 1 do
    lbAvailableTests.Items.Add(FScreenReader.AvailableTests[I]);
end;

procedure TfrmMain.FillOperatorsList;
var
  I: Integer;
begin
  lbOperators.Items.Clear;

  for I := 0 to FScreenReader.Operators.Count - 1 do
    lbOperators.Items.AddObject(FScreenReader.Operators.Items[I].Name, FScreenReader.Operators.Items[I]);
end;

procedure TfrmMain.FillPatientsList;
var
  I: Integer;
begin
  lbPatients.Items.Clear;

  for I := 0 to FScreenReader.Patients.Count - 1 do
    lbPatients.Items.AddObject(FScreenReader.Patients.Items[I].Name, FScreenReader.Patients.Items[I]);
end;

procedure TfrmMain.lbPatientsDblClick(Sender: TObject);
var
  PatientName: string;
begin
  PatientName := lbPatients.Items[lbPatients.ItemIndex];

  ShowPatientDataByName(PatientName);
end;

procedure TfrmMain.RemoveOperator;
begin
  if lbOperators.ItemIndex > -1 then
    FScreenReader.RemoveOperator(TSIScreenReaderOperator(lbOperators.Items.Objects[lbOperators.ItemIndex]));

  FillOperatorsList;
end;

procedure TfrmMain.RemovePatient;
begin
  if lbPatients.ItemIndex > -1 then
    FScreenReader.RemovePatient(TSIScreenReaderPatient(lbPatients.Items.Objects[lbPatients.ItemIndex]));

  FillPatientsList;
end;

procedure TfrmMain.ShowPatientDataByIdDocument(AIdDocument: string);
begin

end;

procedure TfrmMain.ShowPatientDataByName(AName: string);
var
  Patient: TSIScreenReaderPatient;
  Dlg: TdlgEditPatient;
begin
  Assert(AName <> EmptyStr, 'TfrmMain.ShowPatientDataByName: AName is empty.');

  Patient := FScreenReader.GetPatientByName(AName);

  if Assigned(Patient) then
  begin
    Dlg := TdlgEditPatient.Create(nil);

    try
      Dlg.Name := Patient.Name;
      Dlg.DateOfBirth := Patient.DateOfBirth;
      Dlg.Id := Patient.Id;
      Dlg.IdDocument := Patient.IdDocument;
      Dlg.Company := Patient.Company;
      Dlg.Task := Patient.Task;
      Dlg.ReadOnly := True;

      Dlg.ShowModal;
    finally
      Dlg.Free;
    end;
  end
  else
    MessageDlg('Patient not found.', mtInformation, [mbOk], 0);
end;

end.
