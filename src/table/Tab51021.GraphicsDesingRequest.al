table 51021 "Graphics Desing Request"
{
    Caption = 'Graphics Desing Request';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Desing Req Code"; Code[20])
        {

        }
        field(2; "Requestor Staff ID"; Code[20])
        {

        }
        field(3; "User Id"; code[20])
        {

        }
        field(4; "Request Date"; Date)
        {

        }
        field(5; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Pending,Approved,Closed,Cancelled,Rejected,Completed,Scheduled;
        }
        field(6; "Requestor Name"; Text[200])
        {

        }
        field(7; "Desinger Allocated"; code[20])
        {
            TableRelation = "HRM-Employee C";
        }
        field(8; "Desinger Names"; text[200])
        {
            TableRelation = "HRM-Employee C";
        }
    }
    keys
    {
        key(PK; "Desing Req Code")
        {
            Clustered = true;
        }
    }
}
