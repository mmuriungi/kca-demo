page 50162 "Budget Workplan Matrix"
{
    Caption = 'Budget Matrix';
    DataCaptionExpression = BudgetName;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Dimension Code Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                field(Code; Rec.Code)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookUpCode(LineDimOption, LineDimCode, Rec.Code);
                    end;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = Emphasize;
                }
                field(TotalBudgetedAmount; Rec.Amount)
                {
                    BlankZero = true;
                    Caption = 'Budgeted Amount';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        SetCommonFilters(GLAccBudgetBuf);
                        SetDimFilters(GLAccBudgetBuf, 0);
                        BudgetDrillDown;
                    end;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(1);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(2);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(3);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(4);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(5);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[6];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(6);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[7];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(7);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[8];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(8);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[9];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(9);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[10];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(10);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[11];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(11);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[12];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(12);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(12);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Balance")
            {
                Caption = '&Balance';
                Image = Balance;
                action("G/L Account Balance/Bud&get")
                {
                    Caption = 'G/L Account Balance/Bud&get';
                    Image = Period;

                    trigger OnAction()
                    begin
                        GLAccountBalanceBudget;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
    begin
        NameIndent := 0;
        FOR MATRIX_CurrentColumnOrdinal := 1 TO MATRIX_CurrentNoOfMatrixColumn DO
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
        Rec.Amount := ToRoundedValue(CalcAmount(FALSE));
        FormatLine;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        EXIT(FindRec(LineDimOption, Rec, Which));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        EXIT(NextRec(LineDimOption, Rec, Steps));
    end;

    trigger OnOpenPage()
    begin

        IF GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter") <> '' THEN
            GlobalDim1Filter := GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter");
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter") <> '' THEN
            GlobalDim2Filter := GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter");

        GLSetup.GET;
    end;

    var
        Text001: Label 'Period';
        Text002: Label 'You may only edit column 1 to %1.';
        GLSetup: Record "General Ledger Setup";
        GLAccBudgetBuf: Record "Workplan Budget Buffer";
        GLBudgetName: Record "Workplan";
        MatrixRecords: array[12] of Record "Dimension Code Buffer";
        MATRIX_MatrixRecord: Record "Dimension Code Buffer";
        BudgetName: Code[70];
        LineDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4",WorkPlan;
        ColumnDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4",WorkPlan;
        LineDimCode: Text[30];
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
        MatrixHeader: Text[50];
        PeriodInitialized: Boolean;
        MATRIX_CurrentNoOfMatrixColumn: Integer;
        MATRIX_CellData: array[12] of Decimal;
        MATRIX_CaptionSet: array[12] of Text[80];
        [InDataSet]
        Emphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;

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

    local procedure FindRec(var DimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4",WorkPlan; var DimCodeBuf: Record "Dimension Code Buffer"; Which: Text[250]): Boolean
    var
        GLAcc: Record "Workplan Activities";
        BusUnit: Record "Business Unit";
        Period: Record "Date";
        DimVal: Record "Dimension Value";
        PeriodFormMgt: Codeunit "PeriodPageManagement";
        Found: Boolean;
        WorkPlan: Record "Workplan Activities";
    begin
        CASE DimOption OF
            DimOption::"G/L Account":
                BEGIN
                    GLAcc."No." := DimCodeBuf.Code;
                    IF GLAccFilter <> '' THEN
                        GLAcc.SETFILTER("No.", GLAccFilter);
                    Found := GLAcc.FIND(Which);
                    IF Found THEN
                        CopyGLAccToBuf(GLAcc, DimCodeBuf);
                END;
            DimOption::Period:
                BEGIN
                    IF NOT PeriodInitialized THEN
                        DateFilter := '';
                    PeriodInitialized := TRUE;
                    Period."Period Start" := DimCodeBuf."Period Start";
                    IF DateFilter <> '' THEN
                        Period.SETFILTER("Period Start", DateFilter)
                    ELSE
                        IF NOT PeriodInitialized AND (InternalDateFilter <> '') THEN
                            Period.SETFILTER("Period Start", InternalDateFilter);
                    Found := PeriodFormMgt.FindDate(Which, Period, PeriodType);
                    IF Found THEN
                        CopyPeriodToBuf(Period, DimCodeBuf);
                END;
            DimOption::"Business Unit":
                BEGIN
                    BusUnit.Code := DimCodeBuf.Code;
                    IF BusUnitFilter <> '' THEN
                        BusUnit.SETFILTER(Code, BusUnitFilter);
                    Found := BusUnit.FIND(Which);
                    IF Found THEN
                        CopyBusUnitToBuf(BusUnit, DimCodeBuf);
                END;
            DimOption::"Global Dimension 1":
                BEGIN
                    IF GlobalDim1Filter <> '' THEN
                        DimVal.SETFILTER(Code, GlobalDim1Filter);
                    DimVal."Dimension Code" := GLSetup."Global Dimension 1 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.FIND(Which);
                    IF Found THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Global Dimension 2":
                BEGIN
                    IF GlobalDim2Filter <> '' THEN
                        DimVal.SETFILTER(Code, GlobalDim2Filter);
                    DimVal."Dimension Code" := GLSetup."Global Dimension 2 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.FIND(Which);
                    IF Found THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 1":
                BEGIN
                    IF BudgetDim1Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim1Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 1 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.FIND(Which);
                    IF Found THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 2":
                BEGIN
                    IF BudgetDim2Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim2Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 2 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.FIND(Which);
                    IF Found THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 3":
                BEGIN
                    IF BudgetDim3Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim3Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 3 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.FIND(Which);
                    IF Found THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 4":
                BEGIN
                    IF BudgetDim4Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim4Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 4 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.FIND(Which);
                    IF Found THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;

            DimOption::WorkPlan:
                BEGIN
                    WorkPlan."Activity Code" := DimCodeBuf.Code;
                    IF GLAccFilter <> '' THEN
                        WorkPlan.SETFILTER("Activity Code", GLAccFilter);

                    //Added
                    IF GLBudgetName."Workplan Code" = 'PR0CMNT' THEN BEGIN
                        //Do not set any filters
                    END ELSE BEGIN
                        //Filter by Departmental Workplan
                        WorkPlan.SETFILTER("Workplan Code", GLBudgetName."Workplan Code");
                    END;

                    Found := WorkPlan.FIND(Which);
                    IF Found THEN
                        CopyWorkPlanToBuf(WorkPlan, DimCodeBuf);
                END;

        END;
        EXIT(Found);
    end;

    local procedure NextRec(DimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4",WorkPlan; var DimCodeBuf: Record "Dimension Code Buffer"; Steps: Integer): Integer
    var
        GLAcc: Record "Workplan Activities";
        BusUnit: Record "Business Unit";
        Period: Record "Date";
        DimVal: Record "Dimension Value";
        PeriodFormMgt: Codeunit "PeriodPageManagement";
        ResultSteps: Integer;
        WorkPlan: Record "Workplan Activities";
    begin

        CASE DimOption OF
            DimOption::"G/L Account":
                BEGIN
                    GLAcc."No." := DimCodeBuf.Code;
                    IF GLAccFilter <> '' THEN
                        GLAcc.SETFILTER("No.", GLAccFilter);
                    ResultSteps := GLAcc.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyGLAccToBuf(GLAcc, DimCodeBuf);
                END;


            DimOption::Period:
                BEGIN
                    IF DateFilter <> '' THEN
                        Period.SETFILTER("Period Start", DateFilter);
                    Period."Period Start" := DimCodeBuf."Period Start";
                    ResultSteps := PeriodFormMgt.NextDate(Steps, Period, PeriodType);
                    IF ResultSteps <> 0 THEN
                        CopyPeriodToBuf(Period, DimCodeBuf);
                END;
            DimOption::"Business Unit":
                BEGIN
                    BusUnit.Code := DimCodeBuf.Code;
                    IF BusUnitFilter <> '' THEN
                        BusUnit.SETFILTER(Code, BusUnitFilter);
                    ResultSteps := BusUnit.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyBusUnitToBuf(BusUnit, DimCodeBuf);
                END;
            DimOption::"Global Dimension 1":
                BEGIN
                    IF GlobalDim1Filter <> '' THEN
                        DimVal.SETFILTER(Code, GlobalDim1Filter);
                    DimVal."Dimension Code" := GLSetup."Global Dimension 1 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Global Dimension 2":
                BEGIN
                    IF GlobalDim2Filter <> '' THEN
                        DimVal.SETFILTER(Code, GlobalDim2Filter);
                    DimVal."Dimension Code" := GLSetup."Global Dimension 2 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 1":
                BEGIN
                    IF BudgetDim1Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim1Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 1 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 2":
                BEGIN
                    IF BudgetDim2Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim2Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 2 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 3":
                BEGIN
                    IF BudgetDim3Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim3Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 3 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 4":
                BEGIN
                    IF BudgetDim4Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim4Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 4 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::WorkPlan:

                BEGIN
                    WorkPlan."Activity Code" := DimCodeBuf.Code;
                    IF GLAccFilter <> '' THEN
                        WorkPlan.SETFILTER("Activity Code", GLAccFilter);
                    //Cater for Year and other dimensions

                    //Added
                    IF GLBudgetName."Workplan Code" = 'PR0CMNT' THEN BEGIN
                        //Do not set any filters
                    END ELSE BEGIN
                        //Filter by Departmental Workplan
                        WorkPlan.SETFILTER("Workplan Code", GLBudgetName."Workplan Code");
                    END;

                    IF GlobalDim1Filter <> '' THEN
                        WorkPlan.SETFILTER("Global Dimension 1 Code", GlobalDim1Filter);
                    IF GlobalDim2Filter <> '' THEN
                        WorkPlan.SETFILTER("Shortcut Dimension 2 Code", GlobalDim2Filter);
                    //End Year and other Dimensions

                    ResultSteps := WorkPlan.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyWorkPlanToBuf(WorkPlan, DimCodeBuf);
                END;

        END;


        EXIT(ResultSteps);
    end;

    local procedure CopyGLAccToBuf(var TheGLAcc: Record "Workplan Activities"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin

        TheDimCodeBuf.INIT;
        TheDimCodeBuf.Code := TheGLAcc."No.";
        TheDimCodeBuf.Name := TheGLAcc."Activity Code";
        TheDimCodeBuf.Totaling := TheGLAcc.Totaling;
        TheDimCodeBuf.Indentation := TheGLAcc.Indentation;
        TheDimCodeBuf."Show in Bold" := TheGLAcc."Account Type" <> TheGLAcc."Account Type"::Posting;
    end;

    local procedure CopyPeriodToBuf(var ThePeriod: Record "Date"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    var
        Period2: Record "Date";
    begin
        TheDimCodeBuf.INIT;
        TheDimCodeBuf.Code := FORMAT(ThePeriod."Period Start");
        TheDimCodeBuf."Period Start" := ThePeriod."Period Start";
        TheDimCodeBuf."Period End" := ThePeriod."Period End";
        IF DateFilter <> '' THEN BEGIN
            Period2.SETFILTER("Period End", DateFilter);
            IF Period2.GETRANGEMAX("Period End") < TheDimCodeBuf."Period End" THEN
                TheDimCodeBuf."Period End" := Period2.GETRANGEMAX("Period End");
        END;
        TheDimCodeBuf.Name := ThePeriod."Period Name";
    end;

    local procedure CopyBusUnitToBuf(var TheBusUnit: Record "Business Unit"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        TheDimCodeBuf.INIT;
        TheDimCodeBuf.Code := TheBusUnit.Code;
        IF TheBusUnit.Name <> '' THEN
            TheDimCodeBuf.Name := TheBusUnit.Name
        ELSE
            TheDimCodeBuf.Name := TheBusUnit."Company Name";
    end;

    local procedure CopyDimValToBuf(var TheDimVal: Record "Dimension Value"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        TheDimCodeBuf.INIT;
        TheDimCodeBuf.Code := TheDimVal.Code;
        TheDimCodeBuf.Name := TheDimVal.Name;
        TheDimCodeBuf.Totaling := TheDimVal.Totaling;
        TheDimCodeBuf.Indentation := TheDimVal.Indentation;
        TheDimCodeBuf."Show in Bold" :=
          TheDimVal."Dimension Value Type" <> TheDimVal."Dimension Value Type"::Standard;
    end;

    local procedure LookUpCode(DimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4"; DimCode: Text[30]; "Code": Text[30])
    var
        GLAcc: Record "Workplan Activities";
        BusUnit: Record "Business Unit";
        DimVal: Record "Dimension Value";
        DimValList: Page "Dimension Value List";
    begin
        CASE DimOption OF
            DimOption::"G/L Account":
                BEGIN
                    GLAcc.GET(Code);
                    PAGE.RUNMODAL(PAGE::"G/L Account List", GLAcc);
                END;
            DimOption::Period:
                ;
            DimOption::"Business Unit":
                BEGIN
                    BusUnit.GET(Code);
                    PAGE.RUNMODAL(PAGE::"Business Unit List", BusUnit);
                END;
            DimOption::"Global Dimension 1", DimOption::"Global Dimension 2",
            DimOption::"Budget Dimension 1", DimOption::"Budget Dimension 2",
            DimOption::"Budget Dimension 3", DimOption::"Budget Dimension 4":
                BEGIN
                    DimVal.SETRANGE("Dimension Code", DimCode);
                    DimVal.GET(DimCode, Code);
                    DimValList.SETTABLEVIEW(DimVal);
                    DimValList.SETRECORD(DimVal);
                    DimValList.RUNMODAL;
                END;
        END;
    end;

    local procedure SetCommonFilters(var TheGLAccBudgetBuf: Record "Workplan Budget Buffer")
    begin
        TheGLAccBudgetBuf.RESET;
        TheGLAccBudgetBuf.SETRANGE("Budget Filter", GLBudgetName."Workplan Code");
        IF BusUnitFilter <> '' THEN
            TheGLAccBudgetBuf.SETFILTER("Business Unit Filter", BusUnitFilter);
        IF GLAccFilter <> '' THEN
            TheGLAccBudgetBuf.SETFILTER("G/L Account Filter", GLAccFilter);
        IF DateFilter <> '' THEN
            TheGLAccBudgetBuf.SETFILTER("Date Filter", DateFilter);
        IF GlobalDim1Filter <> '' THEN
            TheGLAccBudgetBuf.SETFILTER("Global Dimension 1 Filter", GlobalDim1Filter);
        IF GlobalDim2Filter <> '' THEN
            TheGLAccBudgetBuf.SETFILTER("Global Dimension 2 Filter", GlobalDim2Filter);
        IF BudgetDim1Filter <> '' THEN
            TheGLAccBudgetBuf.SETFILTER("Budget Dimension 1 Filter", BudgetDim1Filter);
        IF BudgetDim2Filter <> '' THEN
            TheGLAccBudgetBuf.SETFILTER("Budget Dimension 2 Filter", BudgetDim2Filter);
        IF BudgetDim3Filter <> '' THEN
            TheGLAccBudgetBuf.SETFILTER("Budget Dimension 3 Filter", BudgetDim3Filter);
        IF BudgetDim4Filter <> '' THEN
            TheGLAccBudgetBuf.SETFILTER("Budget Dimension 4 Filter", BudgetDim4Filter);
    end;

    local procedure SetDimFilters(var TheGLAccBudgetBuf: Record "Workplan Budget Buffer"; LineOrColumn: Option Line,Column)
    var
        DimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4",WorkPlan;
        DimCodeBuf: Record "Dimension Code Buffer";
    begin
        IF LineOrColumn = LineOrColumn::Line THEN BEGIN
            DimCodeBuf := Rec;
            DimOption := LineDimOption;
        END ELSE BEGIN
            DimCodeBuf := MATRIX_MatrixRecord;
            DimOption := ColumnDimOption;
        END;

        CASE DimOption OF
            DimOption::"G/L Account":
                IF DimCodeBuf.Totaling <> '' THEN
                    GLAccBudgetBuf.SETFILTER("G/L Account Filter", DimCodeBuf.Totaling)
                ELSE
                    GLAccBudgetBuf.SETRANGE("G/L Account Filter", DimCodeBuf.Code);
            //WorkPlan
            DimOption::WorkPlan:
                IF DimCodeBuf.Totaling <> '' THEN
                    GLAccBudgetBuf.SETFILTER("G/L Account Filter", DimCodeBuf.Totaling)
                ELSE
                    GLAccBudgetBuf.SETRANGE("G/L Account Filter", DimCodeBuf.Code);

            DimOption::Period:
                TheGLAccBudgetBuf.SETRANGE("Date Filter", DimCodeBuf."Period Start", DimCodeBuf."Period End");
            DimOption::"Business Unit":
                TheGLAccBudgetBuf.SETRANGE("Business Unit Filter", DimCodeBuf.Code);
            DimOption::"Global Dimension 1":
                IF DimCodeBuf.Totaling <> '' THEN
                    TheGLAccBudgetBuf.SETFILTER("Global Dimension 1 Filter", DimCodeBuf.Totaling)
                ELSE
                    TheGLAccBudgetBuf.SETRANGE("Global Dimension 1 Filter", DimCodeBuf.Code);
            DimOption::"Global Dimension 2":
                IF DimCodeBuf.Totaling <> '' THEN
                    TheGLAccBudgetBuf.SETFILTER("Global Dimension 2 Filter", DimCodeBuf.Totaling)
                ELSE
                    TheGLAccBudgetBuf.SETRANGE("Global Dimension 2 Filter", DimCodeBuf.Code);
            DimOption::"Budget Dimension 1":
                IF DimCodeBuf.Totaling <> '' THEN
                    TheGLAccBudgetBuf.SETFILTER("Budget Dimension 1 Filter", DimCodeBuf.Totaling)
                ELSE
                    TheGLAccBudgetBuf.SETRANGE("Budget Dimension 1 Filter", DimCodeBuf.Code);
            DimOption::"Budget Dimension 2":
                IF DimCodeBuf.Totaling <> '' THEN
                    TheGLAccBudgetBuf.SETFILTER("Budget Dimension 2 Filter", DimCodeBuf.Totaling)
                ELSE
                    TheGLAccBudgetBuf.SETRANGE("Budget Dimension 2 Filter", DimCodeBuf.Code);
            DimOption::"Budget Dimension 3":
                IF DimCodeBuf.Totaling <> '' THEN
                    TheGLAccBudgetBuf.SETFILTER("Budget Dimension 3 Filter", DimCodeBuf.Totaling)
                ELSE
                    TheGLAccBudgetBuf.SETRANGE("Budget Dimension 3 Filter", DimCodeBuf.Code);
            DimOption::"Budget Dimension 4":
                IF DimCodeBuf.Totaling <> '' THEN
                    TheGLAccBudgetBuf.SETFILTER("Budget Dimension 4 Filter", DimCodeBuf.Totaling)
                ELSE
                    TheGLAccBudgetBuf.SETRANGE("Budget Dimension 4 Filter", DimCodeBuf.Code);

        END;
    end;

    local procedure BudgetDrillDown()
    var
        GLBudgetEntry: Record "Workplan Entry";
    begin

        GLBudgetEntry.SETRANGE("Workplan Code", GLBudgetName."Workplan Code");
        IF GLAccBudgetBuf.GETFILTER("G/L Account Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("G/L Account Filter", GLBudgetEntry."Activity Code");
        IF GLAccBudgetBuf.GETFILTER("Business Unit Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Business Unit Filter", GLBudgetEntry."Business Unit Code");
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Global Dimension 1 Filter", GLBudgetEntry."Global Dimension 1 Code");
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Global Dimension 2 Filter", GLBudgetEntry."Global Dimension 2 Code");
        IF GLAccBudgetBuf.GETFILTER("Budget Dimension 1 Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Budget Dimension 1 Filter", GLBudgetEntry."Budget Dimension 1 Code");
        IF GLAccBudgetBuf.GETFILTER("Budget Dimension 2 Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Budget Dimension 2 Filter", GLBudgetEntry."Budget Dimension 2 Code");
        IF GLAccBudgetBuf.GETFILTER("Budget Dimension 3 Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Budget Dimension 3 Filter", GLBudgetEntry."Budget Dimension 3 Code");
        IF GLAccBudgetBuf.GETFILTER("Budget Dimension 4 Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Budget Dimension 4 Filter", GLBudgetEntry."Budget Dimension 4 Code");
        IF GLAccBudgetBuf.GETFILTER("Date Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Date Filter", GLBudgetEntry.Date)
        ELSE
            GLBudgetEntry.SETRANGE(Date, 0D, 99991231D);
        IF (GLBudgetEntry.GETFILTER("Global Dimension 1 Code") <> '') OR (GLBudgetEntry.GETFILTER("Global Dimension 2 Code") <> '') OR
   (GLBudgetEntry.GETFILTER("Business Unit Code") <> '')
THEN
            GLBudgetEntry.SETCURRENTKEY("Workplan Code", "Activity Code", "Business Unit Code", "Global Dimension 1 Code")
        ELSE
            GLBudgetEntry.SETCURRENTKEY("Workplan Code", "Activity Code", Date);
        PAGE.RUN(0, GLBudgetEntry);
    end;

    local procedure CalcAmount(SetColumnFilter: Boolean): Decimal
    begin


        SetCommonFilters(GLAccBudgetBuf);
        SetDimFilters(GLAccBudgetBuf, 0);
        IF SetColumnFilter THEN
            SetDimFilters(GLAccBudgetBuf, 1);
        GLAccBudgetBuf.CALCFIELDS("Budgeted Amount");
        EXIT(GLAccBudgetBuf."Budgeted Amount");
    end;

    local procedure ToRoundedValue(OrgAmount: Decimal): Decimal
    var
        NewAmount: Decimal;
    begin
        NewAmount := OrgAmount;
        CASE RoundingFactor OF
            RoundingFactor::"1":
                NewAmount := ROUND(OrgAmount, 1);
            RoundingFactor::"1000":
                NewAmount := ROUND(OrgAmount / 1000);
            RoundingFactor::"1000000":
                NewAmount := ROUND(OrgAmount / 1000000);
        END;
        EXIT(NewAmount);
    end;

    local procedure FromRoundedValue(OrgAmount: Decimal): Decimal
    var
        NewAmount: Decimal;
    begin
        NewAmount := OrgAmount;
        CASE RoundingFactor OF
            RoundingFactor::"1000":
                NewAmount := OrgAmount * 1000;
            RoundingFactor::"1000000":
                NewAmount := OrgAmount * 1000000;
        END;
        EXIT(NewAmount);
    end;

    procedure Load(MatrixColumns1: array[32] of Text[80]; var MatrixRecords1: array[12] of Record "Dimension Code Buffer"; CurrentNoOfMatrixColumns: Integer; _LineDimCode: Text[30]; _LineDimOption: Integer; _ColumnDimOption: Integer; _GlobalDim1Filter: Code[250]; _GlobalDim2Filter: Code[250]; _BudgetDim1Filter: Code[250]; _BudgetDim2Filter: Code[250]; _BudgetDim3Filter: Code[250]; _BudgetDim4Filter: Code[250]; var _GLBudgetName: Record "Workplan"; _DateFilter: Text[30]; _GLAccFilter: Code[250]; _RoundingFactor: Integer; _PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period")
    var
        i: Integer;
    begin
        FOR i := 1 TO 12 DO
            MATRIX_CellData[i] := 0;

        FOR i := 1 TO 12 DO BEGIN
            IF MatrixColumns1[i] = '' THEN
                MATRIX_CaptionSet[i] := ' '
            ELSE
                MATRIX_CaptionSet[i] := MatrixColumns1[i];
            MatrixRecords[i] := MatrixRecords1[i];
        END;
        IF CurrentNoOfMatrixColumns > ARRAYLEN(MATRIX_CellData) THEN
            MATRIX_CurrentNoOfMatrixColumn := ARRAYLEN(MATRIX_CellData)
        ELSE
            MATRIX_CurrentNoOfMatrixColumn := CurrentNoOfMatrixColumns;
        LineDimCode := _LineDimCode;
        LineDimOption := _LineDimOption;
        ColumnDimOption := _ColumnDimOption;
        GlobalDim1Filter := _GlobalDim1Filter;
        GlobalDim2Filter := _GlobalDim2Filter;
        BudgetDim1Filter := _BudgetDim1Filter;
        BudgetDim2Filter := _BudgetDim2Filter;
        BudgetDim3Filter := _BudgetDim3Filter;
        BudgetDim4Filter := _BudgetDim4Filter;
        GLBudgetName := _GLBudgetName;
        DateFilter := _DateFilter;
        GLAccFilter := _GLAccFilter;
        RoundingFactor := _RoundingFactor;
        PeriodType := _PeriodType;
    end;

    local procedure MATRIX_OnDrillDown(MATRIX_ColumnOrdinal: Integer)
    begin
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        SetCommonFilters(GLAccBudgetBuf);
        SetDimFilters(GLAccBudgetBuf, 0);
        SetDimFilters(GLAccBudgetBuf, 1);
        BudgetDrillDown;
    end;

    local procedure MATRIX_OnAfterGetRecord(MATRIX_ColumnOrdinal: Integer)
    begin
        IF ShowColumnName THEN
            MatrixHeader := MatrixRecords[MATRIX_ColumnOrdinal].Name
        ELSE
            MatrixHeader := MatrixRecords[MATRIX_ColumnOrdinal].Code;
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        MATRIX_CellData[MATRIX_ColumnOrdinal] := ToRoundedValue(CalcAmount(TRUE));
    end;

    procedure UpdateAmount(MATRIX_ColumnOrdinal: Integer)
    var
        NewAmount: Decimal;
    begin
        IF MATRIX_ColumnOrdinal > MATRIX_CurrentNoOfMatrixColumn THEN
            ERROR(Text002, MATRIX_CurrentNoOfMatrixColumn);
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        NewAmount := FromRoundedValue(MATRIX_CellData[MATRIX_ColumnOrdinal]);
        IF CalcAmount(TRUE) = 0 THEN; // To set filters correctly
        GLAccBudgetBuf.CALCFIELDS("Budgeted Amount");
        GLAccBudgetBuf.VALIDATE("Budgeted Amount", NewAmount);
        Rec.Amount := ToRoundedValue(CalcAmount(FALSE));
        CurrPage.UPDATE;
    end;

    procedure GLAccountBalanceBudget()
    var
        GLAcc: Record "Workplan Activities";
    begin
        IF DimCodeToOption(LineDimCode) = 0 THEN
            GLAcc.GET(Rec.Code)
        ELSE BEGIN
            IF GLAccFilter <> '' THEN
                GLAcc.SETFILTER("No.", GLAccFilter);
            GLAcc.FINDFIRST;
            GLAcc.RESET;
        END;
        GLAcc.SETRANGE("Budget Filter", BudgetName);
        IF BusUnitFilter <> '' THEN
            GLAcc.SETFILTER("Business Unit Filter", BusUnitFilter);
        IF GLAccFilter <> '' THEN
            GLAcc.SETFILTER("No.", GLAccFilter);
        IF GlobalDim1Filter <> '' THEN
            GLAcc.SETFILTER("Global Dimension 1 Filter", GlobalDim1Filter);
        IF GlobalDim2Filter <> '' THEN
            GLAcc.SETFILTER("Global Dimension 2 Filter", GlobalDim2Filter);
        PAGE.RUN(PAGE::"G/L Account Balance/Budget", GLAcc);
    end;

    local procedure FormatLine()
    begin
        Emphasize := Rec."Show in Bold";
        NameIndent := Rec.Indentation;
    end;

    local procedure CopyWorkPlanToBuf(var TheGLAcc: Record "Workplan Activities"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        TheDimCodeBuf.INIT;
        TheDimCodeBuf.Code := TheGLAcc."Activity Code";
        TheDimCodeBuf.Name := TheGLAcc."Activity Description";
        TheDimCodeBuf.Totaling := TheGLAcc.Totaling;
        TheDimCodeBuf.Indentation := TheGLAcc.Indentation;
        TheDimCodeBuf."Show in Bold" := TheGLAcc."Account Type" <> TheGLAcc."Account Type"::Posting;
    end;
}

