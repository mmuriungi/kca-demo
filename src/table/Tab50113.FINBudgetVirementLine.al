table 50113 "FIN-Budget Virement Line"
{
    Caption = 'FIN-Budget Virement Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; "Budget Name"; Code[20])
        {
            Caption = 'Budget Name';
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account From';
            TableRelation = "G/L Budget Entry"."G/L Account No." where("Budget Name" = field("Budget Name"), "Global Dimension 1 Code" = field("ShortCut Dimension 1"), "Global Dimension 2 Code" = field("ShortCut Dimension 2"));
        }
        field(5; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(6; "ShortCut Dimension 1"; Code[20])
        {

            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "ShortCut Dimension 2"; Code[20])
        {

            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(8; "ShortCut Dimension 3"; Code[20])
        {
            Caption = 'ShortCut Dimension 3';
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(10; "G/L Account To"; code[20])
        {

        }
        field(11; "Amount Remaining"; Decimal)
        {

        }
    }
    keys
    {
        key(PK; No, "Budget Name", "ShortCut Dimension 1", "ShortCut Dimension 2")
        {
            Clustered = true;
        }
    }
}
