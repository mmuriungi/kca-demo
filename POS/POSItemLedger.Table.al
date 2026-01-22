#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 99403 "POS Item Ledger"
{
    DrillDownPageID = "POS Item Ledger";
    LookupPageID = "POS Item Ledger";

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Item No."; Code[20])
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; "Entry Type"; Option)
        {
            OptionCaption = 'Food Upload,Positive Adjmt.,Negative Adjmt.,Consumption';
            OptionMembers = "Food Upload","Positive Adjmt.","Negative Adjmt.",Consumption;
        }
        field(5; "Document No."; Code[20])
        {
        }
        field(6; Description; Text[30])
        {
        }
        field(7; Quantity; Decimal)
        {
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; "Spill Over"; Boolean)
        {
        }
        field(10; "User ID"; Code[30])
        {
        }
        field(11; Location; Code[30])
        {
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if UserId <> 'KUCSERVER\ASIMBA' then Error('Cancelled');
    end;

    trigger OnInsert()
    begin
        "User ID" := UserId;
    end;

    var


    procedure GetLastEntryNo(): Integer
    begin
    end;
}

