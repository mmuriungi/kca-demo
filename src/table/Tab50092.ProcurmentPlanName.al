table 50092 "Procurment Plan Name"
{
    Caption = 'G/L Budget Name';
    LookupPageID = 121;

    fields
    {
        field(1; Name; Code[30])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(3; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(4; "Budget Dimension 1 Code"; Code[20])
        {
            Caption = 'Budget Dimension 1 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF "Budget Dimension 1 Code" <> xRec."Budget Dimension 1 Code" THEN
                    IF Dim.CheckIfDimUsed("Budget Dimension 1 Code", 9, Name, '', 0) THEN
                        ERROR(Text000, Dim.GetCheckDimErr);
            end;
        }
        field(5; "Budget Dimension 2 Code"; Code[20])
        {
            Caption = 'Budget Dimension 2 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF "Budget Dimension 2 Code" <> xRec."Budget Dimension 2 Code" THEN
                    IF Dim.CheckIfDimUsed("Budget Dimension 2 Code", 10, Name, '', 0) THEN
                        ERROR(Text000, Dim.GetCheckDimErr);
            end;
        }
        field(6; "Budget Dimension 3 Code"; Code[20])
        {
            Caption = 'Budget Dimension 3 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF "Budget Dimension 3 Code" <> xRec."Budget Dimension 3 Code" THEN
                    IF Dim.CheckIfDimUsed("Budget Dimension 3 Code", 11, Name, '', 0) THEN
                        ERROR(Text000, Dim.GetCheckDimErr);
            end;
        }
        field(7; "Budget Dimension 4 Code"; Code[20])
        {
            Caption = 'Budget Dimension 4 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF "Budget Dimension 4 Code" <> xRec."Budget Dimension 4 Code" THEN
                    IF Dim.CheckIfDimUsed("Budget Dimension 4 Code", 12, Name, '', 0) THEN
                        ERROR(Text000, Dim.GetCheckDimErr);
            end;
        }
    }

    keys
    {
        key(Key1; Name)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        GLBudgetEntry: Record "G/L Budget Entry";
        AnalysisViewBudgetEntry: Record "Analysis View Budget Entry";
    begin
        GLBudgetEntry.SETCURRENTKEY("Budget Name");
        GLBudgetEntry.SETRANGE("Budget Name", Name);
        GLBudgetEntry.DELETEALL(TRUE);

        AnalysisViewBudgetEntry.SETRANGE("Budget Name", Name);
        AnalysisViewBudgetEntry.DELETEALL(TRUE);
    end;

    trigger OnModify()
    begin
        IF ("Budget Dimension 1 Code" <> xRec."Budget Dimension 1 Code") OR
           ("Budget Dimension 2 Code" <> xRec."Budget Dimension 2 Code") OR
           ("Budget Dimension 3 Code" <> xRec."Budget Dimension 3 Code") OR
           ("Budget Dimension 4 Code" <> xRec."Budget Dimension 4 Code")
        THEN
            UpdateGLBudgetEntryDim;
    end;

    var
        Text000: Label '%1\You cannot use the same dimension twice in the same budget.';
        Text001: Label 'Updating budget entries @1@@@@@@@@@@@@@@@@@@';
        Dim: Record "Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;

    procedure UpdateGLBudgetEntryDim()
    var
        GLBudgetEntry: Record "Workplan Entry";
        Window: Dialog;
        TotalCount: Integer;
        i: Integer;
        T0: Time;
    begin

        GLBudgetEntry.SETCURRENTKEY("Workplan Code");
        GLBudgetEntry.SETRANGE("Workplan Code", Name);
        //GLBudgetEntry.SETFILTER("Dimension Set ID",'<>%1',0);
        TotalCount := COUNT;
        Window.OPEN(Text001);
        T0 := TIME;
        GLBudgetEntry.LOCKTABLE;
        IF GLBudgetEntry.FINDSET THEN
            REPEAT
                i := i + 1;
                IF TIME > T0 + 750 THEN BEGIN
                    Window.UPDATE(1, 10000 * i DIV TotalCount);
                    T0 := TIME;
                END;
                //GLBudgetEntry."Budget Dimension 1 Code" := GetDimValCode(GLBudgetEntry."Dimension Set ID", "Budget Dimension 1 Code");
                //GLBudgetEntry."Budget Dimension 2 Code" := GetDimValCode(GLBudgetEntry."Dimension Set ID", "Budget Dimension 2 Code");
                //GLBudgetEntry."Budget Dimension 3 Code" := GetDimValCode(GLBudgetEntry."Dimension Set ID", "Budget Dimension 3 Code");
                //GLBudgetEntry."Budget Dimension 4 Code" := GetDimValCode(GLBudgetEntry."Dimension Set ID", "Budget Dimension 4 Code");
                GLBudgetEntry.MODIFY;
            UNTIL GLBudgetEntry.NEXT = 0;
        Window.CLOSE;
    end;

    local procedure GetDimValCode(DimSetID: Integer; DimCode: Code[20]): Code[20]
    begin
        IF DimCode = '' THEN
            EXIT('');
        IF TempDimSetEntry.GET(DimSetID, DimCode) THEN
            EXIT(TempDimSetEntry."Dimension Value Code");
        IF DimSetEntry.GET(DimSetID, DimCode) THEN
            TempDimSetEntry := DimSetEntry
        ELSE BEGIN
            TempDimSetEntry.INIT;
            TempDimSetEntry."Dimension Set ID" := DimSetID;
            TempDimSetEntry."Dimension Code" := DimCode;
        END;
        TempDimSetEntry.INSERT;
        EXIT(TempDimSetEntry."Dimension Value Code")
    end;
}

