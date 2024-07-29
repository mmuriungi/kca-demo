page 50291 "Budget Buffer Line"
{
    Caption = 'Budget Buffer Line';
    PageType = ListPart;
    SourceTable = "Budget Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Budget Date"; Rec."Budget Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Date field.', Comment = '%';
                }
                field("Gl Account"; Rec."Gl Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gl Account field.', Comment = '%';
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Name field.', Comment = '%';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Desription field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
            }
        }
    }
}
