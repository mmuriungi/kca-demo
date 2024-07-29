page 50158 "W/P Budget Entries"
{
    Caption = 'W/P Budget Entries';
    DataCaptionFields = "Workplan Code", "Activity Code";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Workplan Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Workplan Code"; Rec."Workplan Code")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                }
                field("Activity Code"; Rec."Activity Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Expense Code"; Rec."Expense Code")
                {
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Enabled = "Global Dimension 1 CodeEnable";
                    Visible = "Global Dimension 1 CodeVisible";
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Enabled = "Global Dimension 2 CodeEnable";
                    Visible = "Global Dimension 2 CodeVisible";
                }
                field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
                {
                    Enabled = "Budget Dimension 1 CodeEnable";
                    Visible = "Budget Dimension 1 CodeVisible";
                }
                field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
                {
                    Enabled = "Budget Dimension 2 CodeEnable";
                    Visible = "Budget Dimension 2 CodeVisible";
                }
                field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
                {
                    Enabled = "Budget Dimension 3 CodeEnable";
                    Visible = "Budget Dimension 3 CodeVisible";
                }
                field("Budget Dimension 4 Code"; Rec."Budget Dimension 4 Code")
                {
                    Enabled = "Budget Dimension 4 CodeEnable";
                    Visible = "Budget Dimension 4 CodeVisible";
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Processed to Budget"; Rec."Processed to Budget")
                {
                    Editable = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    Editable = false;
                }
                field("Created By:"; Rec."Created By:")
                {
                    Editable = false;
                }
                field("Last Modified By:"; Rec."Last Modified By:")
                {
                    Editable = false;
                }
            }
        }

    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF Rec."Entry No." <> 0 THEN
            IF Rec."Dimension Set ID" <> xRec."Dimension Set ID" THEN
                LowestModifiedEntryNo := Rec."Entry No.";
    end;

    trigger OnClosePage()
    var
        UpdateAnalysisView: Codeunit "Update Analysis View";
    begin
        IF LowestModifiedEntryNo < 2147483647 THEN
            UpdateAnalysisView.SetLastBudgetEntryNo(LowestModifiedEntryNo - 1);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF Rec."Entry No." < LowestModifiedEntryNo THEN
            LowestModifiedEntryNo := Rec."Entry No.";
        EXIT(TRUE);
    end;

    trigger OnInit()
    begin
        "Budget Dimension 4 CodeEnable" := TRUE;
        "Budget Dimension 3 CodeEnable" := TRUE;
        "Budget Dimension 2 CodeEnable" := TRUE;
        "Budget Dimension 1 CodeEnable" := TRUE;
        "Global Dimension 2 CodeEnable" := TRUE;
        "Global Dimension 1 CodeEnable" := TRUE;
        "Budget Dimension 4 CodeVisible" := TRUE;
        "Budget Dimension 3 CodeVisible" := TRUE;
        "Budget Dimension 2 CodeVisible" := TRUE;
        "Budget Dimension 1 CodeVisible" := TRUE;
        "Global Dimension 2 CodeVisible" := TRUE;
        "Global Dimension 1 CodeVisible" := TRUE;
        LowestModifiedEntryNo := 2147483647;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF Rec."Entry No." < LowestModifiedEntryNo THEN
            LowestModifiedEntryNo := Rec."Entry No.";
        EXIT(TRUE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF Rec.GETFILTER("Workplan Code") <> '' THEN
            Rec."Workplan Code" := Rec.GETRANGEMIN("Workplan Code");
        IF GLBudgetName."Workplan Code" <> Rec."Workplan Code" THEN
            GLBudgetName.GET(Rec."Workplan Code");
        IF Rec.GETFILTER("Activity Code") <> '' THEN
            Rec."Activity Code" := GetFirstGLAcc(Rec.GETFILTER("Activity Code"));
        Rec.Date := GetFirstDate(Rec.GETFILTER(Date));
        Rec."User ID" := USERID;

        IF Rec.GETFILTER("Global Dimension 1 Code") <> '' THEN
            Rec."Global Dimension 1 Code" :=
              GetFirstDimValue(GLSetup."Global Dimension 1 Code", Rec.GETFILTER("Global Dimension 1 Code"));

        IF Rec.GETFILTER("Global Dimension 2 Code") <> '' THEN
            Rec."Global Dimension 2 Code" :=
              GetFirstDimValue(GLSetup."Global Dimension 2 Code", Rec.GETFILTER("Global Dimension 2 Code"));

        IF Rec.GETFILTER("Budget Dimension 1 Code") <> '' THEN
            Rec."Budget Dimension 1 Code" :=
              GetFirstDimValue(GLBudgetName."Budget Dimension 1 Code", Rec.GETFILTER("Budget Dimension 1 Code"));

        IF Rec.GETFILTER("Budget Dimension 2 Code") <> '' THEN
            Rec."Budget Dimension 2 Code" :=
              GetFirstDimValue(GLBudgetName."Budget Dimension 2 Code", Rec.GETFILTER("Budget Dimension 2 Code"));

        IF Rec.GETFILTER("Budget Dimension 3 Code") <> '' THEN
            Rec."Budget Dimension 3 Code" :=
              GetFirstDimValue(GLBudgetName."Budget Dimension 3 Code", Rec.GETFILTER("Budget Dimension 3 Code"));

        IF Rec.GETFILTER("Budget Dimension 4 Code") <> '' THEN
            Rec."Budget Dimension 4 Code" :=
              GetFirstDimValue(GLBudgetName."Budget Dimension 4 Code", Rec.GETFILTER("Budget Dimension 4 Code"));

        IF Rec.GETFILTER("Business Unit Code") <> '' THEN
            Rec."Business Unit Code" := GetFirstBusUnit(Rec.GETFILTER("Business Unit Code"));
    end;

    trigger OnOpenPage()
    var
        GLBudgetName: Record "Workplan";
    begin


        IF Rec.GETFILTER("Workplan Code") = '' THEN
            GLBudgetName.INIT
        ELSE BEGIN
            Rec.COPYFILTER("Workplan Code", GLBudgetName."Workplan Code");
            GLBudgetName.FINDFIRST;
        END;
        CurrPage.EDITABLE := NOT GLBudgetName.Blocked;
        GLSetup.GET;
        "Global Dimension 1 CodeEnable" := GLSetup."Global Dimension 1 Code" <> '';
        "Global Dimension 2 CodeEnable" := GLSetup."Global Dimension 2 Code" <> '';
        "Budget Dimension 1 CodeEnable" := GLBudgetName."Budget Dimension 1 Code" <> '';
        "Budget Dimension 2 CodeEnable" := GLBudgetName."Budget Dimension 2 Code" <> '';
        "Budget Dimension 3 CodeEnable" := GLBudgetName."Budget Dimension 3 Code" <> '';
        "Budget Dimension 4 CodeEnable" := GLBudgetName."Budget Dimension 4 Code" <> '';
        "Global Dimension 1 CodeVisible" := GLSetup."Global Dimension 1 Code" <> '';
        "Global Dimension 2 CodeVisible" := GLSetup."Global Dimension 2 Code" <> '';
        "Budget Dimension 1 CodeVisible" := GLBudgetName."Budget Dimension 1 Code" <> '';
        "Budget Dimension 2 CodeVisible" := GLBudgetName."Budget Dimension 2 Code" <> '';
        "Budget Dimension 3 CodeVisible" := GLBudgetName."Budget Dimension 3 Code" <> '';
        "Budget Dimension 4 CodeVisible" := GLBudgetName."Budget Dimension 4 Code" <> '';
    end;

    var
        GLSetup: Record "General Ledger Setup";
        GLBudgetName: Record "Workplan";
        LowestModifiedEntryNo: Integer;
        [InDataSet]
        "Global Dimension 1 CodeVisible": Boolean;
        [InDataSet]
        "Global Dimension 2 CodeVisible": Boolean;
        [InDataSet]
        "Budget Dimension 1 CodeVisible": Boolean;
        [InDataSet]
        "Budget Dimension 2 CodeVisible": Boolean;
        [InDataSet]
        "Budget Dimension 3 CodeVisible": Boolean;
        [InDataSet]
        "Budget Dimension 4 CodeVisible": Boolean;
        [InDataSet]
        "Global Dimension 1 CodeEnable": Boolean;
        [InDataSet]
        "Global Dimension 2 CodeEnable": Boolean;
        [InDataSet]
        "Budget Dimension 1 CodeEnable": Boolean;
        [InDataSet]
        "Budget Dimension 2 CodeEnable": Boolean;
        [InDataSet]
        "Budget Dimension 3 CodeEnable": Boolean;
        [InDataSet]
        "Budget Dimension 4 CodeEnable": Boolean;

    local procedure GetFirstGLAcc(GLAccFilter: Text[250]): Code[20]
    var
        GLAcc: Record "Workplan Activities";
    begin
        GLAcc.SETFILTER("Activity Code", GLAccFilter);
        IF GLAcc.FINDFIRST THEN
            EXIT(GLAcc."Activity Code");

        EXIT('');
    end;

    local procedure GetFirstDate(DateFilter: Text[250]): Date
    var
        Period: Record "Date";
    begin
        IF DateFilter = '' THEN
            EXIT(0D);
        Period.SETRANGE("Period Type", Period."Period Type"::Date);
        Period.SETFILTER("Period Start", DateFilter);
        IF Period.FINDFIRST THEN
            EXIT(Period."Period Start");

        EXIT(0D);
    end;

    local procedure GetFirstDimValue(DimCode: Code[20]; DimValFilter: Text[250]): Code[20]
    var
        DimVal: Record "Dimension Value";
    begin
        IF (DimCode = '') OR (DimValFilter = '') THEN
            EXIT('');
        DimVal.SETRANGE("Dimension Code", DimCode);
        DimVal.SETFILTER(Code, DimValFilter);
        IF DimVal.FINDFIRST THEN
            EXIT(DimVal.Code);

        EXIT('');
    end;

    local procedure GetFirstBusUnit(BusUnitFilter: Text[250]): Code[10]
    var
        BusUnit: Record "Business Unit";
    begin
        BusUnit.SETFILTER(Code, BusUnitFilter);
        IF BusUnit.FINDFIRST THEN
            EXIT(BusUnit.Code);

        EXIT('');
    end;
}

