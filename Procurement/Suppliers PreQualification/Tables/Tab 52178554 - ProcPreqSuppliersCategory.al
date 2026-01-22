table 52178554 "Proc-Preq. Suppliers/Category"
{
    DrillDownPageID = "Proc-Preq. Suppliers/Category";
    LookupPageID = "Proc-Preq. Suppliers/Category";

    fields
    {
        field(1; "Preq. Year"; Code[20])
        {
            TableRelation = "Proc-Prequalification Years"."Preq. Year";
        }
        field(2; "Preq. Category"; Code[100])
        {
            TableRelation = "Proc-Prequalif. Categories"."Category Code";
        }
        field(3; "Supplier_Code"; Code[20])
        {
            TableRelation = Vendor."No." WHERE("Vendor Posting Group" = FILTER('TRADE'));

            trigger OnValidate()
            begin
                Vendor.RESET;
                Vendor.SETRANGE("No.", "Supplier_Code");
                IF Vendor.FIND('-') THEN BEGIN
                    Phone := Vendor.Contact;
                    Email := Vendor."E-Mail";
                END;
            end;
        }
        field(4; "Supplier Name"; Text[150])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Supplier_Code")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(5; Phone; Text[100])
        {
            CalcFormula = Lookup(Vendor.Contact WHERE("No." = FIELD("Supplier_Code")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(6; Email; Text[250])
        {
            CalcFormula = Lookup(Vendor."E-Mail" WHERE("No." = FIELD("Supplier_Code")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(7; "RQS Placed"; Integer)
        {
        }
        field(8; "Quotes Received"; Integer)
        {
        }
        field(9; "LPOs Placed"; Integer)
        {
        }
        field(10; "Phone 2"; Text[100])
        {
            CalcFormula = Lookup(Vendor."Telephone 2" WHERE("No." = FIELD("Supplier_Code")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(11; "Email 2"; Text[150])
        {
            CalcFormula = Lookup(Vendor."Email 2" WHERE("No." = FIELD("Supplier_Code")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(12; "Agpo Categorization"; Code[50])
        {
            TableRelation = "Proc-Target Groups"."Code";
            CalcFormula = Lookup(Vendor."Vendor Categorization" WHERE("No." = FIELD("Supplier_Code")));
            FieldClass = FlowField;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Preq. Year", "Preq. Category", "Supplier_Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Vendor: Record Vendor;
}

