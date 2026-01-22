table 51058 "Hostel Items"
{
    DrillDownPageId = "Pharmacy Items";
    LookupPageId = "Pharmacy Items";
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
            OptionMembers = ,Rolls,PCS,Bottles,Cans,Ltrs,PKTS,KGS,JERICAN,Box,Sets,MTRS,Pairs,Pack,Boxes;
        }
        field(4; Inventory; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Pharmacy Item Ledger".Quantity where("Item No." = field("No.")));
        }
        field(6; "Drug Category"; Option)
        {
            OptionMembers = Pharmacitical,"Non-Pharmaciticals","Lab Reagents";
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
        // IF HMSSetup.GET THEN BEGIN
        //     HMSSetup.TESTFIELD("Pharmacy Items Nos");
        //     "No." := NoSeriesManagement.GetNextNo(HMSSetup."Pharmacy Items Nos", TODAY, TRUE);
        // end;

    End;
}