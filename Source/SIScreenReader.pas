{*****************************************************************}
{                                                                 }
{            Embarcadero Delphi Runtime Library                   }
{            SIScreenReader interface unit                        }
{                                                                 }
{            Coypright (c) 2022 Carlo Marona                      }
{            Created 09 Feb 2022 Carlo Marona                     }
{            Last modified 16 Feb 2022 Carlo Marona               }
{            Version 1.0                                          }
{                                                                 }
{*****************************************************************}

{*****************************************************************}
{                                                                 }
{ The contents of this file are subject to the Mozilla Public     }
{ License Version 1.1 (the "License"). you may not use this file  }
{ except in compliance with the License. You may obtain a copy of }
{ the License at http://www.mozilla.org/MPL/MPL-1.1.html          }
{                                                                 }
{ Software distributed under the License is distributed on an     }
{ "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or  }
{ implied. See the License for the specific language governing    }
{ rights and limitations under the License.                       }
{                                                                 }
{ The initial developer is Carlo Marona (marona@soft4you.it).     }
{                                                                 }
{ Portions created by Carlo Marona are                            }
{ Copyright (C) 2022 Carlo Marona.                                }
{                                                                 }
{                                                                 }
{ All Rights Reserved.                                            }
{                                                                 }
{ Contributor(s):                                                 }
{                                                                 }
{ Notes:                                                          }
{                                                                 }
{ Modification history:                                           }
{                                                                 }
{ Known Issues:                                                   }
{                                                                 }
{*****************************************************************}
unit SIScreenReader;




interface

uses
  SysUtils,
  Classes,
  Graphics,
  Generics.Collections,
  SIScreenReader.Types,
  SIScreenReader.Classes,
  SIScreenReader.Exceptions
  ;



type
  TSIScreenReader = class(TObject)
  private
    FReaderOpened: boolean;
    FShowUI: boolean;
    FScanner: string;
    FLastTestResult: TSIScreenReaderTestResult;
    FOperators: TSIScreenReaderOperatorList;
    FTests: TStringList;
    FPatients: TSIScreenReaderPatientList;
    FOpenReaderWhenNeeded: boolean;
    FActiveOperator: TSIScreenReaderOperator;
    FActivePatient: TSIScreenReaderPatient;

    procedure CheckReaderOpened;
    function EncodeOperatorRecord(AOperator: TSIScreenReaderOperator): string;
    procedure DecodeOperatorRecord(AOperatorRecord: string; var AOperatorDataRec: TSIScreenReaderOperatorDataRec);
    function EncodePatientRecord(APatient: TSIScreenReaderPatient): string;
    procedure DecodePatientRecord(APatientRecord: string; var APatientDataRec: TSIScreenReaderPatientDataRec);
    function CheckReaderName(ReaderName: string): boolean;
    procedure FillTestResults;
    function GetLastError: string;
    function GetReaderFileName: string;
    function GetReaderFilePath: string;
    function GetActiveScanner: string;
    procedure SetActiveScanner(const Value: string);
    function GetActiveOperator: TSIScreenReaderOperator;
    procedure SetActiveOperator(const Value: TSIScreenReaderOperator);
    function GetActivePatient: TSIScreenReaderPatient;
    procedure SetActivePatient(const Value: TSIScreenReaderPatient);
    function GetActiveTest: string;
    procedure SetActiveTest(const Value: string);
  public
    constructor Create(ReaderName: string = ''; OpenReaderWhenNeeded: boolean = True);
    destructor Destroy; override;

    procedure AddOperator(AOperator: TSIScreenReaderOperator);
    procedure AddPatient(APatient: TSIScreenReaderPatient);
    procedure CalibrateBox(AScannerNsme: string = '');
    procedure ClearLastTestResult;
    procedure CloseReader;
    // Returns a Patient instance not owned by Patients list
    function GetPatientByName(AName: string): TSIScreenReaderPatient;
    // Returns a Patient instance not owned by Patients list
    function GetPatientByIdDocument(AIdDocument: string): TSIScreenReaderPatient;
    procedure OpenReader;
    procedure ReadTest;
    procedure RefreshAvailableTests;
    procedure RefreshOperators;
    procedure RefreshPatients;
    procedure RemoveOperator(AOperator: TSIScreenReaderOperator);
    procedure RemovePatient(APatient: TSIScreenReaderPatient);
    // Fills the patient instance passed in APatient
    procedure RetrievePatientDataByName(var APatient: TSIScreenReaderPatient; AName: string);
    // Fills the patient instance passed in APatient
    procedure RetrievePatientDataByIdDoc(var APatient: TSIScreenReaderPatient; AIdDoc: string);

    property ActiveOperator: TSIScreenReaderOperator read GetActiveOperator write SetActiveOperator;
    property ActivePatient: TSIScreenReaderPatient read GetActivePatient write SetActivePatient;
    property ActiveScanner: string read GetActiveScanner write SetActiveScanner;
    property ActiveTest: string read GetActiveTest write SetActiveTest;
    property AvailableTests: TStringList read FTests;
    property LastTestResult: TSIScreenReaderTestResult read FLastTestResult;
    property OpenReaderWhenNeeded: boolean read FOpenReaderWhenNeeded write FOpenReaderWhenNeeded;
    property Operators: TSIScreenReaderOperatorList read FOperators;
    property Patients: TSIScreenReaderPatientList read FPatients;
    property ReaderFileName: string read GetReaderFileName;
    property ReaderFilePath: string read GetReaderFilePath;
    property ReaderOpened: boolean read FReaderOpened;
    property Scanner: string read FScanner write FScanner;
    property ShowUI: boolean read FShowUI write FShowUI;
  end;



implementation

uses
  XMLIntf,
  XMLDoc,
  ComObj,
  Variants,
  SIScreenReader.SDK,
  SIScreenReader.Strings
  ;


{ TSIScreenReader }

procedure TSIScreenReader.AddOperator(AOperator: TSIScreenReaderOperator);
var
  NewOperatorDataStr: string;
begin
  Assert(AOperator <> nil, 'TSIScreenReader.AddOperator: AOperator not assigned.');

  CheckReaderOpened;

  NewOperatorDataStr := EncodeOperatorRecord(AOperator);

  if SIScreenReader.SDK.AddNewOperatorRecord(PAnsiChar(AnsiString(NewOperatorDataStr))) > 0 then
    FOperators.Add(AOperator);
end;

procedure TSIScreenReader.AddPatient(APatient: TSIScreenReaderPatient);
var
  NewPatientDataStr: string;

begin
  Assert(APatient <> nil, 'TSIScreenReader.AddPatient: APatient not assigned.');

  CheckReaderOpened;

  NewPatientDataStr := EncodePatientRecord(APatient);

  SIScreenReader.SDK.AddNewPatientRecord(PAnsiChar(AnsiString(NewPatientDataStr)));
end;

procedure TSIScreenReader.CalibrateBox(AScannerNsme: string);
begin
  if not SIScreenReader.SDK.CalibrateBox(PAnsiChar(AnsiString(AScannerNsme))) then
    raise ESIScreenReaderCalibrationError.CreateFmt(SScannerCalibrationError, [GetLastError]);
end;

function TSIScreenReader.CheckReaderName(ReaderName: string): boolean;
begin
  Result := (ReaderName = EmptyStr) or (ReaderName = SCREENREADER) or (ReaderName = FUTUREADER);
end;

procedure TSIScreenReader.CheckReaderOpened;
begin
  if not ReaderOpened then
  begin
    if not OpenReaderWhenNeeded then
      raise ESIScreenReaderReaderNotOpenedError.CreateFmt(SReaderProcessNotOpenedError, [
        SUnableToRemoveOperatorError])
    else
      OpenReader;
  end;
end;

procedure TSIScreenReader.ClearLastTestResult;
begin
  FreeAndNil(FLastTestResult);
end;

procedure TSIScreenReader.CloseReader;
begin
  if not FReaderOpened then
    exit;

  FReaderOpened := not SIScreenReader.SDK.CloseReaderSoftware;
end;

constructor TSIScreenReader.Create(ReaderName: string = ''; OpenReaderWhenNeeded: boolean = True);
begin
  if not CheckReaderName(ReaderName) then
    raise ESIScreenReaderInvalidReaderError.CreateFmt(SInvalidReaderError, [ReaderName]);

  inherited Create;

  if not InitEngineSDK(PAnsiChar(AnsiString(ReaderName))) then
    raise ESIScreenReaderInitializationError.CreateFmt('Screen reader initialization error: %s.', [GetLastError]);

  FOpenReaderWhenNeeded := OpenReaderWhenNeeded;
  FShowUI := False;
  FReaderOpened := False;
  FTests := TStringList.Create;
  FLastTestResult := TSIScreenReaderTestResult.Create;
  FOperators := TSIScreenReaderOperatorList.Create;
  FPatients := TSIScreenReaderPatientList.Create;
  FActiveOperator := nil;
  FActivePatient := nil;
end;

procedure TSIScreenReader.DecodeOperatorRecord(AOperatorRecord: string; var AOperatorDataRec: TSIScreenReaderOperatorDataRec);
var
  XmlDoc: IXMLDocument;
  OperatorElement, Attr: IXMLNode;
  AttrValue: string;
  I: integer;
begin
  Assert(AOperatorRecord <> EmptyStr, 'TSIScreenReader.DecodeOperatorRecord: AOperatorRecord is empty.');

  XmlDoc := TXmlDocument.Create(nil);

  XmlDoc.LoadFromXML(AOperatorRecord);

  OperatorElement := XmlDoc.ChildNodes.FindNode('operatore');

  if OperatorElement <> nil then
  begin
    for I := 0 to OperatorElement.AttributeNodes.Count - 1 do
    begin
      Attr := OperatorElement.AttributeNodes[I];

      if not VarIsNull(Attr.NodeValue) and (Attr.NodeValue <>  EmptyStr) then
      begin
        if Attr.NodeName = 'nome' then
          AOperatorDataRec.Name := Attr.NodeValue
        else if Attr.NodeName = 'luogo' then
          AOperatorDataRec.Location := Attr.NodeValue
        else if Attr.NodeName = 'tester' then
          AOperatorDataRec.Test := Attr.NodeValue
        else if Attr.NodeName = 'lotto' then
          AOperatorDataRec.Lot := Attr.NodeValue
      end;
    end;
  end;
end;

procedure TSIScreenReader.DecodePatientRecord(APatientRecord: string; var APatientDataRec: TSIScreenReaderPatientDataRec);
var
  XmlDoc: IXMLDocument;
  PatientElement, Attr: IXMLNode;
  AttrValue: string;
  I: integer;
begin
  Assert(APatientRecord <> EmptyStr, 'TSIScreenReader.DecodePatientRecord: APatientRecord is empty.');

  XmlDoc := TXmlDocument.Create(nil);

  XmlDoc.LoadFromXML(APatientRecord);

  PatientElement := XmlDoc.ChildNodes.FindNode('paziente');

  if PatientElement <> nil then
  begin
    for I := 0 to PatientElement.AttributeNodes.Count - 1 do
    begin
      Attr := PatientElement.AttributeNodes[I];

      if not VarIsNull(Attr.NodeValue) and (Attr.NodeValue <>  EmptyStr) then
      begin
        if Attr.NodeName = 'nome' then
          APatientDataRec.Name := Attr.NodeValue
        else if Attr.NodeName = 'qualifica' then
          APatientDataRec.Task := Attr.NodeValue
        else if Attr.NodeName = 'azienda' then
          APatientDataRec.Company := Attr.NodeValue
        else if Attr.NodeName = 'codice_paziente' then
          APatientDataRec.Id := Attr.NodeValue
        else if Attr.NodeName = 'data_nascita' then
          APatientDataRec.DateOfBirth := StrToDate(Attr.NodeValue)
        else if Attr.NodeName = 'doc_identita' then
          APatientDataRec.IdDocument := Attr.NodeValue
  //      else if Node.NodeName = 'campi_presonalizzati' then
  //        APatientDataRec.IdDocument := Node.NodeValue
      end;
    end;
  end;
end;

destructor TSIScreenReader.Destroy;
begin
  CloseReaderSoftware;

  FreeAndNil(FLastTestResult);
  FTests.Free;
  FOperators.Free;
  FPatients.Free;

  inherited;
end;

function TSIScreenReader.EncodeOperatorRecord(AOperator: TSIScreenReaderOperator): string;
var
  XmlDoc: IXMLDocument;
  OperatorElement, Attr: IXMLNode;
  AttrValue: string;
begin
  Assert(AOperator <> nil, 'TSIScreenReader.EncodeOperatorRecord: AOperator not assigned.');

  XmlDoc := TXmlDocument.Create(nil);
  XmlDoc.Active := True;

  OperatorElement := XmlDoc.AddChild('operatore');

  OperatorElement.Attributes['nome'] := AOperator.Name;
  OperatorElement.Attributes['luogo'] := AOperator.Location;
  OperatorElement.Attributes['lotto'] := AOperator.Lot;
  OperatorElement.Attributes['tester'] := AOperator.Test;

  XmlDoc.SaveToXML(Result);
end;

function TSIScreenReader.EncodePatientRecord(APatient: TSIScreenReaderPatient): string;
var
  XmlDoc: IXMLDocument;
  PatientElement, Attr: IXMLNode;
  AttrValue: string;
begin
  Assert(APatient <> nil, 'TSIScreenReader.EncodePatientRecord: APatient not assigned.');

  XmlDoc := TXmlDocument.Create(nil);
  XmlDoc.Active := True;

  PatientElement := XmlDoc.AddChild('paziente');

  PatientElement.Attributes['nome'] := APatient.Name;
  PatientElement.Attributes['qualifica'] := APatient.Task;
  PatientElement.Attributes['azienda'] := APatient.Company;

  if APatient.DateOfBirth <> 0 then
    PatientElement.Attributes['data_nascita'] := FormatDateTime('dd/mm/yyyy', APatient.DateOfBirth)
  else
    PatientElement.Attributes['data_nascita'] := EmptyStr;

  PatientElement.Attributes['doc_identita'] := APatient.IdDocument;
  PatientElement.Attributes['codice_paziente'] := APatient.Id;

  XmlDoc.SaveToXML(Result);
end;

procedure TSIScreenReader.RefreshAvailableTests;
var
  TestsCount: integer;
  I: Integer;
begin
  FTests.Clear;

  TestsCount := SIScreenReader.SDK.GetAvailableTestCount;

  for I := 0 to TestsCount - 1 do
    FTests.Add(SIScreenReader.SDK.GetTestName(I));
end;

procedure TSIScreenReader.FillTestResults;
var
  Image: TBitmap;
  ImgCount: integer;
  I: Integer;
begin
  if not Assigned(FLastTestResult) then
    FLastTestResult := TSIScreenReaderTestResult.Create;

  FLastTestResult.ResultText := SIScreenReader.SDK.GetFullResultText;
  FLastTestResult.PDFPath := SIScreenReader.SDK.GetFullPathPdfFileResult;

  ImgCount := SIScreenReader.SDK.GetResultImagesCount;

  for I := 0 to ImgCount - 1 do
  begin
    Image := TBitmap.Create;
    Image.Handle := SIScreenReader.SDK.GetImageResultHBITMAP(I);

    FLastTestResult.Images.Add(Image);
  end;
end;

function TSIScreenReader.GetActiveOperator: TSIScreenReaderOperator;
begin
  CheckReaderOpened;

  Result := FActiveOperator;
end;

function TSIScreenReader.GetActivePatient: TSIScreenReaderPatient;
var
  Str: string;
  PatientDataRec: TSIScreenReaderPatientDataRec;
begin
  CheckReaderOpened;

  FreeAndNil(FActivePatient);

  Str := SIScreenReader.SDK.GetActivePatientDocument;

  if Str <> EmptyStr then
    FActivePatient := GetPatientByIdDocument(Str)
  else
  begin
    Str := SIScreenReader.SDK.GetActivePatientName;

    if Str <> EmptyStr then
      FActivePatient := GetPatientByName(Str);
  end;

  Result := FActivePatient;
end;

function TSIScreenReader.GetActiveScanner: string;
begin
  CheckReaderOpened;

  Result := SIScreenReader.SDK.GetActiveScanner;
end;

function TSIScreenReader.GetActiveTest: string;
begin
  CheckReaderOpened;

  Result := SIScreenReader.SDK.GetActiveTest;
end;

function TSIScreenReader.GetLastError: string;
begin
  Result := SIScreenReader.SDK.GetLastError;
end;

function TSIScreenReader.GetPatientByIdDocument(AIdDocument: string): TSIScreenReaderPatient;
var
  PatientDataStr: string;
  PatientDataRec: TSIScreenReaderPatientDataRec;
begin
  Assert(AIdDocument <> EmptyStr, 'TSIScreenReader.GetPatientByIdDocument: AIdDocument is empty.');

  CheckReaderOpened;

  Result := nil;

  PatientDataStr := SIScreenReader.SDK.GetPatientRecordByDocument(PAnsiChar(AnsiString(AIdDocument)));

  if PatientDataStr <> EmptyStr then
  begin
    DecodePatientRecord(PatientDataStr, PatientDataRec);
    Result := TSIScreenReaderPatient.Create(PatientDataRec);
  end;
end;

function TSIScreenReader.GetPatientByName(AName: string): TSIScreenReaderPatient;
var
  PatientDataStr: string;
  PatientDataRec: TSIScreenReaderPatientDataRec;
begin
  Assert(AName <> EmptyStr, 'TSIScreenReader.GetPatientByName: AName is empty.');

  CheckReaderOpened;

  Result := nil;

  PatientDataStr := SIScreenReader.SDK.GetPatientRecordByName(PAnsiChar(AnsiString(AName)));

  if PatientDataStr <> EmptyStr then
  begin
    DecodePatientRecord(PatientDataStr, PatientDataRec);
    Result := TSIScreenReaderPatient.Create(PatientDataRec);
  end;
end;

function TSIScreenReader.GetReaderFileName: string;
begin
  Result := SIScreenReader.SDK.GetReaderFileName;
end;

function TSIScreenReader.GetReaderFilePath: string;
begin
  Result := SIScreenReader.SDK.GetReaderFilePath;
end;

procedure TSIScreenReader.OpenReader;
begin
  if not SIScreenReader.SDK.ExecuteReaderSoftware(FShowUI) then
    raise ESIScreenReaderOpenReaderError.CreateFmt(SOpeningReaderError, [GetLastError]);

  FReaderOpened := True;
end;

procedure TSIScreenReader.RefreshOperators;
var
  NewOperator: TSIScreenReaderOperator;
  OpListStr: String;
  OpList: TStringList;
  I: Integer;
begin
  FOperators.Clear;

  CheckReaderOpened;

  OpListStr := SIScreenReader.SDK.GetOperatorsNamesList;

  if OpListStr = EmptyStr then
    exit;

  OpList := TStringList.Create;

  try
    OpList.Text := OpListStr;

    for I := 0 to OpList.Count - 1 do
    begin
      NewOperator := TSIScreenReaderOperator.Create(OpList[I]);
      FOperators.Add(NewOperator);
    end;
  finally
    OpList.Free;
  end;
end;

procedure TSIScreenReader.RefreshPatients;
var
  NewPatient: TSIScreenReaderPatient;
  PatListStr: String;
  PatList: TStringList;
  I: Integer;
begin
  FPatients.Clear;

  CheckReaderOpened;

  PatListStr := SIScreenReader.SDK.GetPatientsNamesList;

  if PatListStr = EmptyStr then
    exit;

  PatList := TStringList.Create;

  try
    PatList.Text := PatListStr;

    for I := 0 to PatList.Count - 1 do
    begin
      NewPatient := TSIScreenReaderPatient.Create(PatList[I]);
      FPatients.Add(NewPatient);
    end;
  finally
    PatList.Free;
  end;
end;

procedure TSIScreenReader.RemoveOperator(AOperator: TSIScreenReaderOperator);
begin
  Assert(AOperator <> nil, 'TSIScreenReader.RemoveOperator: AOperator not assigned.');

  CheckReaderOpened;

  if not SIScreenReader.SDK.RemoveOperatorByName(PAnsiChar(AnsiString(AOperator.Name))) then
    raise ESIScreenReaderRemoveOperatorError.CreateFmt(SRemovingOperatorError, [AOperator.Name, GetLastError]);

  RefreshOperators;
end;

procedure TSIScreenReader.RemovePatient(APatient: TSIScreenReaderPatient);
begin
  Assert(APatient <> nil, 'TSIScreenReader.RemovePatient: APatient not assigned.');
  Assert((APatient.Name <> EmptyStr) and (APatient.IdDocument <> EmptyStr), 'TSIScreenReader.RemovePatient: APatient is invalid.' + #13#10 +
    'It doesn''t have a name or identity document.');

  CheckReaderOpened;

  if APatient.IdDocument <> EmptyStr then
  begin
    if not SIScreenReader.SDK.RemovePatientByDocument(PAnsiChar(AnsiString(APatient.IdDocument))) then
      raise ESIScreenReaderRemovePatientError.CreateFmt(SRemovingPatientError, [APatient.IdDocument, GetLastError]);
  end
  else
  begin
    if not SIScreenReader.SDK.RemovePatientByName(PAnsiChar(AnsiString(APatient.Name))) then
      raise ESIScreenReaderRemovePatientError.CreateFmt(SRemovingPatientError, [APatient.Name, GetLastError]);
  end;

  RefreshPatients;
end;

procedure TSIScreenReader.RetrievePatientDataByIdDoc(var APatient: TSIScreenReaderPatient; AIdDoc: string);
var
  PatientDataStr: string;
  PatientDataRec: TSIScreenReaderPatientDataRec;
begin
  Assert(APatient <> nil, 'TSIScreenReader.RetrievePatientDataByIdDoc: APatient not assigned.');
  Assert(AIdDoc <> EmptyStr, 'TSIScreenReader.RetrievePatientDataByIdDoc: AIdDoc is empty.');

  CheckReaderOpened;

  PatientDataStr := SIScreenReader.SDK.GetPatientRecordByDocument(PAnsiChar(AnsiString(AIdDoc)));

  if PatientDataStr <> EmptyStr then
  begin
    DecodePatientRecord(PatientDataStr, PatientDataRec);
    APatient.AssignDataRec(PatientDataRec);
  end;
end;

procedure TSIScreenReader.RetrievePatientDataByName(var APatient: TSIScreenReaderPatient; AName: string);
var
  PatientDataStr: string;
  PatientDataRec: TSIScreenReaderPatientDataRec;
begin
  Assert(APatient <> nil, 'TSIScreenReader.RetrievePatientDataByName: APatient not assigned.');
  Assert(AName <> EmptyStr, 'TSIScreenReader.RetrievePatientDataByName: AName is empty.');

  CheckReaderOpened;

  PatientDataStr := SIScreenReader.SDK.GetPatientRecordByName(PAnsiChar(AnsiString(AName)));

  if PatientDataStr <> EmptyStr then
  begin
    DecodePatientRecord(PatientDataStr, PatientDataRec);
    APatient.AssignDataRec(PatientDataRec);
  end;
end;

procedure TSIScreenReader.ReadTest;
begin
  FreeAndNil(FLastTestResult);

  CheckReaderOpened;

  if ActiveScanner = EmptyStr then
    raise ESIScreenReaderNoActiveScannerError.CreateFmt(SUnableToReadTestError, [SNoScannerSelected]);

  if ActiveTest = EmptyStr then
    raise ESIScreenReaderNoActiveTestError.CreateFmt(SUnableToReadTestError, [SNoTestSelected]);

//  if not Assigned(ActiveOperator) then
//    raise ESIScreenReaderNoActiveOperatorError.Create(Fmt(SUnableToReadTestError, [SNoOperatorSelected]);

  if not Assigned(ActivePatient) then
    raise ESIScreenReaderNoActivePatientError.CreateFmt(SUnableToReadTestError, [SNoPatientSelected]);

  if not StartScanTest then
    raise ESIScreenReaderTestError.CreateFmt(SReadTestError, [GetLastError]);

  // Retrieve test results
  FillTestResults;
end;

procedure TSIScreenReader.SetActiveOperator(const Value: TSIScreenReaderOperator);
begin
  if Assigned(Value) then
  begin
    CheckReaderOpened;

    if Value.Name <> EmptyStr then
    begin
      if not SIScreenReader.SDK.SetActiveOperatorByName(PAnsiChar(AnsiString(Value.Name))) then
        raise ESIScreenReaderSetActiveOperatorError.CreateFmt(SSettingActiveOperatorError, [GetLAstError]);
    end;
  end
  else
    FreeAndNil(FActiveOperator);
end;

procedure TSIScreenReader.SetActivePatient(const Value: TSIScreenReaderPatient);
begin
  if Assigned(Value) then
  begin
    CheckReaderOpened;

    if Value.IdDocument <> EmptyStr then
    begin
      if not SIScreenReader.SDK.SetActivePatientByDocument(PAnsiChar(AnsiString(Value.IdDocument))) then
        raise ESIScreenReaderSetActivePatientError.CreateFmt(SSettingActivePatientError, [GetLAstError]);
    end
    else if Value.Name <> EmptyStr then
    begin
      if not SIScreenReader.SDK.SetActivePatientByName(PAnsiChar(AnsiString(Value.Name))) then
        raise ESIScreenReaderSetActivePatientError.CreateFmt(SSettingActivePatientError, [GetLAstError]);
    end;
  end
  else
    FreeAndNil(FActivePAtient);
end;

procedure TSIScreenReader.SetActiveScanner(const Value: string);
begin
  if Value = EmptyStr then
    raise ESIScreenReaderInvalidScannerError.Create('Scanner name cannot be empty.');

  CheckReaderOpened;

  if not SIScreenReader.SDK.SetActiveScanner(PAnsiChar(AnsiString(Value))) then
    raise ESIScreenReaderSetActiveScannerError.CreateFmt('Error setting active scanner: %s.', [GetLastError]);
end;

procedure TSIScreenReader.SetActiveTest(const Value: string);
begin
  if Value = EmptyStr then
    raise ESIScreenReaderInvalidTestError.Create('Test name cannot be mepty.');

  CheckReaderOpened;

  if not SIScreenReader.SDK.SetActiveTest(PAnsiChar(AnsiString(Value))) then
    raise ESIScreenReaderSetActiveTestError.CreateFmt('Error setting active test: %s.', [GetLastError]);
end;



end.
