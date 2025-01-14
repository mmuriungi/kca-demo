table 52178551 "Proc-Committee Members"
{
    Caption = 'Proc-Committee Members';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Ref No"; Code[50])
        {
            Editable = false;
            Caption = 'Ref No';
        }
        field(2; Committee; Option)
        {
            Caption = 'Committee';
            OptionMembers = " ",Opening,Evaluation;
        }
        field(3; "Member No"; Code[50])
        {
            Caption = 'Member No';
            TableRelation = If ("Member Type" = filter(Staff)) "HRM-Employee C"."No.";
            trigger OnValidate()
            begin
                Hremp.Reset();
                Hremp.SetRange("No.", "Member No");

            end;
        }
        field(4; Name; Text[250])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(5; Role; Option)
        {
            Caption = 'Role';
            OptionMembers = " ",Chairperson,Member,Secretary;
        }
        field(6; Email; Text[150])
        {
            Caption = 'Email';
        }
        field(7; "Phone No"; Text[14])
        {
            Caption = 'Phone No';
        }
        field(8; "Member Type"; Option)
        {
            OptionMembers = Staff,"Non Staff";
        }
        field(9; "Description Blob"; Blob)
        {
            Caption = 'Desc. Blob';
            DataClassification = ToBeClassified;
        }
        field(10; Password; Text[10])
        {

        }
    }
    keys
    {
        key(PK; "Ref No", Committee, "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Committee, Name)
        {
        }
    }

    var
        Hremp: Record "HRM-Employee C";
        Nonstaff: Record "Proc-Non Staff Committee";
}
