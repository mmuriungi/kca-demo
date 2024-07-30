page 50228 "Disposal Plan"
{
    SourceTable = "Disposal Plan Table Header";

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
            }
            field("Disposal Year"; Rec."Disposal Year")
            {
            }
            field(Description; Rec.Description)
            {
                Caption = 'Justification';
            }
            field("Disposal Description"; Rec."Disposal Description")
            {
                Visible = false;
            }
            field(Date; Rec.Date)
            {
            }
            field("Planned Date"; Rec."Planned Date")
            {
            }
            field(Status; Rec.Status)
            {
            }
            field(Department; Rec."Shortcut dimension 1 code")
            {
                Caption = 'Region';
            }
            field(County; Rec."Shortcut dimension 2 code")
            {
                Caption = 'Department';
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
            }
            part("Disposal Plan Table Line"; "Disposal Plan Table Line")
            {
                SubPageLink = "Ref. No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Caption = 'Send For Approval';

                trigger OnAction()
                begin
                    //ApprovalMgt.SendDisposalPlanAppApprovalReq(Rec);
                    // IF ApprovalsMgmt.CheckDisplanApprovalsWorkflowEnabled(Rec) THEN
                    //   ApprovalsMgmt.OnSendDisplanForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';

                trigger OnAction()
                begin
                    //ApprovalMgt.CancelDisposalPlanAppRequest(Rec,TRUE,TRUE);
                    // ApprovalsMgmt.OnCancelDisplanForApproval(Rec);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender",JV,"Employee Requisition","Leave Application","Training Requisition","Transport Requisition","Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer,Contract,Project;
                begin
                    DocType := DocType::Disposal;
                    ApprovalEntries.SetRecordFilters(DATABASE::"Disposal Plan Table Header", DocType, Rec."No.");
                    ApprovalEntries.RUN;
                end;
            }
            action(Print)
            {

                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETFILTER("No.", Rec."Ref No");
                    REPORT.RUN(39005926, TRUE, TRUE, Rec);
                    Rec.RESET;
                end;
            }
        }
    }

    var
        //ApprovalsMgmt: Codeunit "Custom Approvals Codeunit";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imp,Requisition,ImpSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Disposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer,Contract,Project,MR,Inves,PB,Prom,Ind,Conf,BSC,OT,Jobsucc,SuccDetails,Qualified,Disc;
}

