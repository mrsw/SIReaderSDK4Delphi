unit TestResultsDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SIScreenReader.Classes, StdCtrls, ExtCtrls, ActnList;

type
  TdlgTestResults = class(TForm)
    edPDFResultFullPath: TLabeledEdit;
    pnlBottom: TPanel;
    btnOk: TButton;
    imgTestImage: TImage;
    edFullResultText: TMemo;
    Label1: TLabel;
    btnPreviousImage: TButton;
    btnNExtImage: TButton;
    lblImagesCount: TLabel;
    alCommands: TActionList;
    actNextTestImage: TAction;
    actPreviousTestImage: TAction;
    procedure btnOkClick(Sender: TObject);
    procedure actNextTestImageUpdate(Sender: TObject);
    procedure actPreviousTestImageUpdate(Sender: TObject);
  private
    FCurrentTestImageIndex: integer;
    FTestResults: TSIScreenReaderTestResult;
    procedure DisplayNextTestImage;
    procedure DisplayPreviousTestImage;
    procedure DisplayTestImage(Index: integer);
    procedure SetTestResults(const Value: TSIScreenReaderTestResult);
    procedure UpdateTestImagesLabel;
  public
    constructor Create(AOwner: TComponent); override;

    property TestResult: TSIScreenReaderTestResult read FTestResults write SetTestResults;
  end;

var
  dlgTestResults: TdlgTestResults;

implementation

{$R *.dfm}

{ TdlgTestResults }

procedure TdlgTestResults.actNextTestImageUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(FTestResults) and (FCurrentTestImageIndex < Pred(FTestResults.Images.Count));
end;

procedure TdlgTestResults.actPreviousTestImageUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(FTestResults) and (FCurrentTestImageIndex > 0);
end;

procedure TdlgTestResults.btnOkClick(Sender: TObject);
begin
  Close;
end;

constructor TdlgTestResults.Create(AOwner: TComponent);
begin
  inherited;

  FCurrentTestImageIndex := -1;
end;

procedure TdlgTestResults.DisplayNextTestImage;
begin
  if FCurrentTestImageIndex < FTestResults.Images.Count - 1 then
    DisplayTestImage(Succ(FCurrentTestImageIndex));
end;

procedure TdlgTestResults.DisplayPreviousTestImage;
begin
  if FCurrentTestImageIndex > 0 then
    DisplayTestImage(Pred(FCurrentTestImageIndex));
end;

procedure TdlgTestResults.DisplayTestImage(Index: integer);
begin
  if Index < 0 then
    exit;

  FCurrentTestImageIndex := Index;
  imgTestImage.Picture.Assign(FTestResults.Images[Index]);
  UpdateTestImagesLabel;
end;

procedure TdlgTestResults.SetTestResults(const Value: TSIScreenReaderTestResult);
begin
  FTestResults := Value;

  edPDFResultFullPath.Text := FTestResults.PDFPath;
  edFullResultText.Text := FTestResults.ResultText;

  if FTestResults.Images.Count > 0 then
    DisplayTestImage(0);
end;

procedure TdlgTestResults.UpdateTestImagesLabel;
begin
  if Assigned(FTestResults) then
    lblImagesCount.Caption := Format('Test images %d/%d', [Succ(FCurrentTestImageIndex), FTestResults.Images.Count])
  else
    lblImagesCount.Caption := 'Test image';
end;

end.
