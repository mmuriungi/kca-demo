page 52179042 "Audit Open Findings"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Audit Finding Enhanced";
    Caption = 'Open Audit Findings';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Finding No."; Rec."Finding No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the finding number.';
                }
                field("Audit No."; Rec."Audit No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the audit number.';
                }
                field("Finding Title"; Rec."Finding Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the finding title.';
                }
                field("Risk Severity"; Rec."Risk Severity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk severity.';
                }
                field("Finding Status"; Rec."Finding Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the finding status.';
                }
                field("Target Completion Date"; Rec."Target Completion Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target completion date.';
                }
            }
        }
    }



    actions
    {
        area(Processing)
        {
            action("Close Finding")
            {
                ApplicationArea = All;
                Caption = 'Close Finding';
                Image = Close;
                ToolTip = 'Close the selected finding.';

                trigger OnAction()
                begin
                    Rec."Finding Status" := Rec."Finding Status"::Closed;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Finding Status", Rec."Finding Status"::Open);
    end;
}