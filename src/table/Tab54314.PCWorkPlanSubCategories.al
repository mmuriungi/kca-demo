table 54314 "PC WorkPlan Sub Categories"
{
    Caption = 'PC WorkPlan Sub Categories';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(4; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            DataClassification = ToBeClassified;
        }
        field(5; "Category Description"; Text[250])
        {
            Caption = 'Category Description';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; "Quarter Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Quarter Achievement"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Quarter Cummulative"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Quarter Remarks"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
