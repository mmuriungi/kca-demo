table 50050 "Automated Notification Setup"
{
    Caption = 'Automated Notification Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[25])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';
        }
        field(3; "Notification Message"; Text[2048])
        {
            Caption = 'Notification Message';
        }
        field(4; Frequency; Option)
        {
            Caption = 'Frequency';
            OptionMembers = " ",Daily,Weekly,Monthly,Quarterly,Yearly;
        }
        field(5; "Notification Type"; Enum "Notification Type")
        {
        }
        field(6; "Subject"; Code[150])
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
