table 52015 "RegProcessApprovalEntry"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; entry; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; studNo; code[20])
        {

        }
        field(3; Semester; code[20])
        {

        }
        field(4; "Approval Status"; Option)
        {
            OptionMembers = Submitted,Resubmitted,Approved,Rejected;
        }
        field(5; "Rejection Reason"; Text[300])
        {

        }
        field(6; "Programe"; code[20])
        {

        }
        field(7; stage; code[20])
        {

        }
        field(9; "Programme Description"; text[100])
        {

        }
    }

    keys
    {
        key(Key1; entry, studNo, Semester)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}