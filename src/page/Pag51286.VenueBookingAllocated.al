page 51286 "Venue Booking - Allocated"
{
    CardPageID = "Venue Booking Allocated";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Gen-Venue Booking";
    SourceTableView = WHERE(Status = FILTER(Approved));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Booking Id"; Rec."Booking Id")
                {
                }
                field(Department; Rec.Department)
                {
                }
                field("Department Name"; Rec."Department Name")
                {
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
                }
                field(Status; Rec.Status)
                {
                }
                field("Requested By"; Rec."Requested By")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("Total Cost"; Rec."Total Cost")
                {
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
                Caption = 'Mark as Allocated';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    // ApprovalMgt: Codeunit "439";
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                //   ApprovalsMgtNotification: Codeunit "440";
                begin
                    Rec.TESTFIELD(Department);
                    Rec.TESTFIELD("Request Date");
                    Rec.TESTFIELD("Booking Date");
                    Rec.TESTFIELD("Meeting Description");
                    Rec.TESTFIELD("Required Time");
                    Rec.TESTFIELD("Booking End Date");
                    Rec.TESTFIELD("Booking End Time");
                    Rec.TESTFIELD(Venue);
                    Rec.TESTFIELD("Contact Person");
                    Rec.TESTFIELD("Contact Number");
                    Rec.TESTFIELD(Pax);

                    IF CONFIRM('Confirm Request', TRUE) = FALSE THEN ERROR('Cancelled by user!');
                    Rec.Status := Rec.Status::Approved;
                    Rec.MODIFY;
                    //  ApprovalsMgtNotification.SendVenueApprovedlMail(Rec."Booking Id",'VENUE BOOKING',Rec."Contact Mail",Rec."Contact Person");
                    MESSAGE('Approved!');
                    CurrPage.UPDATE;
                end;
            }
            separator(dre)
            {
            }
            action("Print Form")
            {
                Caption = 'Print Form';
                Image = PrintReport;
                Promoted = true;

                trigger OnAction()
                begin

                    Rec.RESET;
                    Rec.SETFILTER("Booking Id", Rec."Booking Id");
                    REPORT.RUN(77707, TRUE, TRUE, Rec);
                    Rec.RESET;
                end;
            }
            action("Allocation Schedule")
            {
                Caption = 'Allocation Schedule';
                Image = AmountByPeriod;
                Promoted = true;
                PromotedIsBig = true;
                //  RunObject = Report "Allocations Per Venue & Date";
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
        RespCenter: Code[10];
}

