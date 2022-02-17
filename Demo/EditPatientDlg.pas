unit EditPatientDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TdlgEditPatient = class(TForm)
    pnlBottom: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    edName: TLabeledEdit;
    edTask: TLabeledEdit;
    edCompany: TLabeledEdit;
    edDateOfBirth: TLabeledEdit;
    edId: TLabeledEdit;
    edIdDocument: TLabeledEdit;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FReadOnly: boolean;
    function GetCompany: string;
    function GetDateOfBirth: TDate;
    function GetId: string;
    function GetIdDocument: string;
    function GetName: string;
    function GetTask: string;
    procedure SetCompany(const Value: string);
    procedure SetDateOfBirth(const Value: TDate);
    procedure SetId(const Value: string);
    procedure SetIdDocument(const Value: string);
    procedure SetName(const Value: string);
    procedure SetTask(const Value: string);
    procedure SetReadOnly(const Value: boolean);
  public
    constructor Create(AOwner: TComponent); override;

    property Name: string read GetName write SetName;
    property Task: string read GetTask write SetTask;
    property Company: string read GetCompany write SetCompany;
    property DateOfBirth: TDate read GetDateOfBirth write SetDateOfBirth;
    property IdDocument: string read GetIdDocument write SetIdDocument;
    property Id: string read GetId write SetId;
    property ReadOnly: boolean read FReadOnly write SetReadOnly;
  end;

var
  dlgEditPatient: TdlgEditPatient;

implementation

{$R *.dfm}

{ TForm3 }

procedure TdlgEditPatient.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TdlgEditPatient.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

constructor TdlgEditPatient.Create(AOwner: TComponent);
begin
  inherited;

  FReadOnly := false;
end;

function TdlgEditPatient.GetCompany: string;
begin
  Result := edCompany.Text;
end;

function TdlgEditPatient.GetDateOfBirth: TDate;
begin
  if edDateOfBirth.Text <> EmptyStr then
    Result := StrToDate(edDateOfBirth.Text)
  else
    Result := 0;
end;

function TdlgEditPatient.GetId: string;
begin
  Result := edId.Text;
end;

function TdlgEditPatient.GetIdDocument: string;
begin
  Result := edIdDocument.Text;
end;

function TdlgEditPatient.GetName: string;
begin
  Result := edName.Text;
end;

function TdlgEditPatient.GetTask: string;
begin
  Result := edTask.Text;
end;

procedure TdlgEditPatient.SetCompany(const Value: string);
begin
  edCompany.Text := Value;
end;

procedure TdlgEditPatient.SetDateOfBirth(const Value: TDate);
begin
  edDateOfBirth.Text := DateToStr(Value);
end;

procedure TdlgEditPatient.SetId(const Value: string);
begin
  edId.Text := Value;
end;

procedure TdlgEditPatient.SetIdDocument(const Value: string);
begin
  edIdDocument.Text := Value;
end;

procedure TdlgEditPatient.SetName(const Value: string);
begin
  edName.Text := Value;
end;

procedure TdlgEditPatient.SetReadOnly(const Value: boolean);
begin
  FReadOnly := Value;

  edName.ReadOnly := FReadOnly;
  edDateOfBirth.ReadOnly := FReadOnly;
  edId.ReadOnly := FReadOnly;
  edIdDocument.ReadOnly := FReadOnly;
  edCompany.ReadOnly := FReadOnly;
  edTask.ReadOnly := FReadOnly;

  btnOk.Visible := not FReadOnly;

  if FReadOnly then
    btnCancel.Caption := 'Close'
  else
    btnCancel.Caption := 'Cancel';
end;

procedure TdlgEditPatient.SetTask(const Value: string);
begin
  edTask.Text := Value;
end;

end.
