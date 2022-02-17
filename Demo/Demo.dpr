program Demo;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {frmMain},
  EditOperatorDlg in 'EditOperatorDlg.pas' {dlgEditOperator},
  EditPatientDlg in 'EditPatientDlg.pas' {dlgEditPatient},
  TestResultsDlg in 'TestResultsDlg.pas' {dlgTestResults},
  SIScreenReader.Classes in '..\Source\SIScreenReader.Classes.pas',
  SIScreenReader.Exceptions in '..\Source\SIScreenReader.Exceptions.pas',
  SIScreenReader in '..\Source\SIScreenReader.pas',
  SIScreenReader.SDK in '..\Source\SIScreenReader.SDK.pas',
  SIScreenReader.Strings in '..\Source\SIScreenReader.Strings.pas',
  SIScreenReader.Types in '..\Source\SIScreenReader.Types.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
