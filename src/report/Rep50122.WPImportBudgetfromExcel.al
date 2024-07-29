report 50122 "W/P Import Budget from Excel"
{
    Caption = 'Import Budget from Excel';
    ProcessingOnly = true;

    /* dataset
     {
         dataitem(BudgetBuf; "W/P Budget Buffer")
         {
             DataItemTableView = SORTING("Workplan Code", "Dimension Value Code 1", "Dimension Value Code 2", "Dimension Value Code 3", "Dimension Value Code 4", "Dimension Value Code 5", "Dimension Value Code 6", "Dimension Value Code 7", "Dimension Value Code 8", Date);

             trigger OnAfterGetRecord()
             begin
                 RecNo := RecNo + 1;

                 IF ImportOption = ImportOption::"Replace entries" THEN BEGIN
                     GLBudgetEntry.SETRANGE("Activity Code", BudgetBuf."Workplan Code");
                     GLBudgetEntry.SETRANGE(Date, Date);
                     GLBudgetEntry.SETFILTER("Entry No.", '<=%1', LastEntryNoBeforeImport);
                     IF DimCode[1] <> '' THEN
                         SetBudgetDimFilter(DimCode[1], "Dimension Value Code 1", GLBudgetEntry);
                     IF DimCode[2] <> '' THEN
                         SetBudgetDimFilter(DimCode[2], "Dimension Value Code 2", GLBudgetEntry);
                     IF DimCode[3] <> '' THEN
                         SetBudgetDimFilter(DimCode[3], "Dimension Value Code 3", GLBudgetEntry);
                     IF DimCode[4] <> '' THEN
                         SetBudgetDimFilter(DimCode[4], "Dimension Value Code 4", GLBudgetEntry);
                     IF DimCode[5] <> '' THEN
                         SetBudgetDimFilter(DimCode[5], "Dimension Value Code 5", GLBudgetEntry);
                     IF DimCode[6] <> '' THEN
                         SetBudgetDimFilter(DimCode[6], "Dimension Value Code 6", GLBudgetEntry);
                     IF DimCode[7] <> '' THEN
                         SetBudgetDimFilter(DimCode[7], "Dimension Value Code 7", GLBudgetEntry);
                     IF DimCode[8] <> '' THEN
                         SetBudgetDimFilter(DimCode[8], "Dimension Value Code 8", GLBudgetEntry);
                     IF NOT GLBudgetEntry.ISEMPTY THEN
                         GLBudgetEntry.DELETEALL(TRUE);
                 END;

                 IF Amount = 0 THEN
                     CurrReport.SKIP;
                 IF NOT PostingAccount("Workplan Code") THEN
                     CurrReport.SKIP;
                 GLBudgetEntry.INIT;
                 GLBudgetEntry."Entry No." := EntryNo;
                 GLBudgetEntry."Workplan Code" := ToGLBudgetName;
                 GLBudgetEntry."Activity Code" := "Workplan Code";
                 GLBudgetEntry.Date := Date;
                 GLBudgetEntry.Amount := ROUND(Amount);
                 GLBudgetEntry.Description := Description;

                 // Clear any entries in the temporary dimension set entry table
                 IF NOT TempDimSetEntry.ISEMPTY THEN
                     TempDimSetEntry.DELETEALL(TRUE);

                 IF "Dimension Value Code 1" <> '' THEN
                     InsertGLBudgetDim(DimCode[1], "Dimension Value Code 1", GLBudgetEntry);
                 IF "Dimension Value Code 2" <> '' THEN
                     InsertGLBudgetDim(DimCode[2], "Dimension Value Code 2", GLBudgetEntry);
                 IF "Dimension Value Code 3" <> '' THEN
                     InsertGLBudgetDim(DimCode[3], "Dimension Value Code 3", GLBudgetEntry);
                 IF "Dimension Value Code 4" <> '' THEN
                     InsertGLBudgetDim(DimCode[4], "Dimension Value Code 4", GLBudgetEntry);
                 IF "Dimension Value Code 5" <> '' THEN
                     InsertGLBudgetDim(DimCode[5], "Dimension Value Code 5", GLBudgetEntry);
                 IF "Dimension Value Code 6" <> '' THEN
                     InsertGLBudgetDim(DimCode[6], "Dimension Value Code 6", GLBudgetEntry);
                 IF "Dimension Value Code 7" <> '' THEN
                     InsertGLBudgetDim(DimCode[7], "Dimension Value Code 7", GLBudgetEntry);
                 IF "Dimension Value Code 8" <> '' THEN
                     InsertGLBudgetDim(DimCode[8], "Dimension Value Code 8", GLBudgetEntry);
                 GLBudgetEntry."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                 GLBudgetEntry.INSERT;
                 EntryNo := EntryNo + 1;
             end;

             trigger OnPostDataItem()
             begin
                 IF RecNo > 0 THEN
                     MESSAGE(Text004, GLBudgetEntry.TABLECAPTION, RecNo);

                 IF ImportOption = ImportOption::"Replace entries" THEN BEGIN
                     AnalysisView.SETRANGE("Include Budgets", TRUE);
                     IF AnalysisView.FINDSET(TRUE, FALSE) THEN
                         REPEAT
                             AnalysisView.AnalysisviewBudgetReset;
                             AnalysisView.MODIFY;
                         UNTIL AnalysisView.NEXT = 0;
                 END;
             end;

             trigger OnPreDataItem()
             begin
                 RecNo := 0;

                 GLBudgetName.SETRANGE("Workplan Code", ToGLBudgetName);
                 IF NOT GLBudgetName.FINDFIRST THEN BEGIN
                     IF NOT CONFIRM(Text001, FALSE, GLBudgetName.TABLECAPTION, ToGLBudgetName)
                     THEN
                         CurrReport.BREAK;
                     GLBudgetName."Workplan Code" := ToGLBudgetName;
                     GLBudgetName.INSERT;
                 END ELSE BEGIN
                     IF GLBudgetName.Blocked THEN BEGIN
                         MESSAGE(Text002,
                           GLBudgetEntry.FIELDCAPTION("Workplan Code"), ToGLBudgetName);
                         CurrReport.BREAK;
                     END;
                     IF NOT CONFIRM(Text003, FALSE, LOWERCASE(FORMAT(SELECTSTR(ImportOption + 1, Text027))), ToGLBudgetName) THEN
                         CurrReport.BREAK;
                 END;

                 IF GLBudgetEntry3.FINDLAST THEN
                     EntryNo := GLBudgetEntry3."Entry No." + 1
                 ELSE
                     EntryNo := 1;
                 LastEntryNoBeforeImport := GLBudgetEntry3."Entry No.";
             end;
         }
     }

     requestpage
     {
         SaveValues = true;

         layout
         {
             area(content)
             {
                 group(Options)
                 {
                     Caption = 'Options';
                     field(ToGLBudgetName; ToGLBudgetName)
                     {
                         Caption = 'Budget Name';
                         TableRelation = "G/L Budget Name";
                     }
                     field(ImportOption; ImportOption)
                     {
                         Caption = 'Option';
                         OptionCaption = 'Replace entries,Add entries';
                     }
                     field(Description; Description)
                     {
                         Caption = 'Description';
                     }
                 }
             }
         }

         actions
         {
         }

         trigger OnOpenPage()
         begin
             Description := Text005 + FORMAT(WORKDATE);
         end;

         trigger OnQueryClosePage(CloseAction: Action): Boolean
         var
             FileMgt: Codeunit "File Management";
         begin
             IF CloseAction = ACTION::OK THEN BEGIN
                 // ServerFileName := FileMgt.UploadFile(Text006, ExcelFileExtensionTok);
                 IF ServerFileName = '' THEN
                     EXIT(FALSE);

                 //SheetName := ExcelBuf.SelectSheetsName(ServerFileName);
                 IF SheetName = '' THEN
                     EXIT(FALSE);
             END;
         end;
     }

     labels
     {
     }

     trigger OnPostReport()
     begin
         ExcelBuf.DELETEALL;
         BudgetBuf.DELETEALL;
     end;

     trigger OnPreReport()
     var
         BusUnit: Record "Business Unit";
     begin
         IF ToGLBudgetName = '' THEN
             ERROR(STRSUBSTNO(Text000));

         BusUnitDimCode := 'BUSINESSUNIT_TAB220';
         TempDim.INIT;
         TempDim.Code := BusUnitDimCode;
         TempDim."Code Caption" := UPPERCASE(BusUnit.TABLECAPTION);
         TempDim.INSERT;

         IF Dim.FIND('-') THEN BEGIN
             REPEAT
                 TempDim.INIT;
                 TempDim := Dim;
                 TempDim."Code Caption" := UPPERCASE(TempDim."Code Caption");
                 TempDim.INSERT;
             UNTIL Dim.NEXT = 0;
         END;

         IF GLAcc.FIND('-') THEN BEGIN
             REPEAT
                 TempGLAcc.INIT;
                 TempGLAcc := GLAcc;
                 TempGLAcc.INSERT;
             UNTIL GLAcc.NEXT = 0;
         END;

         ExcelBuf.LOCKTABLE;
         BudgetBuf.LOCKTABLE;
         GLBudgetEntry.SETRANGE("Activity Code", ToGLBudgetName);
         IF NOT GLBudgetName.GET(ToGLBudgetName) THEN
             CLEAR(GLBudgetName);

         GLSetup.GET;
         GlobalDim1Code := GLSetup."Global Dimension 1 Code";
         GlobalDim2Code := GLSetup."Global Dimension 2 Code";
         BudgetDim1Code := GLBudgetName."Budget Dimension 1 Code";
         BudgetDim2Code := GLBudgetName."Budget Dimension 2 Code";
         BudgetDim3Code := GLBudgetName."Budget Dimension 3 Code";
         BudgetDim4Code := GLBudgetName."Budget Dimension 4 Code";

         //ExcelBuf.OpenBook(ServerFileName, SheetName);
         ExcelBuf.ReadSheet;

         AnalyzeData;
     end;

     var
         Text000: Label 'You must specify a budget name to import to.';
         Text001: Label 'Do you want to create a %1 with the name %2?';
         Text002: Label '%1 %2 is blocked. You cannot import entries.';
         Text003: Label 'Are you sure that you want to %1 for the budget name %2?';
         Text004: Label '%1 table has been successfully updated with %2 entries.';
         Text005: Label 'Imported from Excel ';
         Text006: Label 'Import Excel File';
         Text007: Label 'Analyzing Data...\\';
         Text008: Label 'You cannot specify more than 8 dimensions in your Excel worksheet.';
         Text009: Label 'WORKPLAN CODE';
         Text010: Label 'Workplan Code';
         Text011: Label 'The text Workplan Activity Code. can only be specified once in the Excel worksheet.';
         Text012: Label 'The dimensions specified by worksheet must be placed in the lines before the table.';
         Text013: Label 'Dimension ';
         Text014: Label 'Date';
         Text015: Label 'Dimension 1';
         Text016: Label 'Dimension 2';
         Text017: Label 'Dimension 3';
         Text018: Label 'Dimension 4';
         Text019: Label 'Dimension 5';
         Text020: Label 'Dimension 6';
         Text021: Label 'Dimension 7';
         Text022: Label 'Dimension 8';
         Text023: Label 'You cannot import the same information twice.\';
         Text024: Label 'The combination G/L Account No. - Dimensions - Date must be unique.';
         Text025: Label 'Workplans have not been found in the Excel worksheet.';
         Text026: Label 'Dates have not been recognized in the Excel worksheet.';
         ExcelBuf: Record "Excel Buffer";
         Dim: Record "Dimension";
         TempDim: Record "Dimension" temporary;
         GLBudgetEntry: Record "Workplan Entry";
         TempDimSetEntry: Record "Dimension Set Entry" temporary;
         GLSetup: Record "General Ledger Setup";
         GLAcc: Record "Workplan Activities";
         TempGLAcc: Record "Workplan Activities" temporary;
         GLBudgetName: Record "Workplan";
         GLBudgetEntry3: Record "Workplan Entry";
         AnalysisView: Record "Analysis View";
         DimMgt: Codeunit "DimensionManagement";
         ServerFileName: Text;
         SheetName: Text[250];
         ToGLBudgetName: Code[10];
         DimCode: array[8] of Code[20];
         EntryNo: Integer;
         LastEntryNoBeforeImport: Integer;
         GlobalDim1Code: Code[20];
         GlobalDim2Code: Code[20];
         TotalRecNo: Integer;
         RecNo: Integer;
         Window: Dialog;
         Description: Text[50];
         BusUnitDimCode: Code[20];
         BudgetDim1Code: Code[20];
         BudgetDim2Code: Code[20];
         BudgetDim3Code: Code[20];
         BudgetDim4Code: Code[20];
         ImportOption: Option "Replace entries","Add entries";
         Text027: Label 'Replace entries,Add entries';
         Text028: Label 'A filter has been used on the %1 when the budget was exported. When a filter on a dimension has been used, a column with the same dimension must be present in the worksheet imported. The column in the worksheet must specify the dimension value codes the program should use when importing the budget.';
         ExcelFileExtensionTok: Label '.xlsx', Locked = true;

     local procedure AnalyzeData()
     var
         TempExcelBuf: Record "Excel Buffer" temporary;
         BudgetBuf: Record "Budget Buffer";
         TempBudgetBuf: Record "Budget Buffer" temporary;
         HeaderRowNo: Integer;
         CountDim: Integer;
         TestDateTime: DateTime;
         OldRowNo: Integer;
         DimRowNo: Integer;
         DimCode3: Code[20];
     begin
         Window.OPEN(
           Text007 +
           '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
         Window.UPDATE(1, 0);
         TotalRecNo := ExcelBuf.COUNT;
         RecNo := 0;
         BudgetBuf.DELETEALL;

         IF ExcelBuf.FIND('-') THEN BEGIN
             REPEAT
                 RecNo := RecNo + 1;
                 Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                 TempDim.SETRANGE("Code Caption", UPPERCASE(FormatData(ExcelBuf."Cell Value as Text")));
                 CASE TRUE OF
                     (STRPOS(UPPERCASE(ExcelBuf."Cell Value as Text"), Text009) <> 0):
                         BEGIN
                             IF HeaderRowNo = 0 THEN BEGIN
                                 HeaderRowNo := ExcelBuf."Row No.";
                                 TempExcelBuf := ExcelBuf;
                                 TempExcelBuf.Comment := Text010;
                                 TempExcelBuf.INSERT;
                             END ELSE
                                 ERROR(Text011);
                         END;
                     TempDim.FINDFIRST AND (ExcelBuf."Column No." > 2) AND (ExcelBuf."Row No." <> HeaderRowNo):
                         BEGIN
                             IF HeaderRowNo <> 0 THEN
                                 ERROR(Text012);

                             TempDim.MARK(TRUE);
                             DimRowNo := ExcelBuf."Row No.";
                             DimCode3 := TempDim.Code;
                         END;
                     (ExcelBuf."Row No." = DimRowNo) AND (ImportOption = ImportOption::"Replace entries"):
                         CASE DimCode3 OF
                             BusUnitDimCode:
                                 GLBudgetEntry.SETFILTER("Business Unit Code", ExcelBuf."Cell Value as Text");
                             GlobalDim1Code:
                                 GLBudgetEntry.SETFILTER("Global Dimension 1 Code", ExcelBuf."Cell Value as Text");
                             GlobalDim2Code:
                                 GLBudgetEntry.SETFILTER("Global Dimension 2 Code", ExcelBuf."Cell Value as Text");
                             BudgetDim1Code:
                                 GLBudgetEntry.SETFILTER("Budget Dimension 1 Code", ExcelBuf."Cell Value as Text");
                             BudgetDim2Code:
                                 GLBudgetEntry.SETFILTER("Budget Dimension 2 Code", ExcelBuf."Cell Value as Text");
                             BudgetDim3Code:
                                 GLBudgetEntry.SETFILTER("Budget Dimension 3 Code", ExcelBuf."Cell Value as Text");
                             BudgetDim4Code:
                                 GLBudgetEntry.SETFILTER("Budget Dimension 4 Code", ExcelBuf."Cell Value as Text");
                         END;
                     ExcelBuf."Row No." = HeaderRowNo:
                         BEGIN
                             TempExcelBuf := ExcelBuf;
                             CASE TRUE OF
                                 TempDim.FINDFIRST:
                                     BEGIN
                                         TempDim.MARK(FALSE);
                                         CountDim := CountDim + 1;
                                         IF CountDim > 8 THEN
                                             ERROR(Text008);
                                         TempExcelBuf.Comment := Text013 + FORMAT(CountDim);
                                         TempExcelBuf.INSERT;
                                         DimCode[CountDim] := TempDim.Code;
                                     END;
                                 EVALUATE(TestDateTime, TempExcelBuf."Cell Value as Text"):
                                     BEGIN
                                         TempExcelBuf."Cell Value as Text" := FORMAT(DT2DATE(TestDateTime));
                                         TempExcelBuf.Comment := Text014;
                                         TempExcelBuf.INSERT;
                                     END;
                             END;
                         END;
                     (ExcelBuf."Row No." > HeaderRowNo) AND (HeaderRowNo > 0):
                         BEGIN
                             IF ExcelBuf."Row No." <> OldRowNo THEN BEGIN
                                 OldRowNo := ExcelBuf."Row No.";
                                 CLEAR(TempBudgetBuf);
                             END;

                             TempExcelBuf.SETRANGE("Column No.", ExcelBuf."Column No.");
                             IF TempExcelBuf.FINDFIRST THEN
                                 CASE TempExcelBuf.Comment OF
                                     Text010:
                                         BEGIN
                                             TempGLAcc.SETRANGE(
                                               "No.",
                                               COPYSTR(
                                                 ExcelBuf."Cell Value as Text",
                                                 1, MAXSTRLEN(TempBudgetBuf."G/L Account No.")));
                                             IF TempGLAcc.FINDFIRST THEN
                                                 TempBudgetBuf."G/L Account No." :=
                                                   COPYSTR(
                                                     ExcelBuf."Cell Value as Text",
                                                     1, MAXSTRLEN(TempBudgetBuf."G/L Account No."))
                                             ELSE
                                                 TempBudgetBuf."G/L Account No." := '';
                                         END;
                                     Text015:
                                         TempBudgetBuf."Dimension Value Code 1" :=
                                           COPYSTR(
                                             ExcelBuf."Cell Value as Text",
                                             1, MAXSTRLEN(TempBudgetBuf."Dimension Value Code 1"));
                                     Text016:
                                         TempBudgetBuf."Dimension Value Code 2" :=
                                           COPYSTR(
                                             ExcelBuf."Cell Value as Text",
                                             1, MAXSTRLEN(TempBudgetBuf."Dimension Value Code 2"));
                                     Text017:
                                         TempBudgetBuf."Dimension Value Code 3" :=
                                           COPYSTR(
                                             ExcelBuf."Cell Value as Text",
                                             1, MAXSTRLEN(TempBudgetBuf."Dimension Value Code 3"));
                                     Text018:
                                         TempBudgetBuf."Dimension Value Code 4" :=
                                           COPYSTR(
                                             ExcelBuf."Cell Value as Text",
                                             1, MAXSTRLEN(TempBudgetBuf."Dimension Value Code 4"));
                                     Text019:
                                         TempBudgetBuf."Dimension Value Code 5" :=
                                           COPYSTR(
                                             ExcelBuf."Cell Value as Text",
                                             1, MAXSTRLEN(TempBudgetBuf."Dimension Value Code 5"));
                                     Text020:
                                         TempBudgetBuf."Dimension Value Code 6" :=
                                           COPYSTR(
                                             ExcelBuf."Cell Value as Text",
                                             1, MAXSTRLEN(TempBudgetBuf."Dimension Value Code 6"));
                                     Text021:
                                         TempBudgetBuf."Dimension Value Code 7" :=
                                           COPYSTR(
                                             ExcelBuf."Cell Value as Text",
                                             1, MAXSTRLEN(TempBudgetBuf."Dimension Value Code 7"));
                                     Text022:
                                         TempBudgetBuf."Dimension Value Code 8" :=
                                           COPYSTR(
                                             ExcelBuf."Cell Value as Text",
                                             1, MAXSTRLEN(TempBudgetBuf."Dimension Value Code 8"));
                                     Text014:
                                         IF TempBudgetBuf."G/L Account No." <> '' THEN BEGIN
                                             BudgetBuf := TempBudgetBuf;
                                             EVALUATE(BudgetBuf.Date, TempExcelBuf."Cell Value as Text");
                                             EVALUATE(BudgetBuf.Amount, ExcelBuf."Cell Value as Text");
                                             IF NOT BudgetBuf.FIND('=') THEN
                                                 BudgetBuf.INSERT
                                             ELSE
                                                 ERROR(Text023 + Text024);
                                         END;
                                 END;
                         END;
                 END;
             UNTIL ExcelBuf.NEXT = 0;
         END;

         TempDim.SETRANGE("Code Caption");
         TempDim.MARKEDONLY(TRUE);
         IF TempDim.FINDFIRST THEN BEGIN
             Dim.GET(TempDim.Code);
             ERROR(Text028, Dim."Code Caption");
         END;

         Window.CLOSE;
         TempExcelBuf.RESET;
         TempExcelBuf.SETRANGE(Comment, Text010);
         IF NOT TempExcelBuf.FINDFIRST THEN
             ERROR(Text025);
         TempExcelBuf.SETRANGE(Comment, Text014);
         IF NOT TempExcelBuf.FINDFIRST THEN
             ERROR(Text026);
     end;

     local procedure InsertGLBudgetDim(DimCode2: Code[20]; DimValCode2: Code[20]; var GLBudgetEntry2: Record "Workplan Entry")
     var
         DimValue: Record "Dimension Value";
     begin
         IF DimCode2 <> BusUnitDimCode THEN BEGIN
             DimValue.GET(DimCode2, DimValCode2);
             TempDimSetEntry.INIT;
             TempDimSetEntry.VALIDATE("Dimension Code", DimCode2);
             TempDimSetEntry.VALIDATE("Dimension Value Code", DimValCode2);
             TempDimSetEntry.VALIDATE("Dimension Value ID", DimValue."Dimension Value ID");
             TempDimSetEntry.INSERT;
         END;
         CASE DimCode2 OF
             BusUnitDimCode:
                 GLBudgetEntry2."Business Unit Code" := COPYSTR(DimValCode2, 1, MAXSTRLEN(GLBudgetEntry2."Business Unit Code"));
             GlobalDim1Code:
                 GLBudgetEntry2."Global Dimension 1 Code" := DimValCode2;
             GlobalDim2Code:
                 GLBudgetEntry2."Global Dimension 2 Code" := DimValCode2;
             BudgetDim1Code:
                 GLBudgetEntry2."Budget Dimension 1 Code" := DimValCode2;
             BudgetDim2Code:
                 GLBudgetEntry2."Budget Dimension 2 Code" := DimValCode2;
             BudgetDim3Code:
                 GLBudgetEntry2."Budget Dimension 3 Code" := DimValCode2;
             BudgetDim4Code:
                 GLBudgetEntry2."Budget Dimension 4 Code" := DimValCode2;
         END;
     end;

     local procedure FormatData(TextToFormat: Text[250]): Text[250]
     var
         FormatInteger: Integer;
         FormatDecimal: Decimal;
         FormatDate: Date;
     begin
         CASE TRUE OF
             EVALUATE(FormatInteger, TextToFormat):
                 EXIT(FORMAT(FormatInteger));
             EVALUATE(FormatDecimal, TextToFormat):
                 EXIT(FORMAT(FormatDecimal));
             EVALUATE(FormatDate, TextToFormat):
                 EXIT(FORMAT(FormatDate));
             ELSE
                 EXIT(TextToFormat);
         END;
     end;

     procedure SetGLBudgetName(NewToGLBudgetName: Code[10])
     begin
         ToGLBudgetName := NewToGLBudgetName;
     end;

     procedure SetBudgetDimFilter(DimCode2: Code[20]; DimValCode2: Code[20]; var GLBudgetEntry2: Record "Workplan Entry")
     begin
         CASE DimCode2 OF
             BusUnitDimCode:
                 GLBudgetEntry2.SETRANGE("Business Unit Code", DimValCode2);
             GlobalDim1Code:
                 GLBudgetEntry2.SETRANGE("Global Dimension 1 Code", DimValCode2);
             GlobalDim2Code:
                 GLBudgetEntry2.SETRANGE("Global Dimension 2 Code", DimValCode2);
             BudgetDim1Code:
                 GLBudgetEntry2.SETRANGE("Budget Dimension 1 Code", DimValCode2);
             BudgetDim2Code:
                 GLBudgetEntry2.SETRANGE("Budget Dimension 2 Code", DimValCode2);
             BudgetDim3Code:
                 GLBudgetEntry2.SETRANGE("Budget Dimension 3 Code", DimValCode2);
             BudgetDim4Code:
                 GLBudgetEntry2.SETRANGE("Budget Dimension 4 Code", DimValCode2);
         END;
     end;

     procedure PostingAccount(AccNo: Code[20]): Boolean
     var
         GLAccount: Record "Workplan Activities";
     begin
         IF NOT GLAccount.GET(AccNo) THEN
             EXIT(FALSE);
         EXIT(GLAccount."Account Type" IN [GLAccount."Account Type"::Posting, GLAccount."Account Type"::"Begin-Total"]);
     end;*/
}

