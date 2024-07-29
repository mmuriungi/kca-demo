pageextension 50002 "Budget Extension" extends Budget
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addbefore("F&unctions")
        {
            group("Approval Documents")
            {
                Caption = 'Proposals and Approval Documents';
                ToolTip = 'Budget Proposals and Approvals ';
                action("Upload Budget Proposals")
                {
                    Caption = 'Upload Budget Proposals';
                    Image = Attachments;
                    Visible = false;
                    ApplicationArea = All;
                    //RunPageLink = '';
                }
                action("Upload Process Approvals")
                {
                    Caption = 'Upload Process Approvals';
                    Image = Attachments;
                    Visible = false;
                    ApplicationArea = All;
                    //RunPageLink = '';
                }
            }
        }
        addafter("Copy Budget")
        {
            action("Budget Summary")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Budget Summary';
                Image = Journal;
                RunObject = Page "FIN-Budgetary Comparison List";
                ToolTip = 'Budget Summary';
            }
            action("Update Budget")
            {
                ApplicationArea = Suite;
                Caption = 'Update';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Return';
                ToolTip = 'Updates budget once modified';
                trigger OnAction()
                var
                    PostBudgetEnties: Codeunit "Post Budget Enties";
                begin
                    PostBudgetEnties.PostBudget();
                    PostBudgetEnties.Run();
                end;
            }
            action("Budget Periods")
            {
                ApplicationArea = Suite;
                Caption = 'Budget Periods';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Return';
                ToolTip = 'Budget Periods';
                trigger OnAction()
                var
                    BudgPeriod: page "FIN-Budget Periods Setup";
                begin
                    BudgPeriod.Run();
                end;
            }
            action("Budget Comparison Report")
            {
                ApplicationArea = Suite;
                Caption = 'Budget Comparison Summary';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Return';
                ToolTip = 'Budget Comparison Summary';

                //RunObject = page "FIN-Budgetary Comparison List";
                // RunPageLink = "Budget Name" = b;

                trigger OnAction()
                var
                    budgComparison: page "FIN-Budgetary Comparison List";
                begin

                    budgComparison.Run();

                end;
            }

        }
    }

    var
        myInt: Integer;
}