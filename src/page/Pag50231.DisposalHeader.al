page 50231 "Disposal Header"
{
    SourceTable = "Disposal Header";

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
            }
            field("Disposal Period"; Rec."Disposal Period")
            {
            }
            field(Desciption; Rec.Desciption)
            {
                Caption = 'Justification';
            }
            field(Date; Rec.Date)
            {
            }
            field(Status; Rec.Status)
            {
            }
            field(Department; Rec."Shortcut dimension 1 code")
            {
                Caption = 'Directorate';
            }
            field(County; Rec."Shortcut dimension 2 code")
            {
                Caption = 'Department';
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
            }
            field("Disposal Plan No."; Rec."Disposal Plan No.")
            {
                Visible = false;
            }
            field(Disposed; Rec.Disposed)
            {
            }
            part("Disposal Line"; "Disposal Line")
            {
                SubPageLink = "No." = FIELD("No.");
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
                Image = Aging;
                Promoted = true;

                trigger OnAction()
                begin
                    //ApprovalMgt.SendDisposalAppApprovalReq(Rec);
                    // IF ApprovalsMgmt.CheckActDisApprovalsWorkflowEnabled(Rec) THEN
                    //   ApprovalsMgmt.OnSendActDisForApproval(Rec);
                end;
            }
            action("Cancel Approval")
            {
                Caption = 'Cancel Approval';
                Image = Approve;
                Promoted = true;

                trigger OnAction()
                begin
                    //ApprovalMgt.CancelDisposalAppRequest(Rec,TRUE,TRUE);
                    // ApprovalsMgmt.OnCancelActDisForApproval(Rec);
                end;
            }
            action("Accept Disposal")
            {
                Image = Approve;
                Promoted = true;

                trigger OnAction()
                var
                    Lines: Record "Disposal Line";
                begin

                    Rec.TESTFIELD(Status, Rec.Status::Approved);
                    //IF DisposalLine.Confirmed <> TRUE THEN ERROR('Please Enter Disposed To');
                    //DisposalLine.TESTFIELD(DisposalLine."Disposed To");
                    //DisposalLine.TESTFIELD(DisposalLine."Confirmed By");

                    //IF CONFIRM('Are you sure you want to Dispose this item?')  THEN BEGIN
                    Rec."Disposal Status" := Rec."Disposal Status"::"Tender Committee";
                    //IF  DisposalLine."Disposal Methods"<>'OT' THEN
                    //ERROR('You need to send it to Tender Committee');
                    //IF "Disposal Status":="Disposal Status":: "TENDER COMMITTEE" THEN
                    Rec.Disposed := TRUE;
                    /*MESSAGE('Disposal Number %1 has been Implemented',"No.");
                  END;


                 CLEAR(OTExists);
                 TESTFIELD(Status,Status::Approved);
                 //IF CONFIRM('Are you sure you want to Dispose this item?')  THEN BEGIN
                  "Disposal Status":="Disposal Status"::"Tender Committee";
                 CLEAR(OTExists);
                 DisposalLine.RESET;
                 DisposalLine.SETRANGE(DisposalLine."Disposal No","Disposal Plan No.");
                 IF DisposalLine.FIND('-') THEN  BEGIN
                 REPEAT

                 IF  DisposalLine."Disposal Methods"='OT' THEN
                  DisposalLine.Disposed:=TRUE;
                 IF Lines.FIND('-') THEN
                  BEGIN
                    REPEAT
                   Lines.Disposed:=TRUE;
                   UNTIL Lines.NEXT=0;
                   MODIFY;
                   END;


                 OTExists:=TRUE;

                 UNTIL DisposalLine.NEXT=0;
                 END;
                  IF OTExists THEN

                 //IF  DisposalLine."Disposal Methods"<>'OT' THEN
                 //ERROR('You need to send it to Tender Committee');
                  DisposalLine.Disposed:=TRUE;
                  Disposed:=TRUE;
                   MODIFY;
                    //MESSAGE('Disposal Number %1 has been Implemented',"No.");
                   //END;

                 // dispose lines // */


                    CLEAR(OTExists);
                    DisposalLine.RESET;
                    DisposalLine.SETRANGE(DisposalLine."No.", Rec."No.");
                    IF DisposalLine.FIND('-') THEN BEGIN
                        DisposalLine.TESTFIELD(DisposalLine."Disposed To");
                        DisposalLine.TESTFIELD(DisposalLine."Confirmed By");

                        REPEAT

                            IF DisposalLine."Disposal Methods" = 'OT' THEN
                                DisposalLine.TESTFIELD(DisposalLine."Total Price");

                            OTExists := TRUE;

                        UNTIL DisposalLine.NEXT = 0;
                    END;
                    IF OTExists THEN
                        Rec."Disposal Status" := Rec."Disposal Status"::Disposed
                    ELSE
                        Rec."Disposal Status" := Rec."Disposal Status"::"Disposal implementation";
                    Rec.MODIFY;

                    //MESSAGE('Disposal Number %1 has been Send To Tender Committee"',"No.");



                    IF CONFIRM('Do you want to Dispose Lines?', TRUE) = FALSE THEN EXIT;
                    Rec.RESET;
                    Rec.SETRANGE("No.", Lines."Disposal Plan No.");
                    IF Lines.FIND('-') THEN
                        Lines.Disposed := TRUE;
                    BEGIN
                        REPEAT

                        UNTIL Lines.NEXT = 0;
                    END;
                    MESSAGE('Lines disposed Successesfully');

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
                    Rec.SETFILTER("No.", Rec."No.");
                    REPORT.RUN(70036, TRUE, TRUE, Rec);
                    Rec.RESET;
                end;
            }
        }
    }

    var
        //ApprovalsMgmt: Codeunit "Custom Approvals Codeunit";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TR,Disposal;
        DisposalHead: Record "Disposal Header";
        DisposalLine: Record "Disposal Line";
        OTExists: Boolean;
        DTExists: Boolean;

    procedure UpdateControls()
    var
        DisposalLine: Record "Disposal Line";
    begin
    end;
}

