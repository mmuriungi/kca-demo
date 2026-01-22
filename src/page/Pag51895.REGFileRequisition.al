page 51895 "REG-File Requisition"
{
    PageType = Card;
    SourceTable = "REG-File Requisition";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Requesting Officer"; Rec."Requesting Officer")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Collecting Officer"; Rec."Collecting Officer")
                {
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("File No"; Rec."File No")
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("Authorized By"; Rec."Authorized By")
                {
                    ApplicationArea = All;
                }
                field("Served By"; Rec."Served By")
                {
                    ApplicationArea = All;
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
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Approvalentries: Page 658;
                begin
                    /*
                   DocumentType:=DocumentType::"Payment Voucher";
                   Approvalentries.Setfilters(DATABASE::"Payments Header",DocumentType,"No.");
                   Approvalentries.RUN;
                    */

                end;
            }
            action(sendApproval)
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit 439;
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                begin
                    /*
                    IF NOT LinesExists THEN
                       ERROR('There are no Lines created for this Document');
                          TESTFIELD(Status,Status::Pending);
                    //Ensure No Items That should be committed that are not
                    IF LinesCommitmentStatus THEN
                      ERROR('Please Check the Budget before you Proceed');
                    
                    //Release the PV for Approval
                      State:=State::Open;
                     IF Status<>Status::Pending THEN State:=State::"Pending Approval";
                     DocType:=DocType::"Payment Voucher";
                     CLEAR(tableNo);
                     tableNo:=DATABASE::"Payments Header";
                     IF ApprovalMgt.SendApproval(tableNo,Rec."No.",DocType,State) THEN;
                     */

                end;
            }
            action(cancellsApproval)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit 439;
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                begin
                    /*
                    DocType:=DocType::"Payment Voucher";
                    showmessage:=TRUE;
                    ManualCancel:=TRUE;
                    CLEAR(tableNo);
                    tableNo:=DATABASE::"Payments Header";
                     IF ApprovalMgt.CancelApproval(tableNo,DocType,Rec."No.",showmessage,ManualCancel) THEN;
                   */

                end;
            }
        }
    }
}

