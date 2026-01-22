page 52179026 "CRM Automation Rules"
{
    PageType = List;
    Caption = 'CRM Automation Rules';
    SourceTable = "CRM Automation Rule";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Trigger Event"; Rec."Trigger Event")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event that triggers this rule.';
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this rule is active.';
                    StyleExpr = ActiveStyle;
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the execution priority (1-100, 1 = highest).';
                }
                field("Schedule Type"; Rec."Schedule Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this rule should be executed.';
                }
                field("Next Execution"; Rec."Next Execution")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this rule will next be executed.';
                }
                field("Execution Count"; Rec."Execution Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows how many times this rule has been executed.';
                }
                field("Success Count"; Rec."Success Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the number of successful executions.';
                }
                field("Failure Count"; Rec."Failure Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the number of failed executions.';
                    StyleExpr = FailureStyle;
                }
                field("Last Executed"; Rec."Last Executed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this rule was last executed.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who created this rule.';
                }
            }
        }
        area(factboxes)
        {
            part("Rule Statistics"; "CRM Dashboard FactBox")
            {
                ApplicationArea = All;
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
            
            action("View Execution Log")
            {
                ApplicationArea = All;
                Caption = 'View Execution Log';
                Image = Log;
                ToolTip = 'View the execution history for this rule.';
                
                trigger OnAction()
                begin
                    Message('Execution log would be displayed here.');
                end;
            }
            
            action("Enable/Disable")
            {
                ApplicationArea = All;
                Caption = 'Enable/Disable';
                Image = ToggleBreakpoint;
                ToolTip = 'Toggle the active status of this rule.';
                
                trigger OnAction()
                begin
                    Rec."Active" := not Rec."Active";
                    Rec.Modify();
                    CurrPage.Update(false);
                    if Rec."Active" then
                        Message('Rule "%1" is now enabled.', Rec."Rule Name")
                    else
                        Message('Rule "%1" is now disabled.', Rec."Rule Name");
                end;
            }
            
            action("Duplicate Rule")
            {
                ApplicationArea = All;
                Caption = 'Duplicate Rule';
                Image = Copy;
                ToolTip = 'Create a copy of this automation rule.';
                
                trigger OnAction()
                var
                    NewRule: Record "CRM Automation Rule";
                    NewCode: Code[20];
                begin
                    NewCode := Rec."Rule Code" + '-COPY';
                    NewRule := Rec;
                    NewRule."Rule Code" := NewCode;
                    NewRule."Rule Name" := Rec."Rule Name" + ' (Copy)';
                    NewRule."Execution Count" := 0;
                    NewRule."Success Count" := 0;
                    NewRule."Failure Count" := 0;
                    NewRule."Last Executed" := 0DT;
                    NewRule."Active" := false; // Start disabled for safety
                    NewRule.Insert();
                    Message('Rule duplicated with code: %1', NewCode);
                end;
            }
        }
        
        area(creation)
        {
            action("New Rule")
            {
                ApplicationArea = All;
                Caption = 'New Automation Rule';
                Image = New;
                ToolTip = 'Create a new automation rule.';
                RunObject = Page "CRM Automation Rule Card";
                RunPageMode = Create;
            }
        }
        
        area(reporting)
        {
            action("Automation Analytics")
            {
                ApplicationArea = All;
                Caption = 'Automation Analytics';
                Image = Report;
                ToolTip = 'Generate automation performance analytics report.';
                
                trigger OnAction()
                begin
                    Message('Automation analytics report would be generated here.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyleExpressions();
    end;

    local procedure SetStyleExpressions()
    begin
        if Rec."Active" then
            ActiveStyle := 'Favorable'
        else
            ActiveStyle := 'Unfavorable';
            
        if Rec."Failure Count" > 0 then
            FailureStyle := 'Unfavorable'
        else
            FailureStyle := 'Standard';
    end;

    var
        ActiveStyle: Text;
        FailureStyle: Text;
}