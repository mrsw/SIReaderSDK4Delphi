{*****************************************************************}
{                                                                 }
{            Embarcadero Delphi Runtime Library                   }
{            SIScreenReader.Classes unit                          }
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
{ - Actually custom data fields of Patient are not managed        }
{                                                                 }
{*****************************************************************}
unit SIScreenReader.Classes;

interface

uses
  SysUtils,
  Classes,
  Graphics,
  Generics.Collections,
  SIScreenReader.Types
  ;

type
  TSIScreenReaderPatient = class(TObject)
  private
    FName: string;
    FCompany: string;
    FId: string;
    FDateOfBirth: TDate;
    FIdDocument: string;
    FTask: string;
  public
    constructor Create(AName: string); reintroduce; overload; virtual;
    constructor Create(APatientDataRec: TSIScreenREaderPatientDataRec); overload; virtual;

    procedure Assign(ASource: TSIScreenReaderPatient);
    procedure AssignDataRec(APatientDataRec: TSIScreenReaderPatientDataRec);
    procedure Clear;

    property Name: string read FName write FName;
    property Task: string read FTask write FTask;
    property Company: string read FCompany write FCompany;
    property DateOfBirth: TDate read FDateOfBirth write FDateOfBirth;
    property IdDocument: string read FIdDocument write FIdDocument;
    property Id: string read FId write FId;
  end;

  TSIScreenReaderPatientList = class(TObjectList<TSIScreenReaderPatient>)
  end;


  TSIScreenReaderOperator = class(TObject)
  private
    FLocation: string;
    FName: string;
    FTest: string;
    FLot: string;
  public
    constructor Create(AName: string); reintroduce; virtual;

    procedure Assign(ASource: TSIScreenReaderOperator);
    procedure Clear;

    property Name: string read FName write FName;
    property Location: string read FLocation write FLocation;
    property Test: string read FTest write FTest;
    property Lot: string read FLot write FLot;
  end;

  TSIScreenReaderOperatorList = class(TObjectList<TSIScreenReaderOperator>)
  end;

  TSIScreenReaderImageList = class(TObjectList<TBitmap>)
  end;

  TSIScreenReaderTestResult = class(TObject)
  private
    FImages: TSIScreenReaderImageList;
    FPDFPath: string;
    FResultText: string;
  public
    constructor Create;
    destructor Destroy; override;

    property PDFPath: string read FPDFPath write FPDFPath;
    property ResultText: string read FResultText write FResultText;
    property Images: TSIScreenReaderImageList read FImages;
  end;




implementation


{ TSIScreenReaderTestResult }

constructor TSIScreenReaderTestResult.Create;
begin
  inherited Create;

  FImages := TSIScreenReaderImageList.Create;
end;

destructor TSIScreenReaderTestResult.Destroy;
begin
  FImages.Free;

  inherited;
end;

{ TSIScreenReaderOperator }

procedure TSIScreenReaderOperator.Assign(ASource: TSIScreenReaderOperator);
begin
  if not Assigned(ASource) then
    Clear
  else
  begin
    FName := ASource.Name;
    FLocation := ASource.Location;
    FTest := ASource.Test;
    FLot := ASource.Lot;
  end;
end;

procedure TSIScreenReaderOperator.Clear;
begin
  FName := EmptyStr;
  FLocation := EmptyStr;
  FTest := EmptyStr;
  FLot := EmptyStr;
end;

constructor TSIScreenReaderOperator.Create(AName: string);
begin
  Assert(AName <> EmptyStr, 'TSISROperator.Create: AName is empty.' + #13#10 +
    'An operator must have a name.');

  inherited Create;

  FName := AName;
end;

{ TSIScreenReaderPatient }

constructor TSIScreenReaderPatient.Create(AName: string);
begin
  Assert(AName <> EmptyStr, 'TSISRPatient.Create: AName is empty.' + #13#10 +
    'A patient must have at least a name.');

  inherited Create;

  FName := AName;
end;

procedure TSIScreenReaderPatient.Assign(ASource: TSIScreenReaderPatient);
begin
  if not Assigned(ASource) then
    Clear
  else
  begin
    FName := ASource.Name;
    FTask := ASource.Task;
    FCompany := ASource.Company;
    FDateOfBirth := ASource.DateOfBirth;
    FIdDocument := ASource.IdDocument;
    Id := ASource.Id;
  end;
end;

procedure TSIScreenReaderPatient.AssignDataRec(APatientDataRec: TSIScreenReaderPatientDataRec);
begin
  Assert(APatientDataRec.Name <> EmptyStr, 'TSIScreenReaderPatient.AssignDataRec: APatientDataRec.Name is empty.' + #13#10 +
    'A patient must have at least a name.');

  FName := APatientDataRec.Name;
  FTask := APatientDataRec.Task;
  FCompany := APatientDataRec.Company;
  FDateOfBirth := APatientDataRec.DateOfBirth;
  FIdDocument := APatientDataRec.IdDocument;
  Id := APatientDataRec.Id;
end;

procedure TSIScreenReaderPatient.Clear;
begin
  FName := EmptyStr;
  FTask := EmptyStr;
  FCompany := EmptyStr;
  FDateOfBirth := 0;
  FIdDocument := EmptyStr;
  Id := EmptyStr;
end;

constructor TSIScreenReaderPatient.Create(APatientDataRec: TSIScreenREaderPatientDataRec);
begin
  Assert(APatientDataRec.Name <> EmptyStr, 'TSISRPatient.Create: APatientDataRec.Name is empty.' + #13#10 +
    'A patient must have at least a name.');

  Create(APatientDataRec.Name);

  AssignDataRec(APatientDataRec);
end;


end.
