page 52179027 "CRM Automation Rule Card"
{
    PageType = Card;
    Caption = 'Automation Rule Card';
    SourceTable = "CRM Automation Rule";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("General")
            {
                Caption = 'General';
                
                field("Rule Code"; Rec."Rule Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the automation rule code.';
                }
                field("Rule Name"; Rec."Rule Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the automation rule.';
                }
                field("Rule Type"; Rec."Rule Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of automation rule.';
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this rule is active.';
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the execution priority (1-100, 1 = highest).';
                }
            }
            
            group("Trigger")
            {
                Caption = 'Trigger Configuration';
                
                field("Trigger Event"; Rec."Trigger Event")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event that triggers this rule.';
                }
                field("Trigger Conditions"; Rec."Trigger Conditions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the conditions that must be met to trigger this rule.';
                    MultiLine = true;
                }
            }
            
            group("Action")
            {
                Caption = 'Action Configuration';
                
                field("Action Description"; Rec."Action Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Describes the action that will be performed when this rule is triggered.';
                    MultiLine = true;
                }
                field("Template Code"; Rec."Template Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the marketing template to use (for email/SMS rules).';
                }
                field("Target Field"; Rec."Target Field")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the field to update (for data update rules).';
                }
                field("Target Value"; Rec."Target Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value to set in the target field.';
                }
                field("Notification Recipients"; Rec."Notification Recipients")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who should receive notifications (for notification rules).';
                    MultiLine = true;
                }
            }
            
            group("Schedule")
            {
                Caption = 'Schedule Configuration';
                
                field("Schedule Type"; Rec."Schedule Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this rule should be executed.';
                }
                field("Schedule Time"; Rec."Schedule Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the time of day when this rule should be executed.';
                }
                field("Schedule Days"; Rec."Schedule Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies which days this rule should be executed (for weekly schedule).';
                }
                field("Next Execution"; Rec."Next Execution")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this rule will next be executed.';
                    Editable = false;
                }
            }
            
            group("Limits")
            {
                Caption = 'Execution Limits';
                
                field("Max Executions"; Rec."Max Executions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Maximum number of times this rule can be executed (0 = unlimited).';
                }
                field("Stop After Failures"; Rec."Stop After Failures")
                {
                    ApplicationArea = All;
                    ToolTip = 'Stop executing this rule after this many consecutive failures.';
                }
            }
            
            group("Statistics")
            {
                Caption = 'Execution Statistics';
                
                field("Execution Count"; Rec."Execution Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows how many times this rule has been executed.';
                    Editable = false;
                }
                field("Success Count"; Rec."Success Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the number of successful executions.';
                    Editable = false;
                }
                field("Failure Count"; Rec."Failure Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the number of failed executions.';
                    Editable = false;
                }
                field("Last Executed"; Rec."Last Executed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this rule was last executed.';
                    Editable = false;
                }
            }
            
            group("Audit")
            {
                Caption = 'Audit Information';
                
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who created this rule.';
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this rule was created.';
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who last modified this rule.';
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this rule was last modified.';
                    Editable = false;
                }
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Additional notes about this automation rule.';
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Execute Now")
            {
                ApplicationArea = All;
                Caption = 'Execute Now';
                Image = Start;
                ToolTip = 'Execute this automation rule immediately.';
                
                trigger OnAction()
                var
                    Success: Boolean;
                begin
                    if Confirm('Execute rule "%1" now?', true, Rec."Rule Name") then begin
                        Success := Rec.ExecuteRule();
                        if Success then
                            Message('Rule executed successfully.')
                        else
                            Message('Rule execution failed. Check the log for details.');
                        CurrPage.Update(false);
                    end;
                end;
            }
            
            action("Test Rule")
            {
                ApplicationArea = All;
                Caption = 'Test Rule';
                Image = TestReport;
                ToolTip = 'Test this automation rule without executing the action.';
                
                trigger OnAction()
                begin
                    Message('Rule test functionality would be implemented here.\n\nRule: %1\nConditions: %2\nAction: %3', 
                        Rec."Rule Name", Rec."Trigger Conditions", Rec."Action Description");
                end;
            }
            
            action("Reset Statistics")
            {
                ApplicationArea = All;
                Caption = 'Reset Statistics';
                Image = ClearLog;
                ToolTip = 'Reset the execution statistics for this rule.';
                
                trigger OnAction()
                begin
                    if Confirm('Reset execution statistics for rule "%1"?', true, Rec."Rule Name") then begin
                        Rec."Execution Count" := 0;
                        Rec."Success Count" := 0;
                        Rec."Failure Count" := 0;
                        Rec."Last Executed" := 0DT;
                        Rec.Modify();
                        Message('Statistics reset successfully.');
                    end;
                end;
            }
        }
    }
}