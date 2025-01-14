#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51259 "Student Funding Categories"
{

    fields
    {
        field(1; "Category Code"; Code[20])
        {
        }
        field(2; "Funding Sources"; Integer)
        {
            CalcFormula = count("Category Funding Sources" where("Category Code" = field("Category Code")));
            Caption = 'Funding Sources';
            FieldClass = FlowField;
        }
        field(3; "Total Funding Amount"; Decimal)
        {
            CalcFormula = sum("Category Funding Sources"."Funding %" where("Category Code" = field("Category Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Category Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

