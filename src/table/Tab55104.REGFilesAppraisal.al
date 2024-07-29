table 55104 "REG-Files Appraisal"
{
    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "File Index"; Code[50])
        {

        }
        field(3; "File Name"; Text[150])
        {

        }
        field(4; Region; Code[20])
        {

        }

        field(5; "Region Name"; Text[50])
        {

        }
        field(6; Volume; Text[20])
        {

        }
        field(7; Code; Code[50])
        {

        }
    }

    keys
    {
        key(Key1; "No.", "File Index", Region, Code)
        {
            Clustered = true;
        }
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