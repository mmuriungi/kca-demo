table 50091 "Workplan Budget Buffer"
{
    Caption = 'Workplan Budget Buffer';
    DataCaptionFields = "Code";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; "Budget Filter"; Code[70])
        {
            Caption = 'Budget Filter';
            FieldClass = FlowFilter;
            TableRelation = Workplan;
        }
        field(4; "G/L Account Filter"; Code[20])
        {
            Caption = 'G/L Account Filter';
            FieldClass = FlowFilter;
            //TableRelation = "Travel Destination";
            //ValidateTableRelation = false;
        }
        field(5; "Business Unit Filter"; Code[40])
        {
            Caption = 'Business Unit Filter';
            FieldClass = FlowFilter;
            TableRelation = "Business Unit";
        }
        field(6; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(8; "Budget Dimension 1 Filter"; Code[20])
        {
            CaptionClass = GetCaptionClass(1);
            Caption = 'Budget Dimension 1 Filter';
            FieldClass = FlowFilter;
        }
        field(9; "Budget Dimension 2 Filter"; Code[20])
        {
            CaptionClass = GetCaptionClass(2);
            Caption = 'Budget Dimension 2 Filter';
            FieldClass = FlowFilter;
        }
        field(10; "Budget Dimension 3 Filter"; Code[20])
        {
            CaptionClass = GetCaptionClass(3);
            Caption = 'Budget Dimension 3 Filter';
            FieldClass = FlowFilter;
        }
        field(11; "Budget Dimension 4 Filter"; Code[20])
        {
            CaptionClass = GetCaptionClass(4);
            Caption = 'Budget Dimension 4 Filter';
            FieldClass = FlowFilter;
        }
        field(12; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            ClosingDates = true;
            FieldClass = FlowFilter;
        }
        field(13; "Budgeted Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Workplan Entry".Amount WHERE("Workplan Code" = FIELD("Budget Filter"),
                                                             "Activity Code" = FIELD("G/L Account Filter"),
                                                             "Business Unit Code" = FIELD("Business Unit Filter"),
                                                             "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                             "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                             "Budget Dimension 1 Code" = FIELD("Budget Dimension 1 Filter"),
                                                             "Budget Dimension 2 Code" = FIELD("Budget Dimension 2 Filter"),
                                                             "Budget Dimension 3 Code" = FIELD("Budget Dimension 3 Filter"),
                                                             "Budget Dimension 4 Code" = FIELD("Budget Dimension 4 Filter"),
                                                             Date = FIELD("Date Filter")));
            Caption = 'Budgeted Amount';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label '1,6,,Budget Dimension 1 Filter';
        Text001: Label '1,6,,Budget Dimension 2 Filter';
        Text002: Label '1,6,,Budget Dimension 3 Filter';
        Text003: Label '1,6,,Budget Dimension 4 Filter';
        GLBudgetName: Record "Workplan";

    procedure GetCaptionClass(BudgetDimType: Integer): Text[250]
    begin
        IF GLBudgetName."Workplan Code" <> GETFILTER("Budget Filter") THEN
            GLBudgetName.GET(GETFILTER("Budget Filter"));
        CASE BudgetDimType OF
            1:
                BEGIN
                    IF GLBudgetName."Budget Dimension 1 Code" <> '' THEN
                        EXIT('1,6,' + GLBudgetName."Budget Dimension 1 Code")
                    ELSE
                        EXIT(Text000);
                END;
            2:
                BEGIN
                    IF GLBudgetName."Budget Dimension 2 Code" <> '' THEN
                        EXIT('1,6,' + GLBudgetName."Budget Dimension 2 Code")
                    ELSE
                        EXIT(Text001);
                END;
            3:
                BEGIN
                    IF GLBudgetName."Budget Dimension 3 Code" <> '' THEN
                        EXIT('1,6,' + GLBudgetName."Budget Dimension 3 Code")
                    ELSE
                        EXIT(Text002);
                END;
            4:
                BEGIN
                    IF GLBudgetName."Budget Dimension 4 Code" <> '' THEN
                        EXIT('1,6,' + GLBudgetName."Budget Dimension 4 Code")
                    ELSE
                        EXIT(Text003);
                END;
        END;
    end;
}

