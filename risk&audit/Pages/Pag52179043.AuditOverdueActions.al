page 52179043 "Audit Overdue Actions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Audit Action Tracking";
    Caption = 'Overdue Audit Actions';
    CardPageId = "Audit Action Tracking Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Action No."; Rec."Action No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the action number.';
                }
                field("Finding No."; Rec."Finding No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related finding number.';
                }
                field("Action Description"; Rec."Action Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the action description.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsible person.';
                }
                field("Target Date"; Rec."Target Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target completion date.';
                }
                field("Days Overdue"; Rec."Days Overdue")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of days overdue.';
                }
                field("Implementation Status"; Rec."Implementation Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the implementation status.';
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                }
            }
        }
    }



    actions
    {
        area(Processing)
        {
            action("Send Reminder")
            {
                ApplicationArea = All;
                Caption = 'Send Reminder';
                Image = SendMail;
                ToolTip = 'Send a reminder to the responsible person.';

                trigger OnAction()
                begin
                    Rec."Reminder Count" := Rec."Reminder Count" + 1;
                    Rec."Last Reminder Date" := Today;
                    Rec.Modify();
                    Message('Reminder sent for action %1', Rec."Action No.");
                    CurrPage.Update();
                end;
            }
            action("Escalate Action")
            {
                ApplicationArea = All;
                Caption = 'Escalate Action';
                Image = Escalate;
                ToolTip = 'Escalate this overdue action.';

                trigger OnAction()
                begin
                    Rec.Escalated := true;
                    Rec."Escalation Date" := Today;
                    Rec.Modify();
                    Message('Action %1 has been escalated.', Rec."Action No.");
                    CurrPage.Update();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Target Date", '<%1', Today);
        Rec.SetFilter("Implementation Status", '<>%1', Rec."Implementation Status"::"Fully Implemented");
    end;
}