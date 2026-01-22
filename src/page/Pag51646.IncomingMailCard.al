page 51646 "Incoming Mail Card"
{
    PageType = Card;
    SourceTable = "Incoming Mail";
    layout
    {
        area(content)
        {
            group("General Mail Info")
            {
                field("Ref No"; Rec."Ref No")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = all;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Assing User"; Rec."Assing User")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(status; Rec.status)
                {
                    ApplicationArea = all;
                }

            }
            label("Mail Subject")
            {
                ApplicationArea = All;
                Style = Strong;
                MultiLine = true;

            }
            group(MS)
            {
                ShowCaption = false;
                field("Mail &Subject"; Rec."Mail Subject")
                {
                    ShowCaption = false;
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
            label("Mail Content")
            {
                ApplicationArea = All;
                Style = Strong;
            }
            group(MC)
            {
                ShowCaption = false;
                field("Mail &Content"; Rec."Mail Content")
                {
                    ShowCaption = false;
                    ApplicationArea = all;
                    MultiLine = true;
                }
            }
            label(Comments)
            {
                ApplicationArea = All;
                Style = Strong;
            }
            group("1st Comment")
            {
                ShowCaption = false;
                field("1st &Comment"; Rec."1st Comment")
                {
                    ApplicationArea = all;
                    ShowCaption = false;
                    MultiLine = true;
                }
            }
            part(MA; "Mail Actors")
            {
                ApplicationArea = All;
                SubPageLink = "Mail Code" = field("Ref No");
                Visible = IsApproved;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Request Approval")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Enabled = IsOpen;

                trigger OnAction()
                begin
                    //If ApprovalsMgmt.CheckIncomingMailApprovalsWorkflowEnable(Rec) = true then
                    //ApprovalsMgmt.OnSendIncomingMailForApproval(Rec);
                end;
            }
            action("Cancel Approval")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = CancelApprovalRequest;
                Enabled = not IsOpen;

                trigger OnAction()
                begin
                    //ApprovalsMgmt.OnCancelIncomingMailForApproval(Rec);
                end;
            }
            action("Re-Open Mail")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = ReOpen;
                Visible = IsApproved;

                trigger OnAction()
                var
                    SuccessLbl: Label 'Mail %1 has been re-openned successfully';
                begin
                    Rec.status := Rec.status::Open;
                    Rec.Modify();
                    CurrPage.Update();
                    Message(SuccessLbl, Rec."Ref No");
                end;
            }
            action("Notify Actors")
            {
                ApplicationArea = All;
                Image = NewOpportunity;
                Promoted = true;
                PromotedCategory = Process;
                Visible = IsApproved;
                trigger OnAction()
                var
                    hrmEmp: Record "HRM-Employee C";
                begin
                    //CommonMgnt.NotifyMailActor(Rec);
                    // hrmEmp.Reset();
                    // hrmEmp.SetRange("No.", Rec."Assing User");
                    // if hrmEmp.Find('-') then begin
                    //     "E-Mail" := hrmEmp."Company E-Mail";
                    //     UserId := hrmEmp."User ID";
                    //     Name := hrmEmp."First Name" + ' ' + hrmEmp."Middle Name" + ' ' + hrmEmp."Last Name";
                    //     Send();
                    // end;
                end;
            }
            action(Approvals)
            {

                ApplicationArea = All;
                Caption = 'Approvals';
                Image = Approvals;
                Enabled = not IsOpen;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Approval Entries";
                RunPageLink = "Document No." = field("Ref No");
            }
            action(Sharepoint)
            {
                ApplicationArea = all;

                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    DMS.Reset;
                    DMS.SetRange("Document Type", DMS."Document Type"::"Incoming Mail");
                    if DMS.Find('-') then begin
                        Hyperlink(DMS."url" + Rec."Ref No")
                    end else
                        Message('No Link ' + format(DMS."Document Type"::"Incoming Mail"))
                end;
            }

        }

    }
    trigger OnOpenPage()
    begin
        SetPageControls();
    end;

    trigger OnInit()
    begin
        SetPageControls();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        SetPageControls();
    end;

    trigger OnInsertRecord(NewRec: Boolean): Boolean
    begin
        SetPageControls();
    end;

    procedure SetPageControls()
    begin
        if Rec.status = Rec.status::Approved then
            IsApproved := true else
            IsApproved := false;
        if Rec.status = Rec.status::Open then
            IsOpen := true else
            IsOpen := false;
    end;

    var
        DMS: Record "EDMS Setups";
        //ApprovalsMgmt: CodeUnit "Approval Management";
        IsOpen, IsApproved : Boolean;
    //CommonMgnt: Codeunit "Common App Management";
}
