table 50696 "Research Resources"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; no; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Project Code"; code[20])
        {

        }
        field(3; "Resource Description"; text[200])
        {

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