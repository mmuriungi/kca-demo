table 50137 "Proc-Committee Members"
{
    DrillDownPageId = "Proc-Committee Members";
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
            OptionCaption = '" ",Opening,Evaluation,"Inspection & Acceptance",Project Implementation Committee';
            OptionMembers = " ",Opening,Evaluation,"Inspection & Acceptance",PIC;
        }
        field(3; "Member No"; Code[50])
        {
            Caption = 'Member No';
            TableRelation = if ("Member Type" = filter(Staff)) "HRM-Employee C"."No." where(Status = filter(Active)) else
            if ("Member Type" = filter("Non Staff")) "Proc-Non Staff Committee".No;
            trigger OnValidate()
            begin
                Hremp.Reset();
                Hremp.SetRange("No.", "Member No");
                if Hremp.Find('-') then begin
                    Name := Hremp."First Name" + ' ' + Hremp."Middle Name" + ' ' + Hremp."Last Name";
                    Email := Hremp."Company E-Mail";
                    "Phone No" := Hremp."Work Phone Number";
                    // "Phone No" := Hremp."Phone Number";
                end;
                Nonstaff.Reset();
                Nonstaff.SetRange(No, "Member No");
                if Nonstaff.Find('-') then begin
                    Name := Nonstaff.Name;
                    Email := Nonstaff.Email;
                    "Phone No" := Nonstaff.Phone;
                end;
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
