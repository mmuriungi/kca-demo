report 50125 "W/P Export Budget to Excel"
{
    Caption = 'Export Budget to Excel';
    ProcessingOnly = true;

    /* dataset
     {
         dataitem(DataItem3459; "Workplan Entry")
         {
             DataItemTableView = SORTING("Workplan Code", "Activity Code", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Dimension 1 Code", "Budget Dimension 2 Code", "Budget Dimension 3 Code", "Budget Dimension 4 Code", Date);
             RequestFilterFields = "Workplan Code", "Activity Code", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Dimension 1 Code", "Budget Dimension 2 Code", "Budget Dimension 3 Code", "Budget Dimension 4 Code", Date;

             trigger OnAfterGetRecord()
             begin
                 CLEAR(TempBudgetBuf1);
                 TempBudgetBuf1."Workplan Code" := "G/L Account No.";
                 TempBudgetBuf1."Dimension Value Code 1" := GetDimValueCode(ColumnDimCode[1]);
                 TempBudgetBuf1."Dimension Value Code 2" := GetDimValueCode(ColumnDimCode[2]);
                 TempBudgetBuf1."Dimension Value Code 3" := GetDimValueCode(ColumnDimCode[3]);
                 TempBudgetBuf1."Dimension Value Code 4" := GetDimValueCode(ColumnDimCode[4]);
                 TempBudgetBuf1."Dimension Value Code 5" := GetDimValueCode(ColumnDimCode[5]);
                 TempBudgetBuf1."Dimension Value Code 6" := GetDimValueCode(ColumnDimCode[6]);
                 TempBudgetBuf1."Dimension Value Code 7" := GetDimValueCode(ColumnDimCode[7]);
                 TempBudgetBuf1."Dimension Value Code 8" := GetDimValueCode(ColumnDimCode[8]);
                 TempBudgetBuf1.Date := CalcPeriodStart(Date);
                 TempBudgetBuf1.Amount := Amount;

                 TempBudgetBuf2 := TempBudgetBuf1;
                 IF TempBudgetBuf2.FIND THEN BEGIN
                     TempBudgetBuf2.Amount :=
                       TempBudgetBuf2.Amount + TempBudgetBuf1.Amount;
                     TempBudgetBuf2.MODIFY;
                 END ELSE
                     TempBudgetBuf2.INSERT;
             end;

             trigger OnPostDataItem()
             var
                 DimValue: Record "Dimension Value";
                 BusUnit: Record "Business Unit";
                 Window: Dialog;
                 RecNo: Integer;
                 TotalRecNo: Integer;
                 Continue: Boolean;
                 LastBudgetRowNo: Integer;
                 DimensionRange: array[2, 8] of Integer;
             begin
                 Window.OPEN(
                   Text005 +
                   '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
                 Window.UPDATE(1, 0);
                 TotalRecNo := GLAcc.COUNT;
                 RecNo := 0;

                 RowNo := 1;
                 EnterCell(RowNo, 1, Text006, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                 EnterCell(RowNo, 2, '', FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                 EnterFilterInCell(GETFILTER("Workplan Code"), FIELDCAPTION("Workplan Code"));

                 GLSetup.GET;
                 EnterFilterInCell(GETFILTER("Business Unit Code"), FIELDCAPTION("Business Unit Code"));
                 IF GLSetup."Global Dimension 1 Code" <> '' THEN BEGIN
                     Dim.GET(GLSetup."Global Dimension 1 Code");
                     EnterFilterInCell(GETFILTER("Global Dimension 1 Code"), Dim."Code Caption");
                 END;
                 IF GLSetup."Global Dimension 2 Code" <> '' THEN BEGIN
                     Dim.GET(GLSetup."Global Dimension 2 Code");
                     EnterFilterInCell(GETFILTER("Global Dimension 2 Code"), Dim."Code Caption");
                 END;
                 GLBudgetName.GET(GETFILTER("Workplan Code"));
                 IF GLBudgetName."Budget Dimension 1 Code" <> '' THEN BEGIN
                     Dim.GET(GLBudgetName."Budget Dimension 1 Code");
                     EnterFilterInCell(GETFILTER("Budget Dimension 1 Code"), Dim."Code Caption");
                 END;
                 IF GLBudgetName."Budget Dimension 2 Code" <> '' THEN BEGIN
                     Dim.GET(GLBudgetName."Budget Dimension 2 Code");
                     EnterFilterInCell(GETFILTER("Budget Dimension 2 Code"), Dim."Code Caption");
                 END;
                 IF GLBudgetName."Budget Dimension 3 Code" <> '' THEN BEGIN
                     Dim.GET(GLBudgetName."Budget Dimension 3 Code");
                     EnterFilterInCell(GETFILTER("Budget Dimension 3 Code"), Dim."Code Caption");
                 END;
                 IF GLBudgetName."Budget Dimension 4 Code" <> '' THEN BEGIN
                     Dim.GET(GLBudgetName."Budget Dimension 4 Code");
                     EnterFilterInCell(GETFILTER("Budget Dimension 4 Code"), Dim."Code Caption");
                 END;

                 RowNo := RowNo + 2;
                 HeaderRowNo := RowNo;
                 EnterCell(HeaderRowNo, 1, FIELDCAPTION("G/L Account No."), FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                 EnterCell(HeaderRowNo, 2, GLAcc.FIELDCAPTION("Activity Description"), FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                 i := 0;
                 ColNo := 2;
                 Continue := TRUE;
                 WHILE Continue DO BEGIN
                     i := i + 1;
                     IF i > 8 THEN
                         Continue := FALSE
                     ELSE
                         IF ColumnDimCode[i] = '' THEN
                             Continue := FALSE;
                     IF Continue THEN BEGIN
                         ColNo := ColNo + 1;
                         IF i = BusUnitDimIndex THEN
                             EnterCell(HeaderRowNo, ColNo, BusUnit.TABLECAPTION, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text)
                         ELSE BEGIN
                             Dim.GET(ColumnDimCode[i]);
                             EnterCell(HeaderRowNo, ColNo, Dim."Code Caption", FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                         END;
                     END;
                 END;
                 IF TempPeriod.FIND('-') THEN
                     REPEAT
                         ColNo := ColNo + 1;
                         EnterCell(HeaderRowNo, ColNo, FORMAT(TempPeriod."Period Start"), FALSE, TRUE, '', ExcelBuf."Cell Type"::Date);
                     UNTIL TempPeriod.NEXT = 0;

                 COPYFILTER("G/L Account No.", GLAcc."No.");
                 IF GLAcc.FIND('-') THEN
                     REPEAT
                         RecNo := RecNo + 1;
                         Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                         RowNo := RowNo + 1;
                         EnterCell(
                           RowNo, 2, COPYSTR(COPYSTR(PADSTR(' ', 100), 1, 2 * GLAcc.Indentation + 1) + GLAcc."Activity Description", 2),
                           GLAcc."Account Type" <> GLAcc."Account Type"::Posting, FALSE, '', ExcelBuf."Cell Type"::Text);
                         EnterCell(
                           RowNo, 1, GLAcc."No.", GLAcc."Account Type" <> GLAcc."Account Type"::Posting, FALSE, '', ExcelBuf."Cell Type"::Text);
                         IF (GLAcc.Totaling = '') OR (NOT IncludeTotalingFormulas) THEN BEGIN
                             TempBudgetBuf2.SETRANGE("Workplan Code", GLAcc."No.");
                             IF TempBudgetBuf2.FIND('-') THEN BEGIN
                                 TempBudgetBuf1 := TempBudgetBuf2;
                                 EnterDimValues;
                                 IF TempPeriod.FIND('-') THEN;
                                 REPEAT
                                     IF (TempBudgetBuf1."Dimension Value Code 1" <>
                                         TempBudgetBuf2."Dimension Value Code 1") OR
                                        (TempBudgetBuf1."Dimension Value Code 2" <>
                                         TempBudgetBuf2."Dimension Value Code 2") OR
                                        (TempBudgetBuf1."Dimension Value Code 3" <>
                                         TempBudgetBuf2."Dimension Value Code 3") OR
                                        (TempBudgetBuf1."Dimension Value Code 4" <>
                                         TempBudgetBuf2."Dimension Value Code 4") OR
                                        (TempBudgetBuf1."Dimension Value Code 5" <>
                                         TempBudgetBuf2."Dimension Value Code 5") OR
                                        (TempBudgetBuf1."Dimension Value Code 6" <>
                                         TempBudgetBuf2."Dimension Value Code 6") OR
                                        (TempBudgetBuf1."Dimension Value Code 7" <>
                                         TempBudgetBuf2."Dimension Value Code 7") OR
                                        (TempBudgetBuf1."Dimension Value Code 8" <>
                                         TempBudgetBuf2."Dimension Value Code 8")
                                     THEN BEGIN
                                         RowNo := RowNo + 1;
                                         EnterCell(
                                           RowNo, 1, GLAcc."No.", GLAcc."Account Type" <> GLAcc."Account Type"::Posting, FALSE, '', ExcelBuf."Cell Type"::Text);
                                         EnterDimValues;
                                         TempBudgetBuf1 := TempBudgetBuf2;
                                     END;
                                     TempPeriod.GET(0, TempBudgetBuf2.Date);
                                     EnterCell(
                                       RowNo, NoOfDimensions + 2 + TempPeriod."Period No.",
                                       FORMAT(TempBudgetBuf2.Amount, 0, 1), GLAcc."Account Type" <> GLAcc."Account Type"::Posting,
                                       FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                                     TempPeriod.NEXT;
                                 UNTIL TempBudgetBuf2.NEXT = 0;
                             END ELSE BEGIN
                                 CLEAR(TempBudgetBuf2);
                                 EnterDimValues;
                             END;
                         END ELSE
                             IF TempPeriod.FIND('-') THEN BEGIN
                                 REPEAT
                                     EnterFormula(
                                       RowNo,
                                       NoOfDimensions + 2 + TempPeriod."Period No.",
                                       GLAcc.Totaling,
                                       GLAcc."Account Type" <> GLAcc."Account Type"::Posting,
                                       FALSE,
                                       '#,##0.00');
                                 UNTIL TempPeriod.NEXT = 0;
                             END;
                     UNTIL GLAcc.NEXT = 0;
                 IF IncludeTotalingFormulas THEN
                     HasFormulaError := ExcelBuf.ExportBudgetFilterToFormula(ExcelBuf);
                 Window.CLOSE;
                 LastBudgetRowNo := RowNo;

                 RowNo := RowNo + 200; // Move way below the budget
                 FOR i := 1 TO NoOfDimensions DO
                     IF i = BusUnitDimIndex THEN BEGIN
                         IF BusUnit.FINDSET THEN BEGIN
                             DimensionRange[1, i] := RowNo;
                             REPEAT
                                 EnterCell(RowNo, 1, BusUnit.Code, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                 RowNo := RowNo + 1;
                             UNTIL BusUnit.NEXT = 0;
                             DimensionRange[2, i] := RowNo - 1;
                         END;
                     END ELSE BEGIN
                         DimValue.SETRANGE("Dimension Code", ColumnDimCode[i]);
                         DimValue.SETFILTER("Dimension Value Type", '%1|%2',
                           DimValue."Dimension Value Type"::Standard, DimValue."Dimension Value Type"::"Begin-Total");
                         IF DimValue.FINDSET(FALSE, FALSE) THEN BEGIN
                             DimensionRange[1, i] := RowNo;
                             REPEAT
                                 EnterCell(RowNo, 1, DimValue.Code, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                 RowNo := RowNo + 1;
                             UNTIL DimValue.NEXT = 0;
                             DimensionRange[2, i] := RowNo - 1;
                         END;
                     END;

                 IF HasFormulaError THEN
                     IF NOT CONFIRM(STRSUBSTNO(Text007, ExcelBuf.GetExcelReference(7))) THEN
                         CurrReport.BREAK;

                 //ExcelBuf.CreateBook(ExcelBuf.GetExcelReference(10), 'WORKPLAN SHEET');
                 ExcelBuf.SetCurrent(HeaderRowNo + 1, 1);
                 ExcelBuf.StartRange;
                 ExcelBuf.SetCurrent(LastBudgetRowNo, 1);
                 ExcelBuf.EndRange;
                 ExcelBuf.CreateRange(ExcelBuf.GetExcelReference(8));
                 IF TempPeriod.FIND('-') THEN BEGIN
                     REPEAT
                         ExcelBuf.SetCurrent(HeaderRowNo + 1, NoOfDimensions + 2 + TempPeriod."Period No.");
                         ExcelBuf.StartRange;
                         ExcelBuf.SetCurrent(LastBudgetRowNo, NoOfDimensions + 2 + TempPeriod."Period No.");
                         ExcelBuf.EndRange;
                         ExcelBuf.CreateRange(ExcelBuf.GetExcelReference(9) + '_' + FORMAT(TempPeriod."Period No."));
                     UNTIL TempPeriod.NEXT = 0;
                 END;

                 FOR i := 1 TO NoOfDimensions DO BEGIN
                     ExcelBuf.SetCurrent(HeaderRowNo + 1, i + 2);
                     ExcelBuf.StartRange;
                     ExcelBuf.SetCurrent(LastBudgetRowNo, i + 2);
                     ExcelBuf.EndRange;
                     ExcelBuf.CreateRange('NAV_DIM' + FORMAT(i));
                     ExcelBuf.SetCurrent(DimensionRange[1, i], 1);
                     ExcelBuf.StartRange;
                     ExcelBuf.SetCurrent(DimensionRange[2, i], 1);
                     //ExcelBuf.EndRange;
                     //ExcelBuf.CreateValidationRule('NAV_DIM' + FORMAT(i));
                 END;

                 ExcelBuf.WriteSheet(
                   PADSTR(STRSUBSTNO('%1 %2', GLBudgetName."Workplan Code", GLBudgetName."Workplan Description"), 30),
                   COMPANYNAME,
                   USERID);

                 ExcelBuf.CloseBook;
                 ExcelBuf.OpenExcel;
                 //ExcelBuf.GiveUserControl;
             end;

             trigger OnPreDataItem()
             var
                 BusUnit: Record "Business Unit";
             begin
                 IF GETRANGEMIN("Workplan Code") <> GETRANGEMAX("Workplan Code") THEN
                     ERROR(Text001);

                 IF (StartDate = 0D) OR
                    (NoOfPeriods = 0) OR
                    (FORMAT(PeriodLength) = '')
                 THEN
                     ERROR(Text002);

                 SelectedDim.RESET;
                 SelectedDim.SETRANGE("User ID", USERID);
                 SelectedDim.SETRANGE("Object Type", 3);
                 SelectedDim.SETRANGE("Object ID", REPORT::"Export Budget to Excel");
                 i := 0;
                 IF BusUnit.FINDFIRST THEN BEGIN
                     i := i + 1;
                     BusUnitDimIndex := i;
                     BusUnitDimCode := COPYSTR(UPPERCASE(BusUnit.TABLECAPTION), 1, MAXSTRLEN(ColumnDimCode[1]));
                     ColumnDimCode[BusUnitDimIndex] := BusUnitDimCode;
                 END;
                 IF SelectedDim.FIND('-') THEN
                     REPEAT
                         i := i + 1;
                         IF i > ARRAYLEN(ColumnDimCode) THEN
                             ERROR(Text003, ARRAYLEN(ColumnDimCode));
                         ColumnDimCode[i] := SelectedDim."Dimension Code";
                     UNTIL (SelectedDim.NEXT = 0) OR (i = 8);
                 NoOfDimensions := i;

                 FOR i := 1 TO NoOfPeriods DO BEGIN
                     IF i = 1 THEN
                         TempPeriod."Period Start" := StartDate
                     ELSE
                         TempPeriod."Period Start" := CALCDATE(PeriodLength, TempPeriod."Period Start");
                     TempPeriod."Period End" := CALCDATE(PeriodLength, TempPeriod."Period Start");
                     TempPeriod."Period End" := CALCDATE('<-1D>', TempPeriod."Period End");
                     TempPeriod."Period No." := i;
                     TempPeriod.INSERT;
                 END;

                 SETRANGE(Date, StartDate, TempPeriod."Period End");
                 TempBudgetBuf2.DELETEALL;
                 ExcelBuf.DELETEALL;
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
                     field(StartDate; StartDate)
                     {
                         Caption = 'Start Date';
                     }
                     field(NoOfPeriods; NoOfPeriods)
                     {
                         Caption = 'No. of Periods';
                     }
                     field(PeriodLength; PeriodLength)
                     {
                         Caption = 'Period Length';
                     }
                     field(ColumnDim; ColumnDim)
                     {
                         Caption = 'Column Dimensions';
                         Editable = false;

                         trigger OnAssistEdit()
                         begin
                             DimSelectionBuf.SetDimSelectionMultiple(3, REPORT::"Export Budget to Excel", ColumnDim);
                         end;
                     }
                     field(IncludeTotalingFormulas; IncludeTotalingFormulas)
                     {
                         Caption = 'Include Totaling Formulas';
                     }
                 }
             }
         }

         actions
         {
         }

         trigger OnOpenPage()
         begin
             ColumnDim := DimSelectionBuf.GetDimSelectionText(3, REPORT::"Export Budget to Excel", '');
         end;
     }

     labels
     {
     }

     trigger OnPreReport()
     begin
         DimSelectionBuf.CompareDimText(
           3, REPORT::"Export Budget to Excel", '', ColumnDim, Text000);
     end;

     var
         Text000: Label 'Column Dimensions';
         Text001: Label 'You can only export one budget at a time.';
         Text002: Label 'You must specify a Start Date, a No of Periods and a Period Length.';
         Text003: Label 'You can only select a maximum of %1 column dimensions.';
         Text005: Label 'Analyzing Data...\\';
         Text006: Label 'Export Filters';
         Text007: Label 'Some filters cannot be converted into Excel formulas. You will have to check %1 errors in the Excel worksheet. Do you want to create the Excel worksheet ?';
         TempPeriod: Record "Date" temporary;
         SelectedDim: Record "Selected Dimension";
        // TempBudgetBuf1: Record "W/P Budget Buffer" temporary;
        // TempBudgetBuf2: Record "W/P Budget Buffer" temporary;
         DimSetEntry: Record "Dimension Set Entry";
         GLSetup: Record "General Ledger Setup";
         Dim: Record "Dimension";
         GLBudgetName: Record "Workplan";
         ExcelBuf: Record "Excel Buffer" temporary;
         GLAcc: Record "Workplan Activities";
         DimSelectionBuf: Record "Dimension Selection Buffer";
         StartDate: Date;
         PeriodLength: DateFormula;
         NoOfPeriods: Integer;
         NoOfDimensions: Integer;
         i: Integer;
         RowNo: Integer;
         ColNo: Integer;
         ColumnDim: Text[250];
         ColumnDimCode: array[8] of Code[20];
         HasFormulaError: Boolean;
         IncludeTotalingFormulas: Boolean;
         HeaderRowNo: Integer;
         BusUnitDimIndex: Integer;
         BusUnitDimCode: Code[20];

     local procedure CalcPeriodStart(EntryDate: Date): Date
     begin
         TempPeriod."Period Start" := EntryDate;
         TempPeriod.FIND('=<');
         EXIT(TempPeriod."Period Start");
     end;

     local procedure GetDimValueCode(DimCode: Code[20]): Code[20]
     begin
         IF DimCode = '' THEN
             EXIT('');
         /*  IF DimCode = BusUnitDimCode THEN
              EXIT("Workplan Entry"."Business Unit Code");
          DimSetEntry.SETRANGE("Dimension Set ID", "Workplan Entry"."Dimension Set ID");
          DimSetEntry.SETRANGE("Dimension Code", DimCode);
          IF DimSetEntry.FINDFIRST THEN
              EXIT(DimSetEntry."Dimension Value Code");
          EXIT(''); 
     end;*/

    /* local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option)
     begin
         ExcelBuf.INIT;
         ExcelBuf.VALIDATE("Row No.", RowNo);
         ExcelBuf.VALIDATE("Column No.", ColumnNo);
         ExcelBuf."Cell Value as Text" := CellValue;
         ExcelBuf.Formula := '';
         ExcelBuf.Bold := Bold;
         ExcelBuf.Underline := UnderLine;
         ExcelBuf.NumberFormat := NumberFormat;
         ExcelBuf."Cell Type" := CellType;
         ExcelBuf.INSERT;
     end;

     local procedure EnterFilterInCell("Filter": Text[250]; FieldName: Text[100])
     begin
         IF Filter <> '' THEN BEGIN
             RowNo := RowNo + 1;
             EnterCell(RowNo, 1, FieldName, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
             EnterCell(RowNo, 2, Filter, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
         END;
     end;

     local procedure EnterDimValue(ColDimIndex: Integer; DimValueCode: Code[20])
     begin
         IF ColumnDimCode[ColDimIndex] <> '' THEN BEGIN
             ColNo := ColNo + 1;
             EnterCell(RowNo, ColNo, DimValueCode, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
         END;
     end;

     local procedure EnterDimValues()
     begin
         ColNo := 2;
         EnterDimValue(1, TempBudgetBuf2."Dimension Value Code 1");
         EnterDimValue(2, TempBudgetBuf2."Dimension Value Code 2");
         EnterDimValue(3, TempBudgetBuf2."Dimension Value Code 3");
         EnterDimValue(4, TempBudgetBuf2."Dimension Value Code 4");
         EnterDimValue(5, TempBudgetBuf2."Dimension Value Code 5");
         EnterDimValue(6, TempBudgetBuf2."Dimension Value Code 6");
         EnterDimValue(7, TempBudgetBuf2."Dimension Value Code 7");
         EnterDimValue(8, TempBudgetBuf2."Dimension Value Code 8");
     end;

     local procedure EnterFormula(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30])
     begin
         ExcelBuf.INIT;
         ExcelBuf.VALIDATE("Row No.", RowNo);
         ExcelBuf.VALIDATE("Column No.", ColumnNo);
         ExcelBuf."Cell Value as Text" := '';
         ExcelBuf.Formula := CellValue; // is converted to formula later.
         ExcelBuf.Bold := Bold;
         ExcelBuf.Underline := UnderLine;
         ExcelBuf.NumberFormat := NumberFormat;
         ExcelBuf.INSERT;
     end;
     */
}

