page 53124 "CAT-Meal Booking Approved"
{
    Editable = false;
    PageType = Card;
    SourceTable = "CAT-Meal Booking Header";
    SourceTableView = WHERE(Status = FILTER(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Booking Id"; Rec."Booking Id")
                {
                }
                field(Department; Rec.Department)
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Booking Date"; Rec."Booking Date")
                {
                }
                field("Booking Time"; Rec."Booking Time")
                {
                }
                field("Meeting Name"; Rec."Meeting Name")
                {
                    Caption = 'Description of Meeting';
                }
                field("Required Time"; Rec."Required Time")
                {
                }
                field(Venue; Rec.Venue)
                {
                }
                field("Contact Person"; Rec."Contact Person")
                {
                }
                field("Contact Number"; Rec."Contact Number")
                {
                }
                field("Contact Mail"; Rec."Contact Mail")
                {
                }
                field(Pax; Rec.Pax)
                {
                    Caption = 'Number of People';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Requested By"; Rec."Requested By")
                {
                    Editable = false;
                }
                field("No. Series"; Rec."No. Series")
                {
                    Editable = false;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    Editable = false;
                }
            }
            group(Details)
            {
                Caption = 'Details';
                part("ACA-Meal Booking Lines"; "ACA-Meal Booking Lines")
                {
                    SubPageLink = "Booking Id" = FIELD("Booking Id");
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    DocumentType := DocumentType::"Meals Bookings";
                    // ApprovalEntries.Setfilters(DATABASE::"CAT-Meal Booking Header",DocumentType,Rec."Booking Id");
                    // ApprovalEntries.RUN;
                end;
            }
            action("Print Form")
            {
                Caption = 'Print Form';
                Image = PrintReport;
                Promoted = true;

                trigger OnAction()
                begin
                    //IF NOT (Status=Status::Approved) THEN ERROR('You can only print a fully approved Meals Requisition.');

                    Rec.RESET;
                    Rec.SETFILTER("Booking Id", Rec."Booking Id");
                    REPORT.RUN(69271, TRUE, TRUE, Rec);
                    Rec.RESET;
                end;
            }
            action("Post Meal Requisition")
            {
                Caption = 'Post Meal Requisition';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF CONFIRM('Post meal requisition?', TRUE) = FALSE THEN ERROR('Cancelled by user!');
                end;
            }
            action("Cancel Document")
            {
                Caption = 'Cancel Document';
                Image = DocumentEdit;

                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure you want to cancel the Document?', TRUE) THEN Rec.Status := Rec.Status::Cancelled;
                end;
            }
        }
    }

    var
        // UserMgt: Codeunit "50114";
        // ApprovalMgt: Codeunit "439";
        // InventorySetup: Record "313";
        // GenJnline: Record "83";
        // LineNo: Integer;
        // Post: Boolean;
        // JournlPosted: Codeunit "50113";
        // HasLines: Boolean;
        // AllKeyFieldsEntered: Boolean;
        // FixedAsset: Record "5600";
        // ApprovalEntries: Page "658";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
        RelNoEditable: Boolean;
        RelNameEditable: Boolean;
        EmpNameEditable: Boolean;
        LeaveTypeEditable: Boolean;
        respCenter: Code[10];
}

