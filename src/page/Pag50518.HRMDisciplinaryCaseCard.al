page 50518 "HRM-Disciplinary Case Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Case Status,Show';
    SourceTable = "HRM-Disciplinary Cases (B)";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Case Number"; Rec."Case Number")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field("Date of Complaint"; Rec."Date of Complaint")
                {
                    Editable = false;
                }
                field("Accused Employee"; Rec."Accused Employee")
                {
                }
                field("Accused Employee Name"; Rec."Accused Employee Name")
                {
                    Editable = false;
                }
                field("Type Complaint"; Rec."Type Complaint")
                {
                }
                field("Description of Complaint"; Rec."Description of Complaint")
                {
                    MultiLine = true;
                }
                field("Severity Of the Complain"; Rec."Severity Of the Complain")
                {
                }
                field("Date of Complaint was Reported"; Rec."Date of Complaint was Reported")
                {
                }
                field("Accussed By"; Rec."Accussed By")
                {
                }
                field(Accuser; Rec.Accuser)
                {
                }
                field("Accuser Name"; Rec."Accuser Name")
                {
                    Editable = false;
                }
                field("Non Employee Name"; Rec."Non Employee Name")
                {
                }
                field("Witness #1"; Rec."Witness #1")
                {
                }
                field("Witness #1 Name"; Rec."Witness #1 Name")
                {
                    Editable = false;
                }
                field("Witness #2"; Rec."Witness #2")
                {
                }
                field("Witness #2  Name"; Rec."Witness #2  Name")
                {
                    Editable = false;
                }
                field("Date To Discuss Case"; Rec."Date To Discuss Case")
                {
                }
                field("Body Handling The Complaint"; Rec."Body Handling The Complaint")
                {
                }
                field("Mode of Lodging the Complaint"; Rec."Mode of Lodging the Complaint")
                {
                }
                field("Policy Guidlines In Effect"; Rec."Policy Guidlines In Effect")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field("Recommended Action"; Rec."Recommended Action")
                {
                    Editable = RecommendedActionEditable;
                }
                field("Disciplinary Stage Status"; Rec."Disciplinary Stage Status")
                {
                }
                field(Appealed; Rec.Appealed)
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            group("Action Information")
            {
                Caption = 'Action Information';
                field("Action Taken"; Rec."Action Taken")
                {
                    Editable = true;
                }
                field("Disciplinary Remarks"; Rec."Disciplinary Remarks")
                {
                    Editable = true;
                    MultiLine = true;
                }
                field("Investigation Findings"; Rec.Comments)
                {
                    MultiLine = true;
                }
            }
        }
        area(factboxes)
        {
            part("HR Disciplinary Cases Factbox"; "HRM-Disciplinary Cases Factbox")
            {
                Caption = 'HR Disciplinary Cases Factbox';
                SubPageLink = "Case Number" = FIELD("Case Number");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Send Case Approval Request")
                {
                    Caption = 'Send Case Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Send this Case for Approval ?', true) = false then exit;
                        //AppMgmt.SendDisciplinaryApprovalReq(Rec);
                    end;
                }
                action("Cancel Case Approval Request")
                {
                    Caption = 'Cancel Case Approval Request';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm('Cancel Case Approval Request?', true) = false then exit;
                        //AppMgmt.CancelDiscipplinaryAppApprovalReq(Rec,TRUE,TRUE);
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Disciplinary Approvals";
                        ApprovalEntries: Page "HR-Approval Entries";
                    begin
                        DocumentType := DocumentType::"Disciplinary Approvals";
                        ApprovalEntries.Setfilters(DATABASE::"HRM-Disciplinary Cases (B)", DocumentType, Rec."Case Number");
                        ApprovalEntries.Run;
                    end;
                }
            }
            group("Case Status")
            {
                action("Under Investigation")
                {
                    Caption = 'Under Investigation';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Investigation " then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::Inprogress then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::Closed then exit;
                        // IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"Under review" THEN EXIT;


                        if Confirm('Are you sure you want to mark this case as "Under Investigation"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::"Investigation ";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as under "Investigation"', Rec."Case Number");
                        end;
                    end;
                }
                action("In Progress")
                {
                    Caption = 'In Progress';
                    Image = CarryOutActionMessage;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);


                        //IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"Investigation " THEN EXIT;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::Inprogress then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::Closed then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Under review" then exit;


                        if Confirm('Are you sure you want to open Investigations for these Case?') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::Inprogress;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "In Progress"', Rec."Case Number");
                        end;
                    end;
                }
                action(Close)
                {
                    Caption = ' Close';
                    Image = Closed;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);


                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Investigation " then exit;
                        // IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::"InProgress" THEN EXIT;
                        //  IF "Disciplinary Stage Status" ="Disciplinary Stage Status"::Closed THEN EXIT;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Under review" then exit;


                        if Confirm('Are you sure you want to mark this case as "Closed"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::Closed;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "Closed"', Rec."Case Number");
                        end;
                    end;
                }
                action(Appeal)
                {
                    Caption = ' Appeal';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        if Rec.Appealed = true then begin
                            Error('A case can only be Appealed once');
                        end;

                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Investigation " then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::Inprogress then exit;
                        if Rec."Disciplinary Stage Status" = Rec."Disciplinary Stage Status"::"Under review" then exit;


                        if Confirm('Are you sure you want to mark this case as "Under Review?"') then begin
                            Rec."Disciplinary Stage Status" := Rec."Disciplinary Stage Status"::"Under review";
                            Rec.Appealed := true;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "Under Review"', Rec."Case Number");
                        end;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        RecommendedActionEditable := true;
        ActionTakenEditable := true;
        DisciplinaryRemarksEditable := true;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        HRDisciplinary: Record "HRM-Disciplinary Cases (B)";
        //todo  AppMgmt: Codeunit "Approvals Management";
        "Document Type": Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Leave Journal","Medical Claims","Activity Approval","Disciplinary Approvals";
        RecommendedActionEditable: Boolean;
        ActionTakenEditable: Boolean;
        DisciplinaryRemarksEditable: Boolean;

    procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::New then begin
            RecommendedActionEditable := false;
            ActionTakenEditable := false;
            DisciplinaryRemarksEditable := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            CurrPage.Editable := false;
        end;

        if Rec.Status = Rec.Status::"Pending Approval" then begin
            CurrPage.Editable := false;
        end;
    end;
}

