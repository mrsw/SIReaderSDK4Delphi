unit EditOperatorDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, SIScreenReader;

type
  TdlgEditOperator = class(TForm)
    edName: TLabeledEdit;
    edLocation: TLabeledEdit;
    cbTest: TComboBox;
    Label1: TLabel;
    edLot: TLabeledEdit;
    pnlBottom: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FReadOnly: boolean;
    function GetLocation: string;
    function GetLot: string;
    function GetOperatorName: string;
    function GetTest: string;
    procedure SetLocation(const Value: string);
    procedure SetLot(const Value: string);
    procedure SetOperatorName(const Value: string);
    procedure SetTest(const Value: string);
    procedure SetReadOnly(const Value: boolean);
  public
    constructor Create(AOwner: TComponent); override;

    property OperatorName: string read GetOperatorName write SetOperatorName;
    property Test: string read GetTest write SetTest;
    property Lot: string read GetLot write SetLot;
    property Location: string read GetLocation write SetLocation;
    property ReadOnly: boolean read FReadOnly write SetReadOnly;
  end;

var
  dlgEditOperator: TdlgEditOperator;

implementation

{$R *.dfm}

{ TForm2 }

procedure TdlgEditOperator.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TdlgEditOperator.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

constructor TdlgEditOperator.Create(AOwner: TComponent);
begin
  inherited;

  FReadOnly := False;
end;

function TdlgEditOperator.GetLocation: string;
begin
  Result := edLocation.Text;
end;

function TdlgEditOperator.GetLot: string;
begin
  Result := edLot.Text;
end;

function TdlgEditOperator.GetOperatorName: string;
begin
  Result := edName.Text;
end;

function TdlgEditOperator.GetTest: string;
begin
  Result := cbTest.Text;
end;

procedure TdlgEditOperator.SetLocation(const Value: string);
begin
  edLocation.Text := Value;
end;

procedure TdlgEditOperator.SetLot(const Value: string);
begin
  edLot.Text := Value;
end;

procedure TdlgEditOperator.SetOperatorName(const Value: string);
begin
  edName.Text := Value;
end;

procedure TdlgEditOperator.SetReadOnly(const Value: boolean);
begin
  FReadOnly := Value;

  edName.ReadOnly := FReadOnly;
  edLocation.ReadOnly := FReadOnly;

  if FReadOnly then
    cbTest.Style := csSimple
  else
    cbTest.Style := csDropDownList;

  edLot.ReadOnly := FReadOnly;

  btnOk.Visible := not FReadOnly;

  if FReadOnly then
    btnCancel.Caption := 'Close'
  else
    btnCancel.Caption := 'Cancel';
end;

procedure TdlgEditOperator.SetTest(const Value: string);
begin
  cbTest.ItemIndex := cbTest.Items.IndexOf(Value);
end;

end.
