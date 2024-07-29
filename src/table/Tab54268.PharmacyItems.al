table 54268 "Pharmacy Items"
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
        field(3; "Unit of measure"; Code[56])
        {
            // OptionMembers = ,Tablets,Capsules,Ampoules,Vials,Creams,Rolls,PCS,Bottles,Cans,Ltrs,"100ML BOTT",PKTS,KGS,JERICAN,Tin,Lot,Booklet,Box,Ml,"500GM Tin","500GM JER",Sets,MTRS,Pairs,Dozens,Pack,Tube,Boxes;
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
        field(51; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Reorder Threshold"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "SequenceNo"; Integer)
        {
            DataClassification = ToBeClassified;
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