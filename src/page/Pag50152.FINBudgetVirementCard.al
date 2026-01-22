page 50152 "FIN-Budget Virement Card"
{
    Caption = 'FIN-Budget Virement Card';
    PageType = Card;
    SourceTable = "FIN-Budget  Virement";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("ShortCut Dimension 1"; Rec."ShortCut Dimension 1")
                {
                    ApplicationArea = ALL;
                }
                field("ShortCut Dimension 2"; Rec."ShortCut Dimension 2")
                {
                    ApplicationArea = ALL;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = ALL;
                }

                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Name field.';
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
            }
            part("Virement Lines"; "FIN-Budget Virements List")
            {
                SubPageLink = No = field("No."), "Budget Name" = field("Budget Name"), "ShortCut Dimension 1" = field("ShortCut Dimension 1"), "ShortCut Dimension 2" = field("ShortCut Dimension 2"), "ShortCut Dimension 3" = field("ShortCut Dimension 3");

            }
        }
    }
}
