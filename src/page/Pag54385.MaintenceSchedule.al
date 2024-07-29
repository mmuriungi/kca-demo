page 54385 "Maintence Schedule"
{
    Caption = 'Maintence Schedule';
    PageType = Card;
    SourceTable = "Maintenance Schedule";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Desciption; Rec.Desciption)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Desciption field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(Maintenance; Rec.Maintenance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maintenance field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
            group("Maintenance request")
            {

            }
            part(MSL; "Maintenance Schedule ListPart")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Maintence No." = field("No.");
                Editable = Rec.Status = Rec.Status::Open;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Populate Schedule List")
            {
                Image = GeneralPostingSetup;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    EstatesMgnt.PopulateMaintenanceRequest(Rec."No.");
                end;
            }
            action("Maintence Schedule Lines")
            {
                Image = LinesFromJob;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                RunObject = page "Maintenance Schedule Lines";
                RunPageLink = "Request No." = field("No.");
            }
            action(Approvals)
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                RunObject = page "Approval Entries";
                RunPageLink = "Document No." = field("No.");
                Visible = not (Rec.Status = Rec.Status::Open);
            }
            action("Request Approval")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                begin
                    If ApprovalsMgmt.CheckMaintenceSchedulesWorkflowEnable(Rec) then
                        ApprovalsMgmt.OnSendMaintenceScheduleForApproval(Rec);
                end;
            }
            action("Approve")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                begin
                    rec.Status := rec.Status::Approved;
                    // If ApprovalsMgmt.CheckMaintenceSchedulesWorkflowEnable(Rec) then
                    //     ApprovalsMgmt.OnSendMaintenceScheduleForApproval(Rec);
                end;
            }
            action("Cancel Approval")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = CancelApprovalRequest;
                Visible = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelMaintenceScheduleForApproval(Rec);
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = ReOpen;
                Visible = (Rec.Status = Rec.Status::Cancelled);

                trigger OnAction()
                var
                    SuccessMsg: Label 'The Document has been re-openned successfully';
                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    Message(SuccessMsg);
                    CurrPage.Update();
                end;
            }
            action("Send Notifications")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                RunObject = page "Approval Entries";
                // Visible = Rec.Status = Rec.Status::Approved;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    EstatesMgnt.NotifyOfficers(Rec."No.");
                end;

            }

        }
    }
    var
        ApprovalsMgmt: Codeunit "Approval Mgnt. Util.";
        EstatesMgnt: Codeunit "Estates Management";


}
