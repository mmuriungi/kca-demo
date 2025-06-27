page 51277 "CAT-Meal Booking List"
{
    CardPageID = "CAT-Meal Booking Header";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "CAT-Meal Booking Header";

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
                field("Meeting Name"; Rec."Meeting Name")
                {
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
            action("Release")
            {
                Caption = 'Release';
                Image = Release;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify;
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Approval Entries";
                RunPageLink = "Document No." = field("Booking Id");

            }
            action(sendApproval)
            {
                Caption = 'Send A&pproval Request';
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
                begin
                    Rec.TESTFIELD(Department);
                    Rec.TESTFIELD("Request Date");
                    Rec.TESTFIELD("Booking Date");
                    Rec.TESTFIELD("Meeting Name");
                    Rec.TESTFIELD("Required Time");
                    Rec.TESTFIELD(Venue);
                    Rec.TESTFIELD("Contact Person");
                    Rec.TESTFIELD("Contact Number");
                    Rec.TESTFIELD(Pax);

                    // IF "Availlable Days"<1 THEN ERROR('Please note that you dont have enough leave balance');

                    //Release the Bookingfor Approval
                    State := State::Open;
                    IF Rec.Status <> Rec.Status::New THEN State := State::"Pending Approval";
                    DocType := DocType::"Meals Bookings";
                    CLEAR(tableNo);
                    tableNo := 61778;
                    CLEAR(RespCenter);
                    //  IF ApprovalMgt.SendApproval(tableNo,Rec."Booking Id",DocType,State,RespCenter,0) THEN;
                    //  IF ApprovalMgt.SendLeaveApprovalRequest(Rec) THEN;
                end;
            }
            action(cancellsApproval)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    //ApprovalMgt: Codeunit "439";
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                begin
                    DocType := DocType::"Meals Bookings";
                    showmessage := TRUE;
                    ManualCancel := TRUE;
                    CLEAR(tableNo);
                    tableNo := 61778;
                    //   IF ApprovalMgt.CancelApproval(tableNo,DocType,Rec."Booking Id",showmessage,ManualCancel) THEN;

                    // IF ApprovalMgt.CancelLeaveApprovalRequest(Rec,TRUE,TRUE) THEN;
                end;
            }
            separator(try1)
            {
            }
            action("Print Form")
            {
                Caption = 'Print Form';
                Image = PrintReport;
                Promoted = true;

                trigger OnAction()
                begin
                    IF NOT (Rec.Status = Rec.Status::Approved) THEN ERROR('You can only print a fully approved Meals Requisition.');

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
                Visible = false;

                trigger OnAction()
                begin
                    IF CONFIRM('Post meal requisition?', TRUE) = FALSE THEN ERROR('Cancelled by user!');
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
        RespCenter: Code[10];
}

