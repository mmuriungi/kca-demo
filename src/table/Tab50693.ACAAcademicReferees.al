table 50693 "ACA-Academic Referees"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;

        }
        field(2; Names; Text[200])
        {


        }
        field(3; "Institution"; code[100])
        {

        }
        field(4; "Mobile No"; code[20])
        {

        }
        field(5; "Designition"; Text[50])
        {

        }
        field(7; ApplicationNo; code[20])
        {

        }
    }

    keys
    {
        key(Key1; No)
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