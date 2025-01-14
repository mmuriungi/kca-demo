page 51285 "Venue Booking - Pending Alloc."
{
    CardPageID = "Venue Booking Allocate";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Gen-Venue Booking";
    SourceTableView = WHERE(Status = FILTER("Pending Approval"));

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
                field("Venue Dscription"; Rec."Venue Dscription")
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
                    // ApprovalsMgtNotification: Codeunit "440";
                    VenueSetup: Record "Venue Setup";
                    VenueBookingPermissions: Record "Venue Booking Permissions";
                begin
                    VenueBookingPermissions.RESET;
                    VenueBookingPermissions.SETRANGE("User Id", USERID);
                    IF VenueBookingPermissions.FIND('-') THEN BEGIN
                        VenueBookingPermissions.TESTFIELD("Can Approve Booking");
                    END ELSE
                        ERROR('Access Denied!');

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
                    //Update Room Statatus
                    Rec.CALCFIELDS("Department Name", "Venue Dscription");
                    VenueSetup.RESET;
                    VenueSetup.SETRANGE("Venue Code", Rec.Venue);
                    IF VenueSetup.FIND('-') THEN BEGIN
                        VenueSetup."Book Id" := Rec."Booking Id";
                        VenueSetup."Booked From Date" := Rec."Request Date";
                        VenueSetup."Booked To Date" := Rec."Booking End Date";
                        VenueSetup."Booked From Time" := Rec."Required Time";
                        VenueSetup."Booked To Time" := Rec."Booking End Time";
                        VenueSetup."Booked Department" := Rec.Department;
                        VenueSetup."Booked Department Name" := Rec."Department Name";
                        VenueSetup."Booked By Name" := Rec."Contact Person";
                        VenueSetup.Status := VenueSetup.Status::Occupied;
                        VenueSetup."Booked By Phone" := Rec."Contact Number";
                        VenueSetup.MODIFY;
                    END;
                    //  ApprovalsMgtNotification.SendVenueApprovedlMail(Rec."Booking Id",'VENUE BOOKING',Rec."Contact Mail",Rec."Contact Person");
                    CurrPage.UPDATE;
                    MESSAGE('Approved!');
                end;
            }
            separator(erwe)
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
                //   RunObject = Report 77707;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER(Status, '%1', Rec.Status::"Pending Approval");
    end;

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

