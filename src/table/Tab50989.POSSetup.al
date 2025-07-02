table 50989 "POS Setup Legacy"
{
    DrillDownPageId = "POS Setup";
    LookupPageId = "POS Setup";
    fields
    {
        field(1; "Primary Key"; code[20])
        {
        }
        field(2; "Receipt No."; code[30])
        {
            TableRelation = "No. Series";
        }
        field(3; "Students Cashbook"; code[20])
        {
            TableRelation = "Bank Account";
        }
        field(4; "Students Sales Account"; code[30])
        {
            TableRelation = "G/L Account";
        }
        field(5; "Pos Items Series"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(6; "Sales No."; code[30])
        {
            TableRelation = "No. Series";
        }
        field(7; "Staff Cashbook"; code[20])
        {
            TableRelation = "Bank Account";
        }
        field(8; "Staff Sales Account"; code[30])
        {
            TableRelation = "G/L Account";
        }
        field(9; "Stock Adjustment"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(10; "Department Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            trigger OnValidate()
            var
                Department: Record "Dimension Value";
            begin
                Department.Reset();
                Department.SetRange("Global Dimension No.", 2);
                Department.SetRange(Code, "Department Code");
                if Department.FindFirst() then
                    "Department Name" := Department.Name;
            end;
        }
        field(11; "Department Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Journal Template Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
    }
}