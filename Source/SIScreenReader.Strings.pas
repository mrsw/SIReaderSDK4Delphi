{*****************************************************************}
{                                                                 }
{            Embarcadero Delphi Runtime Library                   }
{            SIScreenReader.Strings unit                          }
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
unit SIScreenReader.Strings;

interface


resourcestring
  SScannerCalibrationError = 'Scanner calibration error: %s';
  SReaderProcessNotOpenedError = 'Reader process not opened.' + #13#10 + '%s';
  SUnableToRemoveOperatorError = 'Unable to remove operator.';
  SInvalidReaderError = 'Screen reader invalid reader: %s.';
  SOpeningReaderError = 'Error opening reader: %s.';
  SRemovingOperatorError = 'Error removing operator "%s": %s';
  SRemovingPatientError = 'Error removing Patient "%s": %s';
  SUnableToReadTestError = 'Unable to read test: %s';
  SReadTestError = 'Read test error: %s.';
  SNoScannerSelected = 'No scanner selected.';
  SNoTestSelected = 'No test selected.';
  SNoOperatorSelected = 'No operator selected.';
  SNoPatientSelected = 'No patient selected.';
  SSettingActiveOperatorError = 'Error setting active operator: %s.';
  SSettingActivePatientError = 'Error setting active patient: %s.';
  SSettingActiveTestError = '';


implementation

end.
