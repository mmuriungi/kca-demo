table 50115 "Asset Movement Ledgers"
{
    Caption = 'Asset Movement Ledgers';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(2; "FA No"; Code[20])
        {
            Caption = 'FA No';
        }
        field(3; "FA Posting Group"; Code[20])
        {
            Caption = 'FA Posting Group';
        }
        field(4; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(5; "Current User"; Code[20])
        {
            Caption = 'Current User';
        }
        field(6; "New User"; Code[20])
        {
            Caption = 'New User';
        }
        field(7; "Current Location"; Code[20])
        {
            Caption = 'Current Location';
        }
        field(8; "New Location"; Code[20])
        {
            Caption = 'New Location';
        }
        field(9; "Reason 1 For Transfer"; Text[250])
        {
            Caption = 'Reason 1 For Transfer';
        }
        field(10; "Reason 2 For Transfer"; Text[250])
        {
            Caption = 'Reason 2 For Transfer';
        }
        field(11; Approver; Code[20])
        {
            Caption = 'Approver';
        }
        field(12; "Document Nos"; Code[20])
        {
            Caption = 'Document Nos';
        }
        field(14; "Asset description"; Text[250])
        {
            Caption = 'Asset description';
        }
        field(15; Reversed; Boolean)
        {
            Caption = 'Reversed';
        }
        field(16; "Current Department "; code[20])
        {
            Caption = 'Current Department';
        }
        field(17; "New Department "; code[20])
        {
            Caption = 'New Department';
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
