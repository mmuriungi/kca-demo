table 51272 "Project Payment Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Header No"; code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Payment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Payment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Invoice Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Invoice No."; code[25])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Line No", "Header No")
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