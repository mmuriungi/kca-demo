page 52039 "Pending Project Tasks Card"
{
    PageType = Card;
    SourceTable = "Project Tasks";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = IsOpen;
                field("Task No"; Rec."Task No")
                {
                }
                field(Descriprion; Rec.Descriprion)
                {
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                }
                field(Category; Rec.Category)
                {
                }
                field(Importance; Rec.Importance)
                {
                }
                field("Progress Level %"; Rec."Progress Level %")
                {
                }
                field("Task Budget"; Rec."Task Budget")
                {
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    Editable = false;
                }
                field("Actual End date"; Rec."Actual End date")
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
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
            action("Task Components")
            {
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Project Task Components";
                RunPageLink = "Project No" = FIELD("Project No"),
                              "Task No" = FIELD("Task No");
                Visible = not IsOpen;
            }
            action(Start)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsOpen;

                trigger OnAction()
                begin
                    Rec.TestField("Task No");
                    Rec.TestField(Descriprion);
                    Rec.TestField("Responsible Person");
                    Rec.TestField(Category);
                    Rec.TestField(Importance);
                    Rec.TestField("Task Budget");
                    if Confirm('Do you want to start this task?', false) = true then begin
                        Rec.Status := Rec.Status::Started;
                        Rec."Actual Start Date" := Today;
                        Rec.Modify;
                    end;
                end;
            }
            action(Suspend)
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsStarted;

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
                Visible = IsSuspended;

                trigger OnAction()
                begin
                    if Confirm('Do you want to resume this project?', false) = true then
                        Rec.Status := Rec.Status::Open;
                end;
            }
            action(Finish)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsStarted;

                trigger OnAction()
                begin
                    if Confirm('Do you want to finish this project?', false) = true then begin
                        Rec.Status := Rec.Status::Finished;
                        Rec."Actual End date" := Today;
                        Rec.Modify;
                    end;
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

    local procedure SetPageControls()
    begin
        IsStarted := false;
        IsSuspended := false;
        IsOpen := false;
        case Rec.Status of
            Rec.Status::Open:
                IsOpen := true;
            Rec.Status::Started:
                IsStarted := true;
            Rec.Status::Suspended:
                IsSuspended := true;
            Rec.Status::Finished:
                IsFinished := true;

        end;
    end;
}

