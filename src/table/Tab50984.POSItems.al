table 50984 "POS Items Legacy"
{
    LookupPageId = "POS Items Legacy";
    DrillDownPageId = "POS Items Legacy";
    fields
    {
        field(1; "No."; Code[30])
        {

        }
        field(2; "Description"; Text[100])
        {

        }
        field(3; "Unit of measure"; Code[20])
        {
            TableRelation = "Pos Unit of Measure".Code where("Item Code" = field("No."));
        }
        field(4; Inventory; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("POS Item Ledger".Quantity where("Item No." = field("No.")));
        }
        field(6; "Serving Category"; Option)
        {
            OptionMembers = Student,staff;
        }
        field(7; "Date filter"; date)
        {

        }
        field(8; "Sales Amount"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("POS Sales Lines"."Line Total" where("No." = field("No."), "Posting Date" = field("Date filter")));
        }
        field(9; "Sold Units"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("POS Item Ledger".Quantity where("Item No." = field("No."), "Entry Type" = filter("Negative Adjmt."), "Posting Date" = field("Date filter")));
        }
        field(50; "No. Series"; code[30])
        {

        }
        field(51; "Cleared Stock"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("POS Item Ledger".Quantity where("Item No." = field("No."), "Entry Type" = filter('Stock Clearance')));
        }
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            PosSetup.GET;
            PosSetup.TESTFIELD(PosSetup."Pos Items Series");
            NoSeriesMgt.InitSeries(PosSetup."Pos Items Series", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    var
        PosSetup: Record "POS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}