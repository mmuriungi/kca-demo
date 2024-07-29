table 52032 "Extension Services"
{
    Caption = 'Extension Services';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; code[20])
        {
            Caption = '';
        }
        field(2; "Service Requested"; Text[200])
        {

        }
        field(3; "Requested Staff ID"; code[20])
        {
            TableRelation = "HRM-Employee C";
        }
        field(4; "Requested Date"; Date)
        {

        }
        field(5; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Pending,Approved,Closed,Cancelled,Rejected,Completed,Scheduled;
        }
        field(6; Department; code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
        field(7; Faculty; code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('FACULTY'));
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
