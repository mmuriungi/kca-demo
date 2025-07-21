page 52071 "Project Milestone Card"
{
    ApplicationArea = All;
    Caption = 'Project Milestone Card';
    PageType = Card;
    SourceTable = "Project Milestone";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = IsOpen;
                field("Task No"; Rec."Task No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Descriprion; Rec.Descriprion)
                {
                    ApplicationArea = All;
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Importance; Rec.Importance)
                {
                    ApplicationArea = All;
                }
                field("Progress Level %"; Rec."Progress Level %")
                {
                    ApplicationArea = All;
                }
                field("Task Budget"; Rec."Task Budget")
                {
                    ApplicationArea = All;
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                    ApplicationArea = All;
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                    ApplicationArea = All;
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual End date"; Rec."Actual End date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        SetPageControls;
                    end;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Milestone Components")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Project Task Components";
                RunPageLink = "Project No" = FIELD("Project No"),
                              "Task No" = FIELD("Task No");
                Visible = ComponentVisible;
            }
            action(Start)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Open";

                trigger OnAction()
                begin
                    if Confirm('Do you want to start this milestone?', false) = true then begin
                        Rec."Actual Start Date" := Today;
                        Rec.Status := Rec.Status::Started;
                        Rec.Modify;
                        // ProjectTasks.Reset;
                        // ProjectTasks.SetRange("Project No", Rec."Project No");
                        // if ProjectTasks.FindFirst then begin
                        //     if ProjectTasks."Project No" = Rec."Project No" then begin
                        //         Project.Reset;
                        //         Project.SetRange("No.", Rec."Project No");
                        //         if Project.FindFirst then begin
                        //             Project."Actual Start Date" := Today;
                        //             Project.Modify;
                        //         end;
                        //     end;
                        // end;
                    end;
                end;
            }
            action(Suspend)
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Started";

                trigger OnAction()
                begin
                    if Confirm('Do you want to suspend this task?', false) = true then
                        Rec.Status := Rec.Status::Suspended;
                end;
            }
            action(Resume)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Suspended";

                trigger OnAction()
                begin
                    if Confirm('Do you want to resume this contract?', false) = true then
                        Rec.Status := Rec.Status::Started;
                end;
            }
            action(Finish)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Started";

                trigger OnAction()
                begin
                    if Confirm('Do you want to finish this contract?', false) = true then begin
                        Rec.Status := Rec.Status::Finished;
                        Rec."Actual End date" := Today;
                        Rec.Modify;
                    end;
                end;
            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Task No");
                    Rec.TestField(Descriprion);
                    Rec.TestField("Responsible Person");
                    Rec.TestField(Category);
                    Rec.TestField(Importance);
                    Rec.TestField("Task Budget");
                    if Confirm('Do you want to send this contract for approval?', false) = true then begin
                        //    IF ApprovalsMgmt.CheckProjectTaskWorkflowEnabled(Rec) THEN
                        //      ApprovalsMgmt.OnSendProjectTaskForApproval(Rec);
                    end;
                end;
            }
            action("Cancel Approval Request")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Pending Approval";

                trigger OnAction()
                begin
                    if Confirm('Do you want to cancel the approval request?', false) = true then begin
                        //    IF ApprovalsMgmt.CheckProjectTaskWorkflowEnabled(Rec) THEN
                        //    ApprovalsMgmt.OnCancelProjectTaskRequestApproval(Rec);
                    end;
                end;
            }
            action("Approval Entries")
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Pending Approval";

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    //ApprovalEntries.Setfilters(DATABASE::"Project Tasks",ApprovalEntry."Document Type"::"Project Tasks",No);
                    ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetPageControls;
    end;

    trigger OnOpenPage()
    begin
        SetPageControls;
    end;

    var
        IsStarted: Boolean;
        IsOpen: Boolean;
        IsSuspended: Boolean;
        IsFinished: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ComponentVisible: Boolean;
        Project: Record "Project";
        ProjectTasks: Record "Project Milestone";

    local procedure SetPageControls()
    begin
        IsStarted := false;
        IsSuspended := false;
        IsOpen := false;
        ComponentVisible := false;
        case Rec.Status of
            Rec.Status::Open:
                IsOpen := true;
            Rec.Status::Started:
                begin
                    IsStarted := true;
                    ComponentVisible := true;
                end;
            Rec.Status::Suspended:
                IsSuspended := true;
            Rec.Status::Finished:
                IsFinished := true;
            Rec.Status::Approved:
                ComponentVisible := true;
        end;
    end;
}

