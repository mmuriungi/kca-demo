table 50056 "PROC-Store Issue Line"
{

    fields
    {
        field(1; "No."; Integer)
        {
        }
        field(2; "Requisition No."; Code[10])
        {
        }
        field(3; "Type"; Option)
        {
            OptionMembers = Item,"G/L Account","Fixed Asset";
        }
        field(4; "Type No."; Code[10])
        {
        }
        field(5; Description; Text[50])
        {
        }
        field(11; "Total Cost"; Decimal)
        {
        }
        field(6; Qty; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Cost" := "Unit Direct Cost" * Qty;
            end;
        }
        field(9; "Unit Direct Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Cost" := "Unit Direct Cost" * Qty;
            end;
        }
        field(7; "Unit of Measure"; Code[10])
        {
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("Type No."))
            ELSE
            IF (Type = CONST("G/L Account")) "Unit of Measure".Code
            ELSE
            IF (Type = CONST("Fixed Asset")) "Unit of Measure".Code;
        }
        field(8; "Units per Unit of Measure"; Decimal)
        {
        }

        field(10; "Total Units to Issue"; Decimal)
        {
        }

        field(12; Remarks; Text[50])
        {
        }
        field(13; "Total Units Requested"; Decimal)
        {
        }
        field(14; Location; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(15; "Gen. Prod Posting"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(16; Vote; Code[20])
        {
            TableRelation = "G/L Account"."No." WHERE("Budget Controlled" = CONST(true));
        }
        field(17; "Vote Balance"; Decimal)
        {
        }
        field(18; "Action Type"; Option)
        {
            OptionMembers = Issue,Ignore;
        }
    }

    keys
    {
        key(Key1; "No.", "Requisition No.", Type, "Type No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

