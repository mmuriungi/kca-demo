tableextension 50002 "GenJournalLine Ext" extends "Gen. Journal Line"
{
    fields
    {
        // Add changes to table fields here
        field(56601; "Transaction Type"; Option)
        {

            OptionMembers = ,Cafeteria;
        }
        field(56602; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(56603; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56604; "Recovery Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(56605; Payee; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(56606; "Shortcut Dimension 3 code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(56607; "Shortcut Dimension 4 code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(56608; "Vendor Transaction Type"; Enum "Vendor Transaction Type")
        {
            DataClassification = ToBeClassified;
        }
    }



    var
        myInt: Integer;
}