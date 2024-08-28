page 51276 "CAT-Meal Booking Header"
{
    PageType = Card;
    SourceTable = "CAT-Meal Booking Header";

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
                    Editable = true;
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
                field(Commited; Rec.Commited)
                {
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                }
                field("Actual Expenditure"; Rec."Actual Expenditure")
                {
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                }
                field("Budget Balance"; Rec."Budget Balance")
                {
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
        area(Processing)
        {
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;
                RunObject = Page "Approval Entries";
                RunPageLink = "Document No." = field("Booking Id");
            }
            action(sendApproval)
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
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
                    if ApprovalMgt.IsMealBookingEnabled(Rec) = true then
                        ApprovalMgt.OnSendMealBookingforApproval(Rec)
                    else
                        Error('Check your workflow');

                end;
            }
            action(cancellsApproval)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin

                    if ApprovalMgt.IsMealBookingEnabled(Rec) = true then
                        ApprovalMgt.OnCancelMealBookingforApproval(Rec)
                    else
                        Error('Check your workflow');
                end;
            }
            separator(g12)
            {
            }
            action("Print Form")
            {
                Caption = 'Print Form';
                Image = PrintReport;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;

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
                ApplicationArea = All;
                PromotedCategory = Process;

                Visible = false;

                trigger OnAction()
                begin
                    IF CONFIRM('Post meal requisition?', TRUE) = FALSE THEN ERROR('Cancelled by user!');
                end;
            }
            action("Check Budget Availlabilty")
            {
                Caption = 'Check Budget Availlabilty';
                Image = Check;
                Promoted = true;

                trigger OnAction()
                begin
                    BCSetup.GET;
                    IF NOT BCSetup.Mandatory THEN
                        EXIT;
                    //IF ("Issuing Store"<>'MAIN') AND ("Issuing Store"<>'GENERAL') THEN ERROR('This function is only applicable to Central Stores')
                    ;
                    //IF Status=Status::Released THEN
                    //  ERROR('This document has already been released. This functionality is available for open documents only');
                    //IF NOT SomeLinesCommitted THEN BEGIN
                    //   IF NOT CONFIRM( 'Some or All the Lines Are already Committed do you want to continue',TRUE, "Document Type") THEN
                    //        ERROR('Budget Availability Check and Commitment Aborted');
                    DeleteCommitment.RESET;
                    DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::Meal);
                    DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", Rec."Booking Id");
                    DeleteCommitment.DELETEALL;
                    //END;

                    //IF "Requisition Type"="Requisition Type"::Stationery THEN

                    // Commitment.CheckMeal(Rec);
                    // ELSE
                    // ERROR('Please note that only Stationery Items are voted');

                    Rec.Commited := TRUE;
                    Rec.MODIFY;
                    MESSAGE('Budget Availability Checking Complete');
                end;
            }
            separator(g3)
            {
            }
            action("Cancel Budget Commitments")
            {
                Caption = 'Cancel Budget Commitments';
                Image = CancelLine;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Commited);
                    IF NOT CONFIRM('Are you sure you want to Cancel All Commitments Done for this document', TRUE) THEN
                        ERROR('Budget Availability Check and Commitment Aborted');

                    DeleteCommitment.RESET;
                    DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::Meal);
                    DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", Rec."Booking Id");
                    DeleteCommitment.DELETEALL;
                    //Tag all the SRN entries as Uncommitted
                    Rec.Commited := FALSE;
                    Rec.MODIFY;
                    MESSAGE('Commitments Cancelled Successfully for Doc. No %1', Rec."Booking Id");
                end;
            }
        }
    }

    var
        UserMgt: Codeunit "User Setup Management BR";
        //   ApprovalMgt: Codeunit "Approvals Mgmt.";
        InventorySetup: Record "Inventory Setup";
        GenJnline: Record "Item Journal Line";
        LineNo: Integer;
        Post: Boolean;
        JournlPosted: Codeunit "Journal Post Successful";
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        FixedAsset: Record "Fixed Asset";
        ApprovalEntries: Page "Approval Entries";
        ApprovalMgt: Codeunit "Workflow Initialization";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
        RelNoEditable: Boolean;
        RelNameEditable: Boolean;
        EmpNameEditable: Boolean;
        LeaveTypeEditable: Boolean;
        respCenter: Code[10];
        ReqLine: Record "CAT-Meal Booking Lines";
        //  MinorAssetsIssue: Record "FIN-Minor Ass. Issue & Returns";
        Commitment: Codeunit "Budgetary Control";
        BCSetup: Record "FIN-Budgetary Control Setup";
        DeleteCommitment: Record "FIN-Committment";
        Loc: Record "Location";
}

