table 55706 "WEL-Financial Aid"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;

        }
        field(2; "Admission No"; code[50])
        {
            TableRelation = Customer."No." where("Customer Posting Group" = filter('STUDENT'));
            trigger OnValidate()
            begin
                rec.reset;
                if Rec.get() then
                    "Full Name" := cust.Name;
                "ID No" := cust."ID No";
                Email := cust."E-Mail";
            end;
        }
        field(3; "Full Name"; text[50])
        {

        }

        field(4; Status; code[20])
        {

        }
        field(5; "ID No"; code[10])
        {

        }
        field(6; "Email"; code[50])
        {

        }
        field(7; Description; text[250])
        {

        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        cust: Record Customer;

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