page 53119 "Venue Booking Allocated"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Gen-Venue Booking";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Booking Id"; Rec."Booking Id")
                {
                }
                field(Venue; Rec.Venue)
                {
                }
                field("Venue Dscription"; Rec."Venue Dscription")
                {
                    Enabled = false;
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
                field("Meeting Description"; Rec."Meeting Description")
                {
                    Caption = 'Description of Meeting';
                }
                field("Required Time"; Rec."Required Time")
                {
                }
                field("Booking End Date"; Rec."Booking End Date")
                {
                }
                field("Booking End Time"; Rec."Booking End Time")
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
        }
    }

    actions
    {
        area(creation)
        {
            action("Print Form")
            {
                Caption = 'Print Form';
                Image = PrintReport;
                Promoted = true;

                trigger OnAction()
                begin

                    Rec.RESET;
                    Rec.SETFILTER("Booking Id", Rec."Booking Id");
                    REPORT.RUN(77706, TRUE, TRUE, Rec);
                    Rec.RESET;
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
        GenVenueBooking: Record "Gen-Venue Booking";
}

