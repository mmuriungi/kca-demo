page 51281 "Venue Booking Header"
{
    PageType = Card;
    SourceTable = "Gen-Venue Booking";
    PromotedActionCategories = 'New,Process,Report,Approval';

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
                    MultiLine = true;
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
            action(sendApproval)
            {
                Caption = 'Submit Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approval Workflows V1";
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                    variant: Variant;
                begin
                    Rec.TESTFIELD(Department);
                    Rec.TESTFIELD("Request Date");
                    Rec.TESTFIELD("Booking Date");
                    Rec.TESTFIELD("Meeting Description");
                    Rec.TESTFIELD("Required Time");
                    Rec.TESTFIELD(Venue);
                    Rec.TESTFIELD("Contact Person");
                    Rec.TESTFIELD("Contact Number");
                    Rec.TESTFIELD(Pax);
                    variant := Rec;
                    if ApprovalMgt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovalMgt.OnSendDocForApproval(variant);

                    CurrPage.UPDATE;
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Enabled = Rec.Status = Rec.Status::"Pending Approval";

                trigger OnAction()
                var
                    variant: Variant;
                    ApprovalMgt: Codeunit "Approval Workflows V1";
                begin
                    variant := Rec;
                    if ApprovalMgt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovalMgt.OnCancelDocApprovalRequest(variant);

                    CurrPage.UPDATE;
                end;
            }
            separator(fre)
            {
            }
            action("Print Form")
            {
                Caption = 'Print Form';
                Image = PrintReport;
                Promoted = true;

                trigger OnAction()
                begin

                    GenVenueBooking.RESET;
                    GenVenueBooking.SETFILTER(GenVenueBooking."Booking Id", Rec."Booking Id");
                    IF GenVenueBooking.FIND('-') THEN
                        REPORT.RUN(77706, TRUE, TRUE, Rec);
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
    //  ApprovalsMgtNotification: Codeunit "440";
}

