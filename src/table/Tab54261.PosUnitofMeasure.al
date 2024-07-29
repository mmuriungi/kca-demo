table 54261 "Pos Unit of Measure"
{
    DrillDownPageId = "Pos Unit of measure";
    LookupPageId = "Pos Unit of measure";
    fields
    {
        field(1; "Item Code"; code[100])
        {
            TableRelation = "POS Items";
        }
        field(3; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Student Price"; Decimal)
        {

        }
        field(6; "Staff Price"; Decimal)
        {

        }

    }

    keys
    {
        key(key1; "Item Code", code)
        {

        }
    }
}