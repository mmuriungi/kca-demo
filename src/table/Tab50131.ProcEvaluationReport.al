table 50131 "Proc Evaluation Report"
{
    DrillDownPageId = "Evaluation Report";
    LookupPageId = "Evaluation Report";

    fields
    {
        field(1; "No."; Code[30])
        {

        }
        field(2; "Closing Date"; DateTime)
        {

        }
        field(3; "Openning Date"; DateTime)
        {

        }
        field(4; "Requisition No."; Code[30])
        {
            TableRelation = "Purchase Header"."No." where("Document Type" = filter(Quote), DocApprovalType = filter(Requisition), Status = filter(Released));

        }
        field(5; "Procurement Methods"; Enum "Proc-Procurement Methods")
        {

        }
        field(6; "Recommended for Award"; Code[30])
        {
            TableRelation = "Purchase Header"."No." where("Request for Quote No." = field("No."), "Quote Status" = filter("Fin Qualif" | "Recommended Award"));
            trigger OnValidate()
            var
                phead: Record "Purchase Header";
            begin
                phead.Reset();
                phead.SetRange("No.", rec."Recommended for Award");
                if phead.Find('-') then begin
                    "Bidder/Supplier" := phead."Buy-from Vendor No.";
                    name := phead."Pay-to Name";


                end;

            end;
        }
        field(7; "Bidder/Supplier"; Code[30])
        {

        }
        field(8; "name"; Text[100])
        {
        }
        field(9; "Confirmed"; Boolean)
        {

        }
    }
}