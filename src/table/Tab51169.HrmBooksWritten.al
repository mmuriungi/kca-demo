table 51169 "Hrm-Books Written"
{
    Caption = 'Hrm-Books Written';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; BookCode; Code[30])
        {
            Caption = 'BookCode';
        }
        field(2; "Book Title"; Text[40])
        {
            Caption = 'Book Title';
        }
        field(3; "No Of Book  Chapters"; Code[10])
        {
            Caption = 'No Of Book  Chapters';
        }
        field(4; "Employee No."; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";
        }
    }
    keys
    {
        key(PK; BookCode)
        {
            Clustered = true;
        }
    }
}
