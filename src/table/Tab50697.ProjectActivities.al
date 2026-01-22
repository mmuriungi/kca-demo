table 50697 "Project Activities"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; no; Integer)
        {
            AutoIncrement = true;


        }
        field(2; "Project Code"; code[20])
        {

        }
        field(3; "Project Activity"; text[200])
        {

        }
        field(4; Status; Option)
        {
            OptionMembers = Active,Completed;
        }
    }


    keys
    {
        key(Key1; no, "Project Code")
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