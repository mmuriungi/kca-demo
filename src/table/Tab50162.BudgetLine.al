table 50162 "Budget Line"
{
    Caption = 'Budget Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Budget Name"; Code[20])
        {
            Caption = 'Budget Name';
            TableRelation = "G/L Budget Name";
        }
        field(4; "Budget Date"; Date)
        {
            Caption = 'Budget Date';
        }
        field(5; "Gl Account"; Code[20])
        {
            Caption = 'Gl Account';
            TableRelation = "G/L Account"."No.";
        }
        field(6; Desription; Text[250])
        {
            Caption = 'Desription';
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {

            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }

        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(10; Posted; Boolean)
        {

        }
    }
    keys
    {
        key(PK; "Entry No", "No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Name")
        {
            // Clustered = true;
        }
        key(pk2; "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Name")
        {

        }
    }
}
