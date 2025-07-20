page 52179093 "Legal Compliance Task Card"
{
    PageType = Card;
    SourceTable = "Legal Compliance Task";
    Caption = 'Legal Compliance Task Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Task No."; Rec."Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the task number.';
                }
                field("Compliance Type"; Rec."Compliance Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the compliance type.';
                }
                field("Task Description"; Rec."Task Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the task description.';
                    MultiLine = true;
                }
                field("Regulation/Law"; Rec."Regulation/Law")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the regulation or law.';
                }
                field("Evidence Required"; Rec."Evidence Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the evidence required for compliance.';
                    MultiLine = true;
                }
            }
            
            group(Assignment)
            {
                Caption = 'Assignment';
                
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the task is assigned to.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                }
                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk level.';
                }
            }
            
            group(Timeline)
            {
                Caption = 'Timeline';
                
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due date.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the task status.';
                }
                field("Completion Date"; Rec."Completion Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the completion date.';
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the frequency of the compliance requirement.';
                }
                field("Next Review Date"; Rec."Next Review Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the next review date.';
                }
            }
            
            group("Risk & Impact")
            {
                Caption = 'Risk & Impact';
                
                field("Penalty Amount"; Rec."Penalty Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the penalty amount for non-compliance.';
                }
            }
            
            group(References)
            {
                Caption = 'References';
                
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related contract number.';
                }
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related case number.';
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the record.';
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was created.';
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Mark Completed")
            {
                ApplicationArea = All;
                Caption = 'Mark Completed';
                Image = Completed;
                ToolTip = 'Mark this task as completed.';
                
                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Completed then begin
                        Rec.Status := Rec.Status::Completed;
                        Rec."Completion Date" := Today;
                        Rec.Modify(true);
                        CurrPage.Update();
                    end;
                end;
            }
            action("Mark In Progress")
            {
                ApplicationArea = All;
                Caption = 'Mark In Progress';
                Image = Process;
                ToolTip = 'Mark this task as in progress.';
                
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::"In Progress";
                    Rec.Modify(true);
                    CurrPage.Update();
                end;
            }
        }
    }
}