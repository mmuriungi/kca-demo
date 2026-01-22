page 50163 "Budget Workplan Names"
{
    Caption = 'G/L Budget Names';
    PageType = List;
    SourceTable = "Procurment Plan Name";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
                {
                }
                field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
                {
                }
                field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
                {
                }
                field("Budget Dimension 4 Code"; Rec."Budget Dimension 4 Code")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
        }


    }

    actions
    {
        area(processing)
        {
            action(EditBudget)
            {
                Caption = 'Edit Budget';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Return';

                trigger OnAction()
                var
                    Budget: Page "Budget Workplan";
                begin
                    Budget.SetBudgetName(Rec.Name);
                    Budget.RUN;
                end;
            }
        }
    }

    procedure GetSelectionFilter(): Text
    var
        GLBudgetName: Record "Workplan";
        SelectionFilterManagement: Codeunit "SelectionFilterManagement";
    begin
    end;
}

