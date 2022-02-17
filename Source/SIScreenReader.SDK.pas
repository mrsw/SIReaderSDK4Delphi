{*****************************************************************}
{                                                                 }
{            Embarcadero Delphi Runtime Library                   }
{            SIScreenReader.SDK interface unit                    }
{                                                                 }
{            Coypright (c) 2022 Carlo Marona                      }
{            Converted 9 Feb 2022 Carlo Marona                    }
{            Last modified 9 Feb 2022 Carlo Marona                }
{            Version 1.0                                          }
{                                                                 }
{*****************************************************************}

{*****************************************************************}
{                                                                 }
{ The contents of this file are Subject to the Mozilla Public     }
{ License Version 1.1 (the "License"). you may not use this file  }
{ except in compliance with the License. You may obtain a copy of }
{ the License at http://www.mozilla.org/MPL/MPL-1.1.html          }
{                                                                 }
{ Software distributed under the License is distributed on an     }
{ "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or  }
{ implied. See the License for the specific language governing    }
{ rights and limitations under the License.                       }
{                                                                 }
{ The original code is: ReaderSDK.h, released 2022.               }
{                                                                 }
{ The initial developer of the original translation is            }
{ Carlo Marona (marona@soft4you.it).                              }
{                                                                 }
{ Portions created by Carlo Marona are                            }
{ Copyright (C) 2022 Carlo Marona.                                }
{                                                                 }
{ Portions created by Screen Italia s.r.l. are                    }
{ Copyright (C) 2022 Screen Italia s.r.l.                         }
{                                                                 }
{ All Rights Reserved.                                            }
{                                                                 }
{ Contributor(s):                                                 }
{                                                                 }
{ Notes:                                                          }
{ You require ReaderSDK.dll                                       }
{                                                                 }
{ Modification history:                                           }
{                                                                 }
{ Known Issues:                                                   }
{                                                                 }
{*****************************************************************}

unit SIScreenReader.SDK;

interface

uses
  Windows
  ;


  { **************************************************************************************************************************** }
  { *                                     General functions                                                                    * }
  { **************************************************************************************************************************** }

  { Intitializes SDK engine.
    Returns True if the initialization was successfull, False otherwise..
    The value of the optional parameter "OptionalPriorityName" selects the software to operate on.
    It's needed only if on the machine are simultaneously installed the "FutuReader" and "ScreenReader" softwares.
    It's also needed if the software was installed in a custom path different from the default one and it must include the
    complete path. (er: "C:\Users\Public\ScreenReader\ScreenReader.exe" or "C:\Users\Public\FutuReader\FutuReader.exe") }
  function InitEngineSDK(OptionalPriorityName: PAnsiChar = nil): boolean; stdcall;

  { Executes the reader software (FutuReader.exe o ScreenReader.exe).
    Returns True if execution was successfull, False otherwise..
    This is a synchronous function and returns after the execution was completed.
    The value of the optional parameter "ShowUI" determines if the reader GUI must be visible or not. }
  function ExecuteReaderSoftware(ShowUI: boolean = True): boolean; stdcall;

  { Starts scan of selected Test.
    Returns True if the scan was successfull, False otherwise.
    If the function returns True, you can call GetFullPathPdfFileResult(), GetFullResultText(), GetImageResultHBITMAP()
    GetImageResultData(), GetImageResultDataSize() to retrieve test result. }
  function StartScanTest: boolean; stdcall;

  { Close the reader software.
    Returns True if the software was closed successfully, False otherwise.
    IMPORTANT! Remeber to call this function to close the software otherwise it will remain orphan and it must be closed through
    task manager. }
  function CloseReaderSoftware: boolean; stdcall;

  { Returns the name of the executable file of the Reader software (ScreenReader.exe o FutuReader.exe). }
	function GetReaderFileName: PAnsiChar; stdcall;

  { Returns the path of the executable file of the Reader software. }
	function GetReaderFilePath: PAnsiChar; stdcall;

  { Returns, when possible, a description of the last error occurred. }
	function GetLastError: PAnsiChar; stdcall;

  { Returns the full path of the previously read test result (.pdf) through the function StartScanTest(). }
	function GetFullPathPdfFileResult: PAnsiChar; stdcall;

  { Returns a string containing the previously read test result through the function StartScanTest() in a plain text format. }
	function GetFullResultText: PAnsiChar; stdcall;

  { Execute calibration procedure on the scanner passed in the parameter "Scanner".
    If the parameter was omitted, the calibration will be made on the last used scanner (connected).
    Acceptable values for the "Scanner" parameter are:
    For Box type scanners, “ScreenBox L”, “ScreenBox S”, “ScreenBox V”
    For Plain type scanners, “Plustek OpticSlim 500”, “Plustek OpticSlim 500+”, “Plustek OpticSlim 2610-TWAIN”, “AVA5 Plus 11.11”,
    etc...). }
	function CalibrateBox(const Scanner: PAnsiChar): boolean; stdcall;

  // Scanner functions

  { Returns the active device name of the selected scanner (ScreenBox, OpticSlim 500,OpticSlim 500).
    If the device is not availbale (ex. powered off scanner), it returns an empty string. }
  function GetActiveScanner: PAnsiChar; stdcall;

  { Set the scanner to use for tests reading. }
	function SetActiveScanner(const Scanner: PAnsiChar): boolean; stdcall;


  { **************************************************************************************************************************** }
  { *                                     Tests functions                                                                      * }
  { **************************************************************************************************************************** }

  { Returns the full name of the test actually set. It will be used on executing the function StartScanTest(). }
	function GetActiveTest: PAnsiChar; stdcall;

  { Set the test that will be used on the execution of the function StartScanTest().
    Returns True if the setting was completed correctly. }
	function SetActiveTest(const TestName: PAnsiChar): boolean; stdcall;

  { Returns the test name at the index passed in "TestIndex" parameter.
    "TestIndex" parameter value is between 0 (the first on the list) and a GetAvailableTestCount() - 1 (the last one).
    If "TestIndex" is set to -1 the function returns the full tests list available separated by "\n". }
  function GetTestName(TestIndex: integer = -1): PAnsiChar; stdcall;

  { Returns total available tests count.
    Can be used in conjunction with "GetTestName()" to retrieve all available tests names. }
  function GetAvailableTestCount: integer; stdcall;


  { **************************************************************************************************************************** }
  { *                                     Patients functions                                                                   * }
  { **************************************************************************************************************************** }

  { Returns the full list of patient names of active operator.
    Names are separated by "\n". }
	function GetPatientsNamesList: PAnsiChar; stdcall;

  { Returns the active patient name that will be used for the test reading through the function StartScanTest(). }
	function GetActivePatientName: PAnsiChar; stdcall;

  { Returns the identity document of the active patient that will be used for the test reading through the function
    StartScanTest(). }
	function GetActivePatientDocument: PAnsiChar; stdcall;

  { Set the active patient that will be used for the test reading through the function StartScanTest().
    The function uses the "PatientName" parameter value to retrieve and set all patient data needed for the test reading. }
	function SetActivePatientByName(const PatientName: PAnsiChar): boolean; stdcall;

  { Set the active patient that will be used for the test reading through the function StartScanTest().
    The function uses the "PatientName" parameter value to retrieve and set all patient data needed for the test reading.}
	function SetActivePatientByDocument(const Document: PAnsiChar): boolean; stdcall;

  { Returns an XML formatted string containing the patient data using the patient name passed in "PatientName" parameter.
    Returned data example:
    <paziente nome="Mario Rossi" qualifica="Manager" azienda="FCA Italy S.p.A" data_nascita="12/10/1985"
    doc_identita="RSSMRA85T10A562S" codice_paziente=""
    campi_personalizzati="email|mario.rossi@esempio.com||tel|3215487||Indirizzo|Via del Monte 32||sesso|M" /> }
  function GetPatientRecordByName(const PatientName: PAnsiChar): PAnsiChar; stdcall;

  { Returns an XML formatted string containing the patient data using the patient identity document passed in "Document" parameter.
    Returned data example:
    <paziente nome="Mario Rossi" qualifica="Manager" azienda="FCA Italy S.p.A" data_nascita="12/10/1985"
    doc_identita="RSSMRA85T10A562S" codice_paziente=""
    campi_personalizzati="email|mario.rossi@esempio.com||tel|3215487||Indirizzo|Via del Monte 32||sesso|M" /> }
	function GetPatientRecordByDocument(const Document: PAnsiChar): PAnsiChar; stdcall;

  { Add new patient to the Reader software database.
    The "Data" parameter must contains patient data in XML format.
    This is an example of the data parameter value:
    <paziente nome="Mario Rossi" qualifica="Manager" azienda="FCA Italy S.p.A" data_nascita="12/10/1985" doc_identita="RSSMRA85T10A562S"
    codice_paziente="" campi_personalizzati="email|mario.rossi@esempio.com||tel|3215487||Indirizzo|Via del Monte 32||sesso|M" />
    Order doesn't matter but the fields nome, qualifica, azienda, data_nascita, doc_identita, codice_paziente and
    campi_personalizzati must be set anyway. Unused fields must be set empty.
    The field nome cannot be left empty.
    To add a patient using the name only you can do as follows:
    <paziente nome="Mario Rossi" qualifica="" azienda="" data_nascita="" doc_identita="" codice_paziente="" campi_personalizzati="" />
    It's strongly racommended to set, other than the name of the patient, an identity document to distinguish homonyms patients.
    You can insert multiple patients at the same time, using multiple XML patient elements as follows:
    <paziente nome="Mario Rossi" qualifica="Manager" azienda="FCA Italy S.p.A" data_nascita="12/10/1985" doc_identita="RSSMRA85T10A562S"
    codice_paziente="" campi_personalizzati="email|mario.rossi@esempio.com||tel|3215487||Indirizzo|Via del Monte 32||sesso|M" />
    <paziente nome="Ornella Pieri" qualifica="Segretaria" azienda="FCA Italy S.p.A" data_nascita="22/12/1979"
    doc_identita="PRIRLL79T62H501M" codice_paziente="1234" campi_personalizzati="email|ornella.pieri@esempio.com||tel|+393215487||Luogo
    di nascita|Roma||sesso|M" />
    <paziente nome="Francesco Nuti" qualifica="operaio" azienda="ACME srl" data_nascita="01/01/1990" doc_identita="NTUFNC90A01F205X"
    codice_paziente="DB123" campi_personalizzati="email|francesco.nuti@esempio.com||tel|123456789||Luogo di nascita|Milano||vaccinato|si" />
    The field campi_personalizzati can contains custom data fields in the form of ”Field1|Value1||Field2|Value2||
    Field3|Value3 … FieldN|ValueN”.
    The function returns correctly inserted records count. }
  function AddNewPatientRecord(const Data: PAnsiChar): integer; stdcall;

  { Remove a patient from the Reader software database through his name. }
	function RemovePatientByName(const Name: PAnsiChar): boolean; stdcall;

  { Remove a patient from the Reader software database through his identity document. }
	function RemovePatientByDocument(const Document: PAnsiChar): boolean; stdcall;

  { **************************************************************************************************************************** }
  { *                                     Operators functions                                                                  * }
  { **************************************************************************************************************************** }

  { Returns operators names list stored in Reader software database.
    Names are separated by "\n". }
	function GetOperatorsNamesList: PAnsiChar; stdcall;

  { This function adds a new operator to the Reader software database.
    Th "Data" field must be populated in XML format as follows:
    <operatore nome="Dr Luigi Balestrin" luogo="Roma" tester="Screen 7+AD (DUA-174)" lotto="21547" />
    IMPORTANT! Actually only the fields nome, luogo, tester and lotto can be set through the SDK.
    Remaining fields (scanner, path_verb,frontespizio_verb,reduce_font_size,creatinina_verb,firma_verb,firma_responsabile,firma_da_immagine,
    show_quantita_campione_verb,quantita_campione_verb,show_note_alcol,note_alcol,show_campi_personalizzati,
    show_temperatura_campione_verb,temperatura_campione_verb,show_farmaci_assunti_verb,farmaci_assunti_verb,codice_paziente_verb,
    qualifica_soggetto_verb,azienda_soggetto_verb,data_nascita_verb,doc_identita_verb,foto_test_verb,stampa_dichiarazione,stampa_note,
    dichiarazione_paziente_verb,note_verb) are automatically filled with defaul values.
    The function returns correctly inserted records count. }
	function AddNewOperatorRecord(const Data: PAnsiChar): integer; stdcall;

  { Removes an operator and all his data from the Reader software database through his name
    IMPORTANT! All data associated with the operator (ex. patients) will also be deleted! }
	function RemoveOperatorByName(const Name: PAnsiChar): boolean; stdcall;

  { Set the active operator through his name loading operator data. }
	function SetActiveOperatorByName(const OperatorName: PAnsiChar): boolean; stdcall;


  { **************************************************************************************************************************** }
  { *                                     Result Images functions                                                              * }
  { **************************************************************************************************************************** }

  { Returns the images count of the test read trough StartScanTest().
    The returned value can be used in conjunction with GetImageResultHBITMAP(int index_image), GetImageResultData(int index_image)
    and GetImageResultDataSize(int index_image) functions to retrieve test result images. }
 	function GetResultImagesCount: integer; stdcall;

  { Returns a pointer to one of the images used to calculate test result after calling StartScanTest().
    "ImageIndex" parameter is optional if only one image si available.
    GetImageResultDataSize() function can be used to obtain image bitmap size.
    Ex: BYTE *img=ReaderSDK::GetImageResultData();
    unsigned int img_size=ReaderSDK::GetImageResultDataSize();
    SaveBufferToFile("ResultImage.bmp", img, img_size); }
	function GetImageResultData(ImageIndex: integer = 0): PByte; stdcall;

  { Returns test image bitmap size used to calculate test result after calling StartScanTest().
    "ImageIndex" parameter is optional if only one image si available. }
	function GetImageResultDataSize(IndexImage: integer = 0): TSize; stdcall;

  { Returns an handle to the image bitmap used to calculate test result after calling StartScanTest().
    "ImageIndex" parameter is optional if only one image si available. }
	function GetImageResultHBITMAP(ImageIndex: integer = 0): HBITMAP; stdcall;




const
  FUTUREADER    = 'FutuReader';
  SCREENREADER  = 'ScreenReader';





implementation


const
  ReaderSDKDLL = 'ReaderSDK.dll';

  // General functions
  { Inizializza il motore SDK, se è tutto ok ritorna true.
    Il valore passato 'optional_priority_name' è opzionale e può essere omesso nel caso nel computer esista una sola installazione del FutuReader o dello
    ScreenReader, ma nel caso siano presenti entrambi i software nella stessa macchina occorrerà specificare quale dei 2 pilotare popolando la stringa
    optional_priority_name con la parola “ FutuReader” o “ScreenReader” a secondo delle proprie esigenze.
    Anche nel caso che il software sia stato installato a mano in una differente directory rispetto quella di default, bisognerà impostare la variabile
    optional_priority_name, questa volta con il percorso completo del software da pilotare (es: “C:\Users\Public\ScreenReader\ScreenReader.exe” oppure
    “C:\Users\Public\FutuReader\FutuReader.exe”). }
  function InitEngineSDK(OptionalPriorityName: PAnsiChar = nil): boolean; stdcall; external ReaderSDKDLL name '_InitEngineSDK';
  { Esegue il software Reader ( FutuReader.exe o ScreenReader.exe) di lettura dei test rapidi.
    Una volta eseguito e verificato che sia pronto torna true se tutto ok, la funzione è sincrona.
    Se il valore show_reader è omesso oppure è impostato a true il software Reader sarà visibile, nel caso invece sia impostato a false appena eseguiti i
    controlli di licenza e aggiornamento, l’interfaccia del software sarà nascosta. }
  function ExecuteReaderSoftware(ShowUI: boolean = True): boolean; stdcall; external ReaderSDKDLL name '_ExecuteReaderSoftware';
  { Avvia la procedura di lettura del test, che se va a buon fine torna true e si potrà poi procedere al reperimento dei risultati attraverso l’utilizzo di
    GetFullPathPdfFileResult() , GetFullResultText(), GetImageResultHBITMAP() (o in alternativa a quest’ultima GetImageResultData() e
    GetImageResultDataSize() ). Si rimanda alla descrizione di queste funzioni per il loro utilizzo nel dettaglio.
    Nota che il valore di ritorno di questa funzione non è relazionato alla corretta lettura del test, ma alla corretta esecuzione della procedura che avvia la
    lettura. Nel caso ci siano problemi di lettura del test (es: test inserito errato o mancante o altro) lo si potrà facilmente dedurre dalla mancanza dei
    risultati di ritorno nelle funzioni sopra citate. }
  function StartScanTest: boolean; stdcall; external ReaderSDKDLL name '_StartScanTest';
  { Chiude il software Reader di lettura, una volta eseguito torna true se l'applicazione è stata chiusa con successo. Nel caso il software remoto sia stato
    lanciato con interfaccia nascosta, è importante non dimenticare di usare questa funzione altrimenti rimarrebbe aperto in background ed impedirebbe il
    suo utilizzo fino alla sua chiusura attraverso il task manager o un riavvio della macchina. Potrebbe essere utile inserire questa funzione nell’evento di
    chiusura dell’applicazione che utilizza l’SDK. }
  function CloseReaderSoftware: boolean; stdcall; external ReaderSDKDLL name '_CloseReaderSoftware';
  { Restituisce il nome del file eseguibile del Reader (ScreenReader.exe o FutuReader.exe ). }
	function GetReaderFileName: PAnsiChar; stdcall; external ReaderSDKDLL name '_GetReaderFileName';
  { Restituisce il percorso dell'eseguibile del software Reader. }
	function GetReaderFilePath: PAnsiChar; stdcall; external ReaderSDKDLL name '_GetReaderFilePath';
  { Restituisce una descrizione, quando possibile, dell'ultimo errore accaduto. Potrebbe essere utile da richiamare subito dopo aver chiamato una funzione che
    abbia dato un risultato inatteso. }
	function GetLastError: PAnsiChar; stdcall; external ReaderSDKDLL name '_GetLastError';
  { Restituisce il percorso completo del nome del file del risultato (verbale pdf) del test precedentemente letto attraverso la funzione StartScanTest(). }
	function GetFullPathPdfFileResult: PAnsiChar; stdcall; external ReaderSDKDLL name '_GetFullPathPdfFileResult';
  { Restituisce una stringa che contiene sostanzialmente il risultato (verbale in pdf) del test precedentemente letto attraverso la funzione StartScanTest() in
    forma di puro testo. }
	function GetFullResultText: PAnsiChar; stdcall; external ReaderSDKDLL name '_GetFullResultText';
  { Esegue la procedura di calibrazione del lettore denominato in scanner_name.
    Valori possibili per i lettori di tipo Box sono “ScreenBox L”, “ScreenBox S”, “ScreenBox V” mentre per i lettori di tipo scanner piano sono “Plustek
    OpticSlim 500”, “Plustek OpticSlim 500+”, “Plustek OpticSlim 2610-TWAIN” e “AVA5 Plus 11.11” ecc...).
    NB: Omettendo il parametro scanner_name : CalibrateBox() selezionerà in automatico l’ultimo lettore usato ed attualmente collegato (scelta
    consigliata). }
	function CalibrateBox(const Scanner: PAnsiChar): boolean; stdcall; external ReaderSDKDLL name '_CalibrateBox';

  // Scanner functions
  { Restituisce il nome della periferica utilizzata come lettore ottico (ScreenBox, OpticSlim 500,OpticSlim 500. Se non reperibile (come ad esempio
    ScreenBox spento) torna stringa vuota. }
  function GetActiveScanner: PAnsiChar; stdcall; external ReaderSDKDLL name '_GetActiveScanner';
  { Imposta il lettore ottico da utilizzare per la lettura dei tests rapidi. }
	function SetActiveScanner(const Scanner: PAnsiChar): boolean; stdcall; external ReaderSDKDLL name '_SetActiveScanner';

  // Tests functions
  { Restituisce il nome completo del test attualmente impostato e che sarà letto durante l’esecuzione di StartScanTest(). }
	function GetActiveTest: PAnsiChar; stdcall; external ReaderSDKDLL name '_GetActiveTest';
  { Imposta il test che sarà utilizzato al momento della lettura attraverso l’esecuzione di StartScanTest().
    Torna true se è stato correttamente impostato. Per avere un elenco e completo e preciso nella denominazione dei tests usare le funzioni
    GetAvailableTestCount() e GetTestName(int test_index). }
	function SetActiveTest(const TestName: PAnsiChar): boolean; stdcall; external ReaderSDKDLL name '_SetActiveTest';
  { Restituisce il nome del test alla posizione test_index.
    test_index è un valore compreso da 0 (per il primo elemento) a GetAvailableTestCount()-1 (per l'ultimo).
    Se si imposta test_index uguale a -1 la funzione ritorna la lista completa di tutti i test rapidi supportati con separatore ‘\n’. }
	function GetTestName(TestIndex: integer = -1): PAnsiChar; stdcall; external ReaderSDKDLL name '_GetTestsName';
  { Restituisce il numero di tutti i test che il lettore può leggere.
    Servirà per fare un loop insieme alla funzione "GetTestName(int test_index)" per reperire il nome di ogni singolo test
    leggibile dal lettore. }
	function GetAvailableTestCount: integer; stdcall; external ReaderSDKDLL name '_GetAvailableTestCount';

  // Patients functions
  { Restituisce la lista dei nomi di tutti i pazienti dell’operatore attivo.
    Come separatore dei nomi è usato ‘\n’ . }
	function GetPatientsNamesList: PAnsiChar; stdcall; external ReaderSDKDLL name '_GetListIndividualsNames';
  { Restituisce il nome del paziente che è impostato per la lettura attraverso l’esecuzione di StartScanTest(). }
	function GetActivePatientName: PAnsiChar; stdcall; external ReaderSDKDLL name '_GetActiveIndividualName';
  { Imposta come attivo il record del paziente che corrisponde al nominativo individual_name caricando le relative informazioni anagrafiche che
    serviranno per la redazione del verbale in seguito alla lettura del test attraverso l’esecuzione di StartScanTest(). }
	function SetActivePatientByName(const PatientName: PAnsiChar): boolean; stdcall; external ReaderSDKDLL name '_SetActiveIndividualByName';
  { Restituisce il documento di identità del paziente che è impostato per la lettura attraverso l’esecuzione di StartScanTest(). }
	function GetActivePatientDocument: PAnsiChar; stdcall; external ReaderSDKDLL name '_GetActiveIndividualDocument';
  { Imposta come attivo il record del paziente che corrisponde al documento di identità _document caricando le relative informazioni anagrafiche che
    serviranno per la redazione del verbale in seguito alla lettura del test attraverso l’esecuzione di StartScanTest(). }
	function SetActivePatientByDocument(const Document: PAnsiChar): boolean; stdcall; external ReaderSDKDLL name '_SetActiveIndividualByDocument';
  { Restituisce una stringa in stile XML con i dati relativi al paziente selezionato attraverso l’identificato del nome.
    Un esempio di stringa ritornata può essere:
    <paziente nome="Mario Rossi" qualifica="Manager" azienda="FCA Italy S.p.A" data_nascita="12/10/1985" doc_identita="RSSMRA85T10A562S"
    codice_paziente="" campi_personalizzati="email|mario.rossi@esempio.com||tel|3215487||Indirizzo|Via del Monte 32||sesso|M" /> }
	function GetPatientRecordByName(const PatientName: PAnsiChar): PAnsiChar; stdcall; external ReaderSDKDLL name '_GetIndividualRecordByName';
  { Restituisce una stringa in stile XML con i dati relativi al paziente selezionato attraverso l’identificato del documento di identità.
    Un esempio di stringa ritornata può essere:
    <paziente nome="Mario Rossi" qualifica="Manager" azienda="FCA Italy S.p.A" data_nascita="12/10/1985" doc_identita="RSSMRA85T10A562S"
    codice_paziente="" campi_personalizzati="email|mario.rossi@esempio.com||tel|3215487||Indirizzo|Via del Monte 32||sesso|M" /> }
	function GetPatientRecordByDocument(const Document: PAnsiChar): PAnsiChar; stdcall; external ReaderSDKDLL name '_GetIndividualRecordByDocument';
  { Con questa funzione si può aggiungere un nuovo paziente al database completo della sua anagrafica ed eventuali campi aggiuntivi.
    Il campo _data va popolato con una testo nello stile XML come ad esempio nel seguente modo:
    <paziente nome="Mario Rossi" qualifica="Manager" azienda="FCA Italy S.p.A" data_nascita="12/10/1985" doc_identita="RSSMRA85T10A562S"
    codice_paziente="" campi_personalizzati="email|mario.rossi@esempio.com||tel|3215487||Indirizzo|Via del Monte 32||sesso|M" />
    L’ordine non è obbligatorio ma i campi nome, qualifica, azienda, data_nascita, doc_identita,codice_paziente e campi_personalizzati devono
    comunque essere impostati, nel caso in cui non vengo utilizzati possono essere settati come vuoti ad eccezione del nome che contiene il nome e
    cognome del paziente quindi si può aggiungere un paziente con il minimo dei dati (cioè il solo nominativo) ad esempio nel seguente modo:
    <paziente nome="Mario Rossi" qualifica="" azienda="" data_nascita="" doc_identita="" codice_paziente="" campi_personalizzati="" />
    Si consiglia, ad ogni modo, di inserire oltre al nominativo anche un documento di identità univoco attraverso il campo doc_identita questo permette al
    software di selezionare e salvare correttamente pazienti che abbiano lo stesso nome e cognome, la necessità di questo campo non è comunque
    obbligatoria finché non si inseriscono pazienti con omonimia.
    La stessa funzione permette di inserire più nuovi paziente contemporaneamente basta popolare la variabile _data con una stringa ad esempio nel
    seguente modo:
    <paziente nome="Mario Rossi" qualifica="Manager" azienda="FCA Italy S.p.A" data_nascita="12/10/1985" doc_identita="RSSMRA85T10A562S"
    codice_paziente="" campi_personalizzati="email|mario.rossi@esempio.com||tel|3215487||Indirizzo|Via del Monte 32||sesso|M" />
    <paziente nome="Ornella Pieri" qualifica="Segretaria" azienda="FCA Italy S.p.A" data_nascita="22/12/1979"
    doc_identita="PRIRLL79T62H501M" codice_paziente="1234" campi_personalizzati="email|ornella.pieri@esempio.com||tel|+393215487||Luogo
    di nascita|Roma||sesso|M" />
    <paziente nome="Francesco Nuti" qualifica="operaio" azienda="ACME srl" data_nascita="01/01/1990" doc_identita="NTUFNC90A01F205X"
    codice_paziente="DB123" campi_personalizzati="email|francesco.nuti@esempio.com||tel|123456789||Luogo di nascita|Milano||vaccinato|si" />
    Per quanto riguarda la voce campi_personalizzati può contenere campi/valori personalizzati nella forma ”campo1|valore1||campo2|valore2||
    campo3|valore3 … campoN|valoreN”.
    La funzione restituisce il numero dei record correttamente inseriti. }
	function AddNewPatientRecord(const Data: PAnsiChar): integer; stdcall; external ReaderSDKDLL name '_AddNewIndividualRecord';
  { Rimuove un paziente dal database compresa la sua anagrafe attraverso l’identificazione del nominativo. }
	function RemovePatientByName(const Name: PAnsiChar): boolean; stdcall; external ReaderSDKDLL name '_RemoveIndividualByName';
  { Rimuove un paziente dal database compresa la sua anagrafe attraverso l’identificazione del documento di identità. }
	function RemovePatientByDocument(const Document: PAnsiChar): boolean; stdcall; external ReaderSDKDLL name '_RemoveIndividualByDocument';

  // Operators functions
  { Restituisce la lista dei nomi di tutti gli operatori presenti nel database.
    Come separatore dei nomi è usato ‘\n’ . }
	function GetOperatorsNamesList: PAnsiChar; stdcall; external ReaderSDKDLL name '_GetListOperatorsNames';
//  function GetActiveOperatorName: PAnsiChar; stdcall; external ReaderSDKDLL name '_GetActiveOperatorName';
  { Con questa funzione si può aggiungere al database un nuovo operatore con alcuni parametri di base.
    Il campo _data va popolato con una testo nello stile XML come ad esempio nel seguente modo:
    <operatore nome="Dr Luigi Balestrin" luogo="Roma" tester="Screen 7+AD (DUA-174)" lotto="21547" />
    NB: Attualmente i campi sopra indicati ( nome, luogo, tester, lotto) sono i soli a poter essere impostati tramite SDK.
    Gli altri campi (scanner, path_verb,frontespizio_verb,reduce_font_size,creatinina_verb,firma_verb,firma_responsabile,firma_da_immagine,
    show_quantita_campione_verb,quantita_campione_verb,show_note_alcol,note_alcol,show_campi_personalizzati,
    show_temperatura_campione_verb,temperatura_campione_verb,show_farmaci_assunti_verb,farmaci_assunti_verb,codice_paziente_verb,
    qualifica_soggetto_verb,azienda_soggetto_verb,data_nascita_verb,doc_identita_verb,foto_test_verb,stampa_dichiarazione,stampa_note,
    dichiarazione_paziente_verb,note_verb) vengono creati automaticamente con i valori di default.
    La funzione restituisce il numero dei record correttamente inseriti. }
  function AddNewOperatorRecord(const Data: PAnsiChar): integer; stdcall; external ReaderSDKDLL name '_AddNewOperatorRecord';
  { Rimuove un paziente e la sua anagrafe dal database attraverso l’identificazione del nominativo.
    ATTENZIONE: Insieme all’operatore verranno cancellati anche tutti i pazienti/individui (e i relativi dati anagrafici) associati ad esso. }
	function RemoveOperatorByName(const Name: PAnsiChar): boolean; stdcall; external ReaderSDKDLL name '_RemoveOperatorByName';
  { Imposta come attivo il record dell’operatore che corrisponde al nominativo operator_name caricando le relative informazioni. }
	function SetActiveOperatorByName(const OperatorName: PAnsiChar): boolean; stdcall; external ReaderSDKDLL name '_SetActiveOperatorByName';

  // Test images function
  { Nel caso in cui il test appena letto abbia più facciate, torna il numero delle immagini relative, tale valore può essere usato in associazione con le
    funzioni GetImageResultHBITMAP(int index_image), GetImageResultData(int index_image) e GetImageResultDataSize(int index_image). }
 	function GetResultImagesCount: integer; stdcall; external ReaderSDKDLL name '_GetCountResultImages';
  { Restituisce un puntatore di tipo unsigned char dell’immagine bitmap del test che è stata utilizzata per elaborare il risultato del test precedentemente letto
    attraverso la funzione StartScanTest().
    Nel caso in cui il test abbia più facciate e quindi più immagini index_image viene utilizzato per specificare quale, index_image è opzionale nel caso
    ci sia una sola immagine. GetImageResultDataSize() può essere utilizzata per tornare la dimensione della bitmap.
    Es: BYTE *img=ReaderSDK::GetImageResultData();
    unsigned int img_size=ReaderSDK::GetImageResultDataSize();
    SaveBufferToFile("ResultImage.bmp",img,img_size); }
	function GetImageResultData(ImageIndex: integer = 0): PByte; stdcall; external ReaderSDKDLL name '_GetImageResultData';
  { Restituisce le dimensione in byte della bitmap dell’immagine del test che è stata utilizzata per elaborare il risultato del test precedentemente letto attraverso
    la funzione StartScanTest().
    Nel caso in cui il test abbia più facciate e quindi più immagini index_image viene utilizzato per specificare quale, index_image è opzionale nel caso
    ci sia una sola immagine. Per utilizzo con GetImageResultData() vedi esempio nella relativa descrizione della funzione. }
	function GetImageResultDataSize(IndexImage: integer = 0): TSize; stdcall; external ReaderSDKDLL name '_GetImageResultDataSize';
  { Restituisce un handle alla bitmap dell’immagine del test che è stata utilizzata per elaborare il risultato del test precedentemente letto attraverso la funzione
    StartScanTest().
    Nel caso in cui il test abbia più facciate e quindi più immagini index_image viene utilizzato per specificare quale, index_image è opzionale nel caso
    ci sia una sola immagine. GetCountResultImages() invece può essere utilizzata per tornare quante immagini contiene il test appena letto.
    Vedi anche GetImageResultData() e GetImageResultDataSize() che possono essere usati come alternativa. }
	function GetImageResultHBITMAP(ImageIndex: integer = 0): HBITMAP; stdcall; external ReaderSDKDLL name '_GetImageResultHBITMAP';

end.
