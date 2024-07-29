table 54353 "Hostel Sub-Store"
{
    Caption = 'Hostel Sub-Store';
    DrillDownPageId = "Hostel sub-store items";
    LookupPageId = "Hostel sub-store items";
    fields
    {
        field(1; "No."; Code[30])
        {
        }
        field(2; "Description"; Text[100])
        {
        }
        field(3; "Unit of measure"; Option)
        {
            OptionMembers = ,Rolls,PCS,Bottles,Cans,Ltrs,"100ML BOTT",PKTS,KGS,JERICAN,Tin,Lot,Booklet,Box,Ml,"500GM Tin","500GM JER",Sets,MTRS,Pairs,Dozens,Pack,Tube,Boxes;
        }
        field(4; Inventory; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Hostel Ledger Entries ".Quantity where("Item No." = field("No.")));
        }
        field(6; "Item Category"; Option)
        {
            OptionMembers = Consumeables,"Non-Consumeables",assets;
        }
        field(50; "No. Series"; code[30])
        {
        }
    }
    var

        HMSSetup: Record "HMS-Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        IF HMSSetup.GET THEN BEGIN
            HMSSetup.TESTFIELD("Pharmacy Items Nos");
            "No." := NoSeriesManagement.GetNextNo(HMSSetup."Pharmacy Items Nos", TODAY, TRUE);
        end;

    End;
}
