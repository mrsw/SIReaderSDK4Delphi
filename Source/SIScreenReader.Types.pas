{*****************************************************************}
{                                                                 }
{            Embarcadero Delphi Runtime Library                   }
{            SIScreenReader.Types unit                            }
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
unit SIScreenReader.Types;

interface

type
  TSIScreenReaderOperatorDataRec = record
    Name: string;
    Location: string;
    Test: string;
    Lot: string;
  end;

  TSIScreenReaderPatientDataRec = record
    Name: string;
    Task: string;
    Company: string;
    DateOfBirth: TDate;
    IdDocument: string;
    Id: string;
  end;


implementation

end.
