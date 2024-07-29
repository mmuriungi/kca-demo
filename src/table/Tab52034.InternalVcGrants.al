table 52034 "Internal Vc Grants"
{
    Caption = 'Internal Vc Grants';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            //Caption = '';
        }
        field(2; "Date Requested"; Date)
        {

        }
        field(3; "PF No."; code[20])
        {
            TableRelation = "HRM-Employee (D)";
        }
        field(4; "Name of Researcher"; Text[200])
        {

        }
        field(5; Department; code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
        field(6; Faculty; code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('FACULTY'));
        }
        field(7; Status; Option)
        {
            OptionMembers = Open,Pending,Approved,Closed,Cancelled,Rejected,Completed,Scheduled;
        }
        field(8; "Research Title"; Text[200])
        {

        }
        field(9; "Description"; Text[200])
        {
            
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
