page 50161 "Budget Workplan"
{
    DataCaptionExpression = BudgetName;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPlus;
    SaveValues = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(BudgetName; BudgetName)
                {
                    Caption = 'Workplan Code';
                    TableRelation = Workplan;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        GLBudgetNames: Page "Workplan List";
                    begin
                        /*
                        GLBudgetNames.LOOKUPMODE := TRUE;
                        GLBudgetNames.SETRECORD(GLBudgetName);
                        IF GLBudgetNames.RUNMODAL = ACTION::LookupOK THEN BEGIN
                          GLBudgetNames.GETRECORD(GLBudgetName);
                          BudgetName := GLBudgetName."Workplan Code";
                          Text := GLBudgetName."Workplan Code";
                          ValidateBudgetName;
                          ValidateLineDimCode;
                          ValidateColumnDimCode;
                          UpdateMatrixSubform;
                          EXIT(TRUE);
                        END;
                        
                        ValidateBudgetName;
                        ValidateLineDimCode;
                        ValidateColumnDimCode;
                        CurrPage.UPDATE;
                        EXIT(FALSE);
                        */


                        GLBudgetNames.LOOKUPMODE := TRUE;
                        GLBudgetNames.SETRECORD(GLBudgetName);
                        IF GLBudgetNames.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            GLBudgetNames.GETRECORD(GLBudgetName);
                            BudgetName := GLBudgetName."Workplan Code";
                            Text := GLBudgetName."Workplan Code";
                            ValidateBudgetName;
                            ValidateLineDimCode;
                            ValidateColumnDimCode;
                            CurrPage.UPDATE;
                            UpdateMatrixSubform;
                            EXIT(TRUE);
                        END ELSE BEGIN
                            ValidateBudgetName;
                            ValidateLineDimCode;
                            ValidateColumnDimCode;
                            CurrPage.UPDATE;
                            EXIT(FALSE);
                        END;

                    end;

                    trigger OnValidate()
                    begin
                        ValidateBudgetName;
                        ValidateLineDimCode;
                        ValidateColumnDimCode;

                        UpdateMatrixSubform;
                    end;
                }
                field(LineDimCode; LineDimCode)
                {
                    Caption = 'Show as Lines';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        NewCode: Text[30];
                    begin
                        NewCode := GetDimSelection(LineDimCode);
                        IF NewCode = LineDimCode THEN
                            EXIT(FALSE);

                        Text := NewCode;
                        LineDimCode := NewCode;
                        ValidateLineDimCode;
                        LineDimCodeOnAfterValidate;
                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    var
                        MATRIX_SetWanted: Option First,Previous,Same,Next;
                    begin
                        IF (UPPERCASE(LineDimCode) = UPPERCASE(ColumnDimCode)) AND (LineDimCode <> '') THEN BEGIN
                            ColumnDimCode := '';
                            ValidateColumnDimCode;
                        END;
                        ValidateLineDimCode;
                        MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::First);
                        LineDimCodeOnAfterValidate;
                    end;
                }
                field(ColumnDimCode; ColumnDimCode)
                {
                    Caption = 'Show as Columns';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        NewCode: Text[30];
                        MATRIX_Step: Option First,Previous,Same,Next;
                    begin
                        NewCode := GetDimSelection(ColumnDimCode);
                        IF NewCode = ColumnDimCode THEN
                            EXIT(FALSE);

                        Text := NewCode;
                        ColumnDimCode := NewCode;
                        ValidateColumnDimCode;
                        MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
                        ColumnDimCodeOnAfterValidate;
                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    var
                        MATRIX_Step: Option First,Previous,Same,Next;
                    begin
                        IF (UPPERCASE(LineDimCode) = UPPERCASE(ColumnDimCode)) AND (LineDimCode <> '') THEN BEGIN
                            LineDimCode := '';
                            ValidateLineDimCode;
                        END;
                        ValidateColumnDimCode;
                        MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
                        ColumnDimCodeOnAfterValidate;
                    end;
                }
                field(PeriodType; PeriodType)
                {
                    Caption = 'View by';
                    Enabled = PeriodTypeEnable;
                    OptionCaption = 'Day,Week,Month,Quarter,Year,Accounting Period';

                    trigger OnValidate()
                    begin
                        FindPeriod('');
                        PeriodTypeOnAfterValidate;
                    end;
                }
                field(RoundingFactor; RoundingFactor)
                {
                    Caption = 'Rounding Factor';
                    OptionCaption = 'None,1,1000,1000000';

                    trigger OnValidate()
                    begin
                        UpdateMatrixSubform;
                    end;
                }
                field(ShowColumnName; ShowColumnName)
                {
                    Caption = 'Show Column Name';

                    trigger OnValidate()
                    begin
                        ShowColumnNameOnPush;
                    end;
                }
            }
            part(MatrixForm; "Budget Workplan Matrix")
            {
            }
            group(Filters)
            {
                Caption = 'Filters';
                field(DateFilter; DateFilter)
                {
                    Caption = 'Date Filter';

                    trigger OnValidate()
                    var
                    //  ApplicationManagement: Codeunit "ApplicationManagement";
                    begin
                        /*    IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
                           GLAccBudgetBuf.SETFILTER("Date Filter",DateFilter);
                           DateFilter := GLAccBudgetBuf.GETFILTER("Date Filter");
                           InternalDateFilter := DateFilter;
                           D ateFilterOnAfterValidate;*/
                    end;
                }
                field(GLAccFilter; GLAccFilter)
                {
                    Caption = 'G/L Account Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        GLAccList: Page "Workplan Activities";
                    begin
                        GLAccList.LOOKUPMODE(TRUE);
                        IF NOT (GLAccList.RUNMODAL = ACTION::LookupOK) THEN
                            EXIT(FALSE);

                        Text := GLAccList.GetSelectionFilter;
                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        GLAccFilterOnAfterValidate;
                    end;
                }
                field(GlobalDim1Filter; GlobalDim1Filter)
                {
                    CaptionClass = '1,3,1';
                    Caption = 'Global Dimension 1 Filter';
                    Enabled = GlobalDim1FilterEnable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT(LookUpDimFilter(GLSetup."Global Dimension 1 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        GlobalDim1FilterOnAfterValidat;
                    end;
                }
                field(GlobalDim2Filter; GlobalDim2Filter)
                {
                    CaptionClass = '1,3,2';
                    Caption = 'Global Dimension 2 Filter';
                    Enabled = GlobalDim2FilterEnable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT(LookUpDimFilter(GLSetup."Global Dimension 2 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        GlobalDim2FilterOnAfterValidat;
                    end;
                }
                field(BudgetDim1Filter; BudgetDim1Filter)
                {
                    CaptionClass = GetCaptionClass(1);
                    Caption = 'Budget Dimension 1 Filter';
                    Enabled = BudgetDim1FilterEnable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT(LookUpDimFilter(GLBudgetName."Budget Dimension 1 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        BudgetDim1FilterOnAfterValidat;
                    end;
                }
                field(BudgetDim2Filter; BudgetDim2Filter)
                {
                    CaptionClass = GetCaptionClass(2);
                    Caption = 'Budget Dimension 2 Filter';
                    Enabled = BudgetDim2FilterEnable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT(LookUpDimFilter(GLBudgetName."Budget Dimension 2 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        BudgetDim2FilterOnAfterValidat;
                    end;
                }
                field(BudgetDim3Filter; BudgetDim3Filter)
                {
                    CaptionClass = GetCaptionClass(3);
                    Caption = 'Budget Dimension 3 Filter';
                    Enabled = BudgetDim3FilterEnable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT(LookUpDimFilter(GLBudgetName."Budget Dimension 3 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        BudgetDim3FilterOnAfterValidat;
                    end;
                }
                field(BudgetDim4Filter; BudgetDim4Filter)
                {
                    CaptionClass = GetCaptionClass(4);
                    Caption = 'Budget Dimension 4 Filter';
                    Enabled = BudgetDim4FilterEnable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT(LookUpDimFilter(GLBudgetName."Budget Dimension 4 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        BudgetDim4FilterOnAfterValidat;
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Balance")
            {
                Caption = '&Balance';
                Image = Balance;
                action("Page G/L Balance/Budget")
                {
                    Caption = 'G/L Balance/B&udget';
                    Image = ChartOfAccounts;

                    trigger OnAction()
                    var
                        GLAccount: Record "G/L Account";
                    begin
                        GLAccount.SETFILTER("Budget Filter", BudgetName);
                        PAGE.RUN(PAGE::"G/L Balance/Budget", GLAccount);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Copy Budget")
                {
                    Caption = 'Copy Budget';
                    Ellipsis = true;
                    Image = CopyBudget;
                    RunObject = Report 96;
                    Visible = false;
                }
                action("Delete Budget")
                {
                    Caption = 'Delete Budget';
                    Image = Delete;

                    trigger OnAction()
                    begin
                        DeleteBudget;
                    end;
                }
                separator(Group)
                {
                    Caption = '';
                }
                action("Export to Excel")
                {
                    Caption = 'Export to Excel';
                    Ellipsis = true;
                    Image = ExportToExcel;
                    Visible = false;

                    trigger OnAction()
                    var
                        GLBudgetEntry: Record "Workplan Entry";
                    begin
                        GLBudgetEntry.SETFILTER("Workplan Code", BudgetName);
                        GLBudgetEntry.SETFILTER("Business Unit Code", BusUnitFilter);
                        GLBudgetEntry.SETFILTER("G/L Account No.", GLAccFilter);
                        GLBudgetEntry.SETFILTER("Global Dimension 1 Code", GlobalDim1Filter);
                        GLBudgetEntry.SETFILTER("Global Dimension 2 Code", GlobalDim2Filter);
                        GLBudgetEntry.SETFILTER("Budget Dimension 1 Code", BudgetDim1Filter);
                        GLBudgetEntry.SETFILTER("Budget Dimension 2 Code", BudgetDim2Filter);
                        GLBudgetEntry.SETFILTER("Budget Dimension 3 Code", BudgetDim3Filter);
                        GLBudgetEntry.SETFILTER("Budget Dimension 4 Code", BudgetDim4Filter);
                        REPORT.RUN(REPORT::"New study informationfinal rep", TRUE, FALSE, GLBudgetEntry);
                    end;
                }
                action("Import from Excel")
                {
                    Caption = 'Import from Excel';
                    Ellipsis = true;
                    Image = ImportExcel;
                    Visible = false;

                    trigger OnAction()
                    var
                        ImportBudgetfromExcel: Report "W/P Import Budget from Excel";
                    begin
                        //  ImportBudgetfromExcel.SetGLBudgetName(BudgetName);
                        ImportBudgetfromExcel.RUNMODAL;
                    end;
                }
                action(CreateBudget)
                {
                    Caption = 'Create Budget';
                    Image = CreateLedgerBudget;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    var
                    // BudgetaryControl: Record "FIN-Budgetary Control Setup";
                    begin

                        //check if the budget is blocked or not
                        GLBudgetName.TESTFIELD(Blocked, FALSE);
                        // Added to load auto form
                        // BudgetaryControl.GET();
                        // BudgetaryControl.TESTFIELD("Current Item Budget");
                        // BudgetaryControl.TESTFIELD("Current Budget Code");

                        WPBudgetAlloc.RESET;
                        LineNo := 0;

                        IF WPBudgetAlloc.FIND('+') THEN BEGIN
                            LineNo := WPBudgetAlloc."Line No.";
                        END;

                        LineNo := LineNo + 1;
                        //Get Current Budget
                        //BudgetaryControlSetup.RESET;
                        //BudgetaryControlSetup.GET;
                        //Get Current Budget

                        //Get Current Workplan Dimenison
                        Workplan.RESET;
                        Workplan.GET(BudgetName);
                        //Get Current Workplan Dimenison
                        WPBudgetAlloc.INIT;
                        WPBudgetAlloc."Line No." := LineNo;
                        WPBudgetAlloc.Name := BudgetName;
                        WPBudgetAlloc."Global Dimension 1 Code" := Workplan."Global Dimension 1 Code";
                        WPBudgetAlloc."Global Dimension 2 Code" := Workplan."Global Dimension 2 Code";
                        WPBudgetAlloc."Analysis Area" := WPBudgetAlloc."Analysis Area"::"Item and G/L Account";
                        WPBudgetAlloc."Period Type" := WPBudgetAlloc."Period Type"::Monthly;
                        // WPBudgetAlloc."Current G/L Budget" := BudgetaryControl."Current Budget Code";
                        // WPBudgetAlloc."Current Item Budget" := BudgetaryControl."Current Item Budget";
                        // WPBudgetAlloc."Start Date" := BudgetaryControl."Current Budget Start Date";
                        // WPBudgetAlloc."End Date" := BudgetaryControl."Current Budget End Date";

                        WPBudgetAlloc.INSERT;
                        PAGE.RUN(PAGE::"Workplan Budget Creation", WPBudgetAlloc);
                        // END to load auto form
                    end;
                }


                action("Reverse Lines and Columns")
                {
                    Caption = 'Reverse Lines and Columns';
                    Image = Undo;

                    trigger OnAction()
                    var
                        TempDimCode: Text[30];
                    begin
                        TempDimCode := ColumnDimCode;
                        ColumnDimCode := LineDimCode;
                        LineDimCode := TempDimCode;
                        ValidateLineDimCode;
                        ValidateColumnDimCode;

                        MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
                        UpdateMatrixSubform;
                    end;
                }
            }
            action("Next Period")
            {
                Caption = 'Next Period';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF (LineDimOption = LineDimOption::Period) OR (ColumnDimOption = ColumnDimOption::Period) THEN
                        EXIT;
                    FindPeriod('>');
                    CurrPage.UPDATE;
                    UpdateMatrixSubform;
                end;
            }
            action("Previous Period")
            {
                Caption = 'Previous Period';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF (LineDimOption = LineDimOption::Period) OR (ColumnDimOption = ColumnDimOption::Period) THEN
                        EXIT;
                    FindPeriod('<');
                    CurrPage.UPDATE;
                    UpdateMatrixSubform;
                end;
            }
            action("Previous Set")
            {
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Set';

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_Step::Previous);
                    UpdateMatrixSubform;
                end;
            }
            action("Previous Column")
            {
                Caption = 'Previous Column';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_Step::PreviousColumn);
                    UpdateMatrixSubform;
                end;
            }
            action("Next Column")
            {
                Caption = 'Next Column';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_Step::NextColumn);
                    UpdateMatrixSubform;
                end;
            }
            action("Next Set")
            {
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Set';

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_Step::Next);
                    UpdateMatrixSubform;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        BudgetDim4FilterEnable := TRUE;
        BudgetDim3FilterEnable := TRUE;
        BudgetDim2FilterEnable := TRUE;
        BudgetDim1FilterEnable := TRUE;
        PeriodTypeEnable := TRUE;
        GlobalDim2FilterEnable := TRUE;
        GlobalDim1FilterEnable := TRUE;
    end;

    trigger OnOpenPage()
    var
        GLAcc: Record "Workplan Activities";
        MATRIX_Step: Option First,Previous,Same,Next;
    begin
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter") <> '' THEN
            GlobalDim1Filter := GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter");
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter") <> '' THEN
            GlobalDim2Filter := GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter");

        GLSetup.GET;

        GlobalDim1FilterEnable :=
          (GLSetup."Global Dimension 1 Code" <> '') AND
          (GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter") = '');
        GlobalDim2FilterEnable :=
          (GLSetup."Global Dimension 2 Code" <> '') AND
          (GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter") = '');

        ValidateBudgetName;
        LineDimCode := '';
        IF LineDimCode = '' THEN
            LineDimCode := GLAcc.TABLECAPTION;
        IF ColumnDimCode = '' THEN
            ColumnDimCode := Text001;

        LineDimOption := DimCodeToOption(LineDimCode);
        ColumnDimOption := DimCodeToOption(ColumnDimCode);

        IF (NewBudgetName <> '') AND (NewBudgetName <> BudgetName) THEN BEGIN
            BudgetName := NewBudgetName;
            ValidateBudgetName;
            ValidateLineDimCode;
            ValidateColumnDimCode;
        END;

        FindPeriod('');
        MATRIX_GenerateColumnCaptions(MATRIX_Step::First);

        UpdateMatrixSubform;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        GLAccBudgetBuf: Record "Workplan Budget Buffer";
        GLBudgetName: Record "Workplan";
        PrevGLBudgetName: Record "Workplan";
        MATRIX_MatrixRecords: array[12] of Record "Dimension Code Buffer";
        MATRIX_CaptionSet: array[32] of Text[80];
        MATRIX_CaptionRange: Text[80];
        FirstColumn: Text[80];
        LastColumn: Text[80];
        MATRIX_PrimKeyFirstCaptionInCu: Text[80];
        MATRIX_CurrentNoOfColumns: Integer;
        Text001: Label 'Period';
        Text003: Label 'Do you want to delete the budget entries shown?';
        Text004: Label 'DEFAULT';
        Text005: Label 'Default budget';
        Text006: Label '%1 is not a valid line definition.';
        Text007: Label '%1 is not a valid column definition.';
        Text008: Label '1,6,,Budget Dimension 1 Filter';
        Text009: Label '1,6,,Budget Dimension 2 Filter';
        Text010: Label '1,6,,Budget Dimension 3 Filter';
        Text011: Label '1,6,,Budget Dimension 4 Filter';
        MATRIX_Step: Option First,Previous,Same,Next,PreviousColumn,NextColumn;
        BudgetName: Code[70];
        NewBudgetName: Code[70];
        LineDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4",Workplan;
        ColumnDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4",Workplan;
        LineDimCode: Text[30];
        ColumnDimCode: Text[30];
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        RoundingFactor: Option "None","1","1000","1000000";
        ShowColumnName: Boolean;
        DateFilter: Text[30];
        InternalDateFilter: Text[30];
        BusUnitFilter: Code[250];
        GLAccFilter: Code[250];
        GlobalDim1Filter: Code[250];
        GlobalDim2Filter: Code[250];
        BudgetDim1Filter: Code[250];
        BudgetDim2Filter: Code[250];
        BudgetDim3Filter: Code[250];
        BudgetDim4Filter: Code[250];
        [InDataSet]
        GlobalDim1FilterEnable: Boolean;
        [InDataSet]
        GlobalDim2FilterEnable: Boolean;
        [InDataSet]
        PeriodTypeEnable: Boolean;
        [InDataSet]
        BudgetDim1FilterEnable: Boolean;
        [InDataSet]
        BudgetDim2FilterEnable: Boolean;
        [InDataSet]
        BudgetDim3FilterEnable: Boolean;
        [InDataSet]
        BudgetDim4FilterEnable: Boolean;
        WPBudgetAlloc: Record "Procur. Plan Budget Allocation";
        LineNo: Integer;
        // BudgetaryControlSetup: Record "FIN-Budgetary Control Setup";
        Workplan: Record "Workplan";

    procedure MATRIX_GenerateColumnCaptions(MATRIX_SetWanted: Option First,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MATRIX_PeriodRecords: array[32] of Record "Date";
        BusUnit: Record "Business Unit";
        GLAccount: Record "Workplan Activities";
        MatrixMgt: Codeunit "WP Matrix Management";
        RecRef: RecordRef;
        FieldRef: FieldRef;
        CurrentMatrixRecordOrdinal: Integer;
        i: Integer;
    begin
        CLEAR(MATRIX_CaptionSet);
        CurrentMatrixRecordOrdinal := 1;
        CLEAR(MATRIX_MatrixRecords);
        FirstColumn := '';
        LastColumn := '';
        MATRIX_CurrentNoOfColumns := 12;

        IF ColumnDimCode = '' THEN
            EXIT;

        CASE ColumnDimCode OF
            Text001:  // Period
                BEGIN
                    MatrixMgt.GeneratePeriodMatrixData(
                      MATRIX_SetWanted, MATRIX_CurrentNoOfColumns, ShowColumnName,
                      PeriodType, DateFilter, MATRIX_PrimKeyFirstCaptionInCu,
                      MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrentNoOfColumns, MATRIX_PeriodRecords);
                    FOR i := 1 TO MATRIX_CurrentNoOfColumns DO BEGIN
                        MATRIX_MatrixRecords[i]."Period Start" := MATRIX_PeriodRecords[i]."Period Start";
                        MATRIX_MatrixRecords[i]."Period End" := MATRIX_PeriodRecords[i]."Period End";
                    END;
                    FirstColumn := FORMAT(MATRIX_PeriodRecords[1]."Period Start");
                    LastColumn := FORMAT(MATRIX_PeriodRecords[MATRIX_CurrentNoOfColumns]."Period End");
                    PeriodTypeEnable := TRUE;
                END;
            GLAccount.TABLECAPTION:
                BEGIN
                    CLEAR(MATRIX_CaptionSet);
                    RecRef.GETTABLE(GLAccount);
                    RecRef.SETTABLE(GLAccount);
                    IF GLAccFilter <> '' THEN BEGIN
                        FieldRef := RecRef.FIELDINDEX(1);
                        FieldRef.SETFILTER(GLAccFilter);
                    END;
                    MatrixMgt.GenerateMatrixData(
                      RecRef, MATRIX_SetWanted, 12, 1,
                      MATRIX_PrimKeyFirstCaptionInCu, MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrentNoOfColumns);
                    FOR i := 1 TO MATRIX_CurrentNoOfColumns DO
                        MATRIX_MatrixRecords[i].Code := COPYSTR(MATRIX_CaptionSet[i], 1, MAXSTRLEN(MATRIX_MatrixRecords[i].Code));
                    IF ShowColumnName THEN
                        MatrixMgt.GenerateMatrixData(
                          RecRef, MATRIX_SetWanted::Same, 12, GLAccount.FIELDNO("Activity Code"),
                          MATRIX_PrimKeyFirstCaptionInCu, MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrentNoOfColumns);
                END;


            BusUnit.TABLECAPTION:
                BEGIN
                    CLEAR(MATRIX_CaptionSet);
                    RecRef.GETTABLE(BusUnit);
                    RecRef.SETTABLE(BusUnit);
                    IF BusUnitFilter <> '' THEN BEGIN
                        FieldRef := RecRef.FIELDINDEX(1);
                        FieldRef.SETFILTER(BusUnitFilter);
                    END;
                    MatrixMgt.GenerateMatrixData(
                      RecRef, MATRIX_SetWanted, 12, 1,
                      MATRIX_PrimKeyFirstCaptionInCu, MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrentNoOfColumns);
                    FOR i := 1 TO MATRIX_CurrentNoOfColumns DO
                        MATRIX_MatrixRecords[i].Code := MATRIX_CaptionSet[i];
                    IF ShowColumnName THEN
                        MatrixMgt.GenerateMatrixData(
                          RecRef, MATRIX_SetWanted::Same, 12, BusUnit.FIELDNO(Name),
                          MATRIX_PrimKeyFirstCaptionInCu, MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrentNoOfColumns);
                END;
            GLSetup."Global Dimension 1 Code":
                BEGIN
                    MatrixMgt.SetDimColumnSet(
                      GLSetup."Global Dimension 1 Code",
                      GlobalDim1Filter, MATRIX_SetWanted, MATRIX_PrimKeyFirstCaptionInCu, FirstColumn, LastColumn, MATRIX_CurrentNoOfColumns);
                    MatrixMgt.DimToCaptions(
                      MATRIX_CaptionSet, MATRIX_MatrixRecords, ColumnDimCode,
                      FirstColumn, LastColumn, MATRIX_CurrentNoOfColumns, ShowColumnName, MATRIX_CaptionRange, FALSE);
                END;
            GLSetup."Global Dimension 2 Code":
                BEGIN
                    MatrixMgt.SetDimColumnSet(
                      GLSetup."Global Dimension 2 Code",
                      GlobalDim2Filter, MATRIX_SetWanted, MATRIX_PrimKeyFirstCaptionInCu, FirstColumn, LastColumn, MATRIX_CurrentNoOfColumns);
                    MatrixMgt.DimToCaptions(
                      MATRIX_CaptionSet, MATRIX_MatrixRecords, ColumnDimCode,
                      FirstColumn, LastColumn, MATRIX_CurrentNoOfColumns, ShowColumnName, MATRIX_CaptionRange, FALSE);
                END;
            GLBudgetName."Budget Dimension 1 Code":
                BEGIN
                    MatrixMgt.SetDimColumnSet(
                      GLBudgetName."Budget Dimension 1 Code",
                      BudgetDim1Filter, MATRIX_SetWanted, MATRIX_PrimKeyFirstCaptionInCu, FirstColumn, LastColumn, MATRIX_CurrentNoOfColumns);
                    MatrixMgt.DimToCaptions(
                      MATRIX_CaptionSet, MATRIX_MatrixRecords, ColumnDimCode,
                      FirstColumn, LastColumn, MATRIX_CurrentNoOfColumns, ShowColumnName, MATRIX_CaptionRange, FALSE);
                END;
            GLBudgetName."Budget Dimension 2 Code":
                BEGIN
                    MatrixMgt.SetDimColumnSet(
                      GLBudgetName."Budget Dimension 2 Code",
                      BudgetDim2Filter, MATRIX_SetWanted, MATRIX_PrimKeyFirstCaptionInCu, FirstColumn, LastColumn, MATRIX_CurrentNoOfColumns);
                    MatrixMgt.DimToCaptions(
                      MATRIX_CaptionSet, MATRIX_MatrixRecords, ColumnDimCode,
                      FirstColumn, LastColumn, MATRIX_CurrentNoOfColumns, ShowColumnName, MATRIX_CaptionRange, FALSE);
                END;
            GLBudgetName."Budget Dimension 3 Code":
                BEGIN
                    MatrixMgt.SetDimColumnSet(
                      GLBudgetName."Budget Dimension 3 Code",
                      BudgetDim3Filter, MATRIX_SetWanted, MATRIX_PrimKeyFirstCaptionInCu, FirstColumn, LastColumn, MATRIX_CurrentNoOfColumns);
                    MatrixMgt.DimToCaptions(
                      MATRIX_CaptionSet, MATRIX_MatrixRecords, ColumnDimCode,
                      FirstColumn, LastColumn, MATRIX_CurrentNoOfColumns, ShowColumnName, MATRIX_CaptionRange, FALSE);
                END;
            GLBudgetName."Budget Dimension 4 Code":
                BEGIN
                    MatrixMgt.SetDimColumnSet(
                      GLBudgetName."Budget Dimension 4 Code",
                      BudgetDim4Filter, MATRIX_SetWanted, MATRIX_PrimKeyFirstCaptionInCu, FirstColumn, LastColumn, MATRIX_CurrentNoOfColumns);
                    MatrixMgt.DimToCaptions(
                      MATRIX_CaptionSet, MATRIX_MatrixRecords, ColumnDimCode,
                      FirstColumn, LastColumn, MATRIX_CurrentNoOfColumns, ShowColumnName, MATRIX_CaptionRange, FALSE);
                END;
        END;
    end;

    local procedure DimCodeToOption(DimCode: Text[30]): Integer
    var
        BusUnit: Record "Business Unit";
        GLAcc: Record "Workplan Activities";
    begin
        CASE DimCode OF
            '':
                EXIT(-1);
            GLAcc.TABLECAPTION:
                EXIT(9);
            Text001:
                EXIT(1);
            BusUnit.TABLECAPTION:
                EXIT(2);
            GLSetup."Global Dimension 1 Code":
                EXIT(3);
            GLSetup."Global Dimension 2 Code":
                EXIT(4);
            GLBudgetName."Budget Dimension 1 Code":
                EXIT(5);
            GLBudgetName."Budget Dimension 2 Code":
                EXIT(6);
            GLBudgetName."Budget Dimension 3 Code":
                EXIT(7);
            GLBudgetName."Budget Dimension 4 Code":
                EXIT(8);
            ELSE
                EXIT(-1);
        END;
    end;

    local procedure FindPeriod(SearchText: Code[10])
    var
        GLAcc: Record "Workplan Activities";
        Calendar: Record "Date";
        PeriodFormMgt: Codeunit "PeriodPageManagement";
    begin
        IF DateFilter <> '' THEN BEGIN
            Calendar.SETFILTER("Period Start", DateFilter);
            IF NOT PeriodFormMgt.FindDate('+', Calendar, PeriodType) THEN
                PeriodFormMgt.FindDate('+', Calendar, PeriodType::Day);
            Calendar.SETRANGE("Period Start");
        END;
        PeriodFormMgt.FindDate(SearchText, Calendar, PeriodType);
        GLAcc.SETRANGE("Date Filter", Calendar."Period Start", Calendar."Period End");
        IF GLAcc.GETRANGEMIN("Date Filter") = GLAcc.GETRANGEMAX("Date Filter") THEN
            GLAcc.SETRANGE("Date Filter", GLAcc.GETRANGEMIN("Date Filter"));
        InternalDateFilter := GLAcc.GETFILTER("Date Filter");
        IF (LineDimOption <> LineDimOption::Period) AND (ColumnDimOption <> ColumnDimOption::Period) THEN
            DateFilter := InternalDateFilter;
    end;
    //01/01/2019..15/02/2025
    //StartDate := Rec.GetRangeMin(Rec."Date Filter");
    //EndDate := Rec.GetRangeMax(Rec."Date Filter");
    local procedure GetDimSelection(OldDimSelCode: Text[30]): Text[30]
    var
        GLAcc: Record "Workplan Activities";
        BusUnit: Record "Business Unit";
        DimSelection: Page "Dimension Selection";
    begin
        DimSelection.InsertDimSelBuf(FALSE, GLAcc.TABLECAPTION, GLAcc.TABLECAPTION);
        DimSelection.InsertDimSelBuf(FALSE, BusUnit.TABLECAPTION, BusUnit.TABLECAPTION);
        DimSelection.InsertDimSelBuf(FALSE, Text001, Text001);
        IF GLSetup."Global Dimension 1 Code" <> '' THEN
            DimSelection.InsertDimSelBuf(FALSE, GLSetup."Global Dimension 1 Code", '');
        IF GLSetup."Global Dimension 2 Code" <> '' THEN
            DimSelection.InsertDimSelBuf(FALSE, GLSetup."Global Dimension 2 Code", '');
        IF GLBudgetName."Budget Dimension 1 Code" <> '' THEN
            DimSelection.InsertDimSelBuf(FALSE, GLBudgetName."Budget Dimension 1 Code", '');
        IF GLBudgetName."Budget Dimension 2 Code" <> '' THEN
            DimSelection.InsertDimSelBuf(FALSE, GLBudgetName."Budget Dimension 2 Code", '');
        IF GLBudgetName."Budget Dimension 3 Code" <> '' THEN
            DimSelection.InsertDimSelBuf(FALSE, GLBudgetName."Budget Dimension 3 Code", '');
        IF GLBudgetName."Budget Dimension 4 Code" <> '' THEN
            DimSelection.InsertDimSelBuf(FALSE, GLBudgetName."Budget Dimension 4 Code", '');

        DimSelection.LOOKUPMODE := TRUE;
        IF DimSelection.RUNMODAL = ACTION::LookupOK THEN
            EXIT(DimSelection.GetDimSelCode);

        EXIT(OldDimSelCode);
    end;

    local procedure LookUpDimFilter(Dim: Code[20]; var Text: Text[250]): Boolean
    var
        DimVal: Record "Dimension Value";
        DimValList: Page "Dimension Value List";
    begin
        IF Dim = '' THEN
            EXIT(FALSE);
        DimValList.LOOKUPMODE(TRUE);
        DimVal.SETRANGE("Dimension Code", Dim);
        DimValList.SETTABLEVIEW(DimVal);
        IF DimValList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            DimValList.GETRECORD(DimVal);
            Text := DimValList.GetSelectionFilter;
        END;
        EXIT(TRUE);
    end;

    local procedure DeleteBudget()
    var
        GLBudgetEntry: Record "Workplan Entry";
        UpdateAnalysisView: Codeunit "Update Analysis View";
    begin
        IF CONFIRM(Text003) THEN BEGIN

            GLBudgetEntry.SETRANGE("Workplan Code", BudgetName);
            IF BusUnitFilter <> '' THEN
                GLBudgetEntry.SETFILTER("Business Unit Code", BusUnitFilter);
            IF GLAccFilter <> '' THEN
                GLBudgetEntry.SETFILTER("G/L Account No.", GLAccFilter);
            IF DateFilter <> '' THEN
                GLBudgetEntry.SETFILTER(Date, DateFilter);
            IF GlobalDim1Filter <> '' THEN
                GLBudgetEntry.SETFILTER("Global Dimension 1 Code", GlobalDim1Filter);
            IF GlobalDim2Filter <> '' THEN
                GLBudgetEntry.SETFILTER("Global Dimension 2 Code", GlobalDim2Filter);
            IF BudgetDim1Filter <> '' THEN
                GLBudgetEntry.SETFILTER("Budget Dimension 1 Code", BudgetDim1Filter);
            IF BudgetDim2Filter <> '' THEN
                GLBudgetEntry.SETFILTER("Budget Dimension 2 Code", BudgetDim2Filter);
            IF BudgetDim3Filter <> '' THEN
                GLBudgetEntry.SETFILTER("Budget Dimension 3 Code", BudgetDim3Filter);
            IF BudgetDim4Filter <> '' THEN
                GLBudgetEntry.SETFILTER("Budget Dimension 4 Code", BudgetDim4Filter);
            GLBudgetEntry.SETCURRENTKEY("Entry No.");
            IF GLBudgetEntry.FINDFIRST THEN
                UpdateAnalysisView.SetLastBudgetEntryNo(GLBudgetEntry."Entry No." - 1);
            GLBudgetEntry.SETCURRENTKEY("Workplan Code");
            GLBudgetEntry.DELETEALL(TRUE);
        END;
    end;

    local procedure ValidateBudgetName()
    begin

        GLBudgetName."Workplan Code" := BudgetName;
        IF NOT GLBudgetName.FIND('=<>') THEN BEGIN
            GLBudgetName.INIT;
            GLBudgetName."Workplan Code" := Text004;
            GLBudgetName."Workplan Description" := Text005;
            GLBudgetName.INSERT;
        END;
        BudgetName := GLBudgetName."Workplan Code";
        GLAccBudgetBuf.SETRANGE("Budget Filter", BudgetName);
        IF PrevGLBudgetName."Workplan Code" <> '' THEN BEGIN
            IF GLBudgetName."Budget Dimension 1 Code" <> PrevGLBudgetName."Budget Dimension 1 Code" THEN
                BudgetDim1Filter := '';
            IF GLBudgetName."Budget Dimension 2 Code" <> PrevGLBudgetName."Budget Dimension 2 Code" THEN
                BudgetDim2Filter := '';
            IF GLBudgetName."Budget Dimension 3 Code" <> PrevGLBudgetName."Budget Dimension 3 Code" THEN
                BudgetDim3Filter := '';
            IF GLBudgetName."Budget Dimension 4 Code" <> PrevGLBudgetName."Budget Dimension 4 Code" THEN
                BudgetDim4Filter := '';
        END;
        GLAccBudgetBuf.SETFILTER("Budget Dimension 1 Filter", BudgetDim1Filter);
        GLAccBudgetBuf.SETFILTER("Budget Dimension 2 Filter", BudgetDim2Filter);
        GLAccBudgetBuf.SETFILTER("Budget Dimension 3 Filter", BudgetDim3Filter);
        GLAccBudgetBuf.SETFILTER("Budget Dimension 4 Filter", BudgetDim4Filter);
        BudgetDim1FilterEnable := (GLBudgetName."Budget Dimension 1 Code" <> '');
        BudgetDim2FilterEnable := (GLBudgetName."Budget Dimension 2 Code" <> '');
        BudgetDim3FilterEnable := (GLBudgetName."Budget Dimension 3 Code" <> '');
        BudgetDim4FilterEnable := (GLBudgetName."Budget Dimension 4 Code" <> '');

        PrevGLBudgetName := GLBudgetName;
    end;

    local procedure ValidateLineDimCode()
    var
        BusUnit: Record "Business Unit";
        GLAcc: Record "Workplan Activities";
    begin
        IF (UPPERCASE(LineDimCode) <> UPPERCASE(GLAcc.TABLECAPTION)) AND
           (UPPERCASE(LineDimCode) <> UPPERCASE(BusUnit.TABLECAPTION)) AND
           (UPPERCASE(LineDimCode) <> UPPERCASE(Text001)) AND
           (UPPERCASE(LineDimCode) <> GLBudgetName."Budget Dimension 1 Code") AND
           (UPPERCASE(LineDimCode) <> GLBudgetName."Budget Dimension 2 Code") AND
           (UPPERCASE(LineDimCode) <> GLBudgetName."Budget Dimension 3 Code") AND
           (UPPERCASE(LineDimCode) <> GLBudgetName."Budget Dimension 4 Code") AND
           (UPPERCASE(LineDimCode) <> GLSetup."Global Dimension 1 Code") AND
           (UPPERCASE(LineDimCode) <> GLSetup."Global Dimension 2 Code") AND
           (LineDimCode <> '')
        THEN BEGIN
            MESSAGE(Text006, LineDimCode);
            LineDimCode := '';
        END;
        LineDimOption := DimCodeToOption(LineDimCode);
        DateFilter := InternalDateFilter;
        IF (LineDimOption <> LineDimOption::Period) AND (ColumnDimOption <> ColumnDimOption::Period) THEN BEGIN
            DateFilter := InternalDateFilter;
            IF STRPOS(DateFilter, '&') > 1 THEN
                DateFilter := COPYSTR(DateFilter, 1, STRPOS(DateFilter, '&') - 1);
        END ELSE
            DateFilter := '';
    end;

    local procedure ValidateColumnDimCode()
    var
        BusUnit: Record "Business Unit";
        GLAcc: Record "Workplan Activities";
    begin
        IF (UPPERCASE(ColumnDimCode) <> UPPERCASE(GLAcc.TABLECAPTION)) AND
           (UPPERCASE(ColumnDimCode) <> UPPERCASE(BusUnit.TABLECAPTION)) AND
           (UPPERCASE(ColumnDimCode) <> UPPERCASE(Text001)) AND
           (UPPERCASE(ColumnDimCode) <> GLBudgetName."Budget Dimension 1 Code") AND
           (UPPERCASE(ColumnDimCode) <> GLBudgetName."Budget Dimension 2 Code") AND
           (UPPERCASE(ColumnDimCode) <> GLBudgetName."Budget Dimension 3 Code") AND
           (UPPERCASE(ColumnDimCode) <> GLBudgetName."Budget Dimension 4 Code") AND
           (UPPERCASE(ColumnDimCode) <> GLSetup."Global Dimension 1 Code") AND
           (UPPERCASE(ColumnDimCode) <> GLSetup."Global Dimension 2 Code") AND
           (ColumnDimCode <> '')
        THEN BEGIN
            MESSAGE(Text007, ColumnDimCode);
            ColumnDimCode := '';
        END;
        ColumnDimOption := DimCodeToOption(ColumnDimCode);
        DateFilter := InternalDateFilter;
        IF (LineDimOption <> LineDimOption::Period) AND (ColumnDimOption <> ColumnDimOption::Period) THEN BEGIN
            DateFilter := InternalDateFilter;
            IF STRPOS(DateFilter, '&') > 1 THEN
                DateFilter := COPYSTR(DateFilter, 1, STRPOS(DateFilter, '&') - 1);
        END ELSE
            DateFilter := '';
    end;

    local procedure GetCaptionClass(BudgetDimType: Integer): Text[250]
    begin
        IF GLBudgetName."Workplan Code" <> BudgetName THEN
            GLBudgetName.GET(BudgetName);
        CASE BudgetDimType OF
            1:
                BEGIN
                    IF GLBudgetName."Budget Dimension 1 Code" <> '' THEN
                        EXIT('1,6,' + GLBudgetName."Budget Dimension 1 Code");

                    EXIT(Text008);
                END;
            2:
                BEGIN
                    IF GLBudgetName."Budget Dimension 2 Code" <> '' THEN
                        EXIT('1,6,' + GLBudgetName."Budget Dimension 2 Code");

                    EXIT(Text009);
                END;
            3:
                BEGIN
                    IF GLBudgetName."Budget Dimension 3 Code" <> '' THEN
                        EXIT('1,6,' + GLBudgetName."Budget Dimension 3 Code");

                    EXIT(Text010);
                END;
            4:
                BEGIN
                    IF GLBudgetName."Budget Dimension 4 Code" <> '' THEN
                        EXIT('1,6,' + GLBudgetName."Budget Dimension 4 Code");

                    EXIT(Text011);
                END;
        END;
    end;

    procedure SetBudgetName(NextBudgetName: Code[30])
    begin
        NewBudgetName := NextBudgetName;
    end;

    procedure SetGLAccountFilter(NewGLAccFilter: Code[250])
    begin
        GLAccFilter := NewGLAccFilter;
        GLAccFilterOnAfterValidate;
    end;

    procedure UpdateMatrixSubform()
    begin
        CurrPage.MatrixForm.PAGE.Load(
          MATRIX_CaptionSet, MATRIX_MatrixRecords, MATRIX_CurrentNoOfColumns, LineDimCode,
          LineDimOption, ColumnDimOption, GlobalDim1Filter, GlobalDim2Filter, BudgetDim1Filter,
          BudgetDim2Filter, BudgetDim3Filter, BudgetDim4Filter, GLBudgetName, DateFilter,
          GLAccFilter, RoundingFactor, PeriodType);

        CurrPage.UPDATE;
    end;

    local procedure LineDimCodeOnAfterValidate()
    begin
        UpdateMatrixSubform;
    end;

    local procedure ColumnDimCodeOnAfterValidate()
    begin
        UpdateMatrixSubform;
    end;

    local procedure PeriodTypeOnAfterValidate()
    var
        MATRIX_Step: Option First,Previous,Same,Next;
    begin
        IF ColumnDimOption = ColumnDimOption::Period THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
        UpdateMatrixSubform;
    end;

    local procedure GLAccFilterOnAfterValidate()
    begin
        GLAccBudgetBuf.SETFILTER("G/L Account Filter", GLAccFilter);
        IF ColumnDimOption = ColumnDimOption::"G/L Account" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
        UpdateMatrixSubform;
    end;

    local procedure GlobalDim2FilterOnAfterValidat()
    begin
        GLAccBudgetBuf.SETFILTER("Global Dimension 2 Filter", GlobalDim2Filter);
        IF ColumnDimOption = ColumnDimOption::"Global Dimension 2" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
        UpdateMatrixSubform;
    end;

    local procedure GlobalDim1FilterOnAfterValidat()
    begin
        GLAccBudgetBuf.SETFILTER("Global Dimension 1 Filter", GlobalDim1Filter);
        IF ColumnDimOption = ColumnDimOption::"Global Dimension 1" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
        UpdateMatrixSubform;
    end;

    local procedure BudgetDim2FilterOnAfterValidat()
    begin
        GLAccBudgetBuf.SETFILTER("Budget Dimension 2 Filter", BudgetDim2Filter);
        IF ColumnDimOption = ColumnDimOption::"Budget Dimension 2" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
        UpdateMatrixSubform;
    end;

    local procedure BudgetDim1FilterOnAfterValidat()
    begin
        GLAccBudgetBuf.SETFILTER("Budget Dimension 1 Filter", BudgetDim1Filter);
        IF ColumnDimOption = ColumnDimOption::"Budget Dimension 1" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
        UpdateMatrixSubform;
    end;

    local procedure BudgetDim4FilterOnAfterValidat()
    begin
        GLAccBudgetBuf.SETFILTER("Budget Dimension 4 Filter", BudgetDim4Filter);
        IF ColumnDimOption = ColumnDimOption::"Budget Dimension 4" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
        UpdateMatrixSubform;
    end;

    local procedure BudgetDim3FilterOnAfterValidat()
    begin
        GLAccBudgetBuf.SETFILTER("Budget Dimension 3 Filter", BudgetDim3Filter);
        IF ColumnDimOption = ColumnDimOption::"Budget Dimension 3" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
        UpdateMatrixSubform;
    end;

    local procedure DateFilterOnAfterValidate()
    begin
        IF ColumnDimOption = ColumnDimOption::Period THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::First);
        UpdateMatrixSubform;
    end;

    local procedure ShowColumnNameOnPush()
    var
        MATRIX_Step: Option First,Previous,Same,Next;
    begin
        MATRIX_GenerateColumnCaptions(MATRIX_Step::Same);
        UpdateMatrixSubform;
    end;
}

