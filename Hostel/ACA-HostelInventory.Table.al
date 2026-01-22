#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 61630 "ACA-Hostel Inventory"
{
    DrillDownPageID = "ACA-Hostel Invtry Items List";
    LookupPageID = "ACA-Hostel Invtry Items List";

    fields
    {
        field(1; Item; Code[30])
        {
            TableRelation = Item."No.";
        }
        field(2; Description; Text[150])
        {
            CalcFormula = lookup(Item.Description where("No." = field(Item)));
            FieldClass = FlowField;
        }
        field(3; "Quantity Per Room"; Integer)
        {

            trigger OnValidate()
            begin
                "Bill Total" := "Fine Amount" * "Quantity Per Room";
            end;
        }
        field(4; "Applies To"; Option)
        {
            OptionCaption = 'Individual,Room';
            OptionMembers = Individual,Room;
        }
        field(5; "Hostel Gender"; Option)
        {
            OptionCaption = 'Both,Male,Female';
            OptionMembers = Both,Male,Female;
        }
        field(6; "Fine Amount"; Decimal)
        {
        }
        field(7; "Bill Total"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bill Total" := "Fine Amount" * "Quantity Per Room";
                Modify;
            end;
        }
        field(8; "All Rooms"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Item)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Quantity Per Room" := 1;
    end;

    trigger OnModify()
    begin
        Validate("Fine Amount");
    end;
}

