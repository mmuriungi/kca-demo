table 51206 "REG-Offices"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;

        }
        field(2; Region; Code[100])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('Region'));
        }
        field(5; Department; Code[100])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('Department'));
        }
        field(3; Division; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Office"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
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