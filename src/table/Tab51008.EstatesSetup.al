table 51008 "Estates Setup"
{
    Caption = 'Estates Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            Caption = 'Primary Key';
        }
        field(2; "Repair No."; Code[20])
        {
            Caption = 'Repair No.';
            TableRelation = "No. Series";
        }
        field(3; "Maintenance No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(4; "Maintenance Request No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5; "Maintenance Schedule Subject"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Maintenance Schedule Link"; Text[500])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ChangeMsg: Label 'Are you sure you want to change the link?';
                CantModErr: Label 'Remains unmodified!';
            begin
                if xRec."Maintenance Schedule Link" <> Rec."Maintenance Schedule Link" then
                    if not Confirm(ChangeMsg) then
                        Error(CantModErr);
            end;
        }
        field(7; "Bill No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(8; "Project No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
