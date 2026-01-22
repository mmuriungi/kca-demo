page 52179033 "Audit Schedule Calendar"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Audit Schedule";
    Caption = 'Audit Schedule Calendar';
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                }
                field("Audit No."; Rec."Audit No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the audit number.';
                }
                field("Task Description"; Rec."Task Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the task description.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date.';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start time.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the end date.';
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the end time.';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the task is assigned to.';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                }
                field("Task Type"; Rec."Task Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the task type.';
                }
                field("Estimated Hours"; Rec."Estimated Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated hours.';
                }
                field("Actual Hours"; Rec."Actual Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual hours.';
                }
                field("Completion %"; Rec."Completion %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the completion percentage.';
                }
                field("Location"; Rec."Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("New Task")
            {
                ApplicationArea = All;
                Caption = 'New Task';
                Image = New;
                ToolTip = 'Create a new scheduled task.';
                
                trigger OnAction()
                var
                    AuditSchedule: Record "Audit Schedule";
                begin
                    AuditSchedule.Init();
                    AuditSchedule."Start Date" := Today;
                    AuditSchedule."End Date" := Today;
                    AuditSchedule.Insert(true);
                    CurrPage.Update();
                end;
            }
            action("Mark Complete")
            {
                ApplicationArea = All;
                Caption = 'Mark Complete';
                Image = Completed;
                ToolTip = 'Mark the selected task as completed.';
                
                trigger OnAction()
                begin
                    if Rec."Status" <> Rec."Status"::Completed then begin
                        Rec."Status" := Rec."Status"::Completed;
                        Rec."Completion %" := 100;
                        Rec.Modify();
                        CurrPage.Update();
                    end;
                end;
            }
            action("View by Auditor")
            {
                ApplicationArea = All;
                Caption = 'View by Auditor';
                Image = PersonInCharge;
                ToolTip = 'Filter schedule by assigned auditor.';
                
                trigger OnAction()
                begin
                    Message('Enter auditor filter in the filter pane above the list.');
                end;
            }
            action("View by Date")
            {
                ApplicationArea = All;
                Caption = 'View by Date Range';
                Image = DateRange;
                ToolTip = 'Filter schedule by date range.';
                
                trigger OnAction()
                begin
                    Message('Use the filter pane to set date range filters.');
                end;
            }
        }
        area(Navigation)
        {
            action("Related Audit")
            {
                ApplicationArea = All;
                Caption = 'Related Audit';
                Image = Navigate;
                ToolTip = 'Open the related audit record.';
                
                trigger OnAction()
                var
                    AuditHeader: Record "Audit Header";
                begin
                    if AuditHeader.Get(Rec."Audit No.") then
                        Page.Run(Page::"Audit Card", AuditHeader);
                end;
            }
        }
        area(Reporting)
        {
            action("Schedule Report")
            {
                ApplicationArea = All;
                Caption = 'Print Schedule';
                Image = Print;
                ToolTip = 'Print the audit schedule report.';
                
                trigger OnAction()
                begin
                    Message('Schedule report will be implemented.');
                end;
            }
        }
    }
}