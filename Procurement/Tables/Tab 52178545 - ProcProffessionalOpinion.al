table 52178545 "Proc Proffessional Opinion"
{
    DrillDownPageId = "PROC Proff Opinion.Quote";
    LookupPageId = "PROC Proff Opinion.Quote";

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
                Bidders: Record "Tender Applicants Registration";
                phead: Record "Purchase Header";
            begin
                phead.Reset();
                phead.SetRange("No.", rec."Recommended for Award");
                if phead.Find('-') then begin
                    "Bidder/Supplier" := phead."Buy-from Vendor No.";
                    name := phead."Pay-to Name";
                end;
                Bidders.Reset();
                Bidders.SetRange("No.", rec."Recommended for Award");
                if Bidders.Find('-') then begin
                    "Bidder/Supplier" := Bidders."No.";
                    name := Bidders.Name;
                end;

            end;
        }
        field(7; "Bidder/Supplier"; Code[30])
        {

        }
        field(8; "name"; Text[100])
        {


        }
        field(9; "Proffessional Opinion"; Text[2000])
        {

        }
        field(10; "Issue Order"; Boolean)
        {

        }

        field(11; "Status"; Option)
        {
            OptionMembers = Open,"Pending Approval",Released,Rejected;
        }

        field(12; "Created By"; Code[30])
        {

        }
        field(13; "Date Created"; date)
        {

        }
        field(14; "Order No."; Code[30])
        {

        }
        field(15; "Submitted By"; Code[30])
        {

        }
        field(16; "Date Submitted"; date)
        {

        }
        field(17; "Accounting Officer"; Code[30])
        {

        }
        field(18; "Post Qual Minutes"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Proc-Post Qualification"."No." where("No." = field("No.")));
        }
        field(19; "Opening Minutes"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Proc-Opening Minutes"."Minutes No" where("No." = field("No.")));
        }
        field(20; "Intention to Award"; Boolean)
        {

        }

    }
}