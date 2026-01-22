page 50153 "FIN-Budget Virements List"
{
    Caption = 'FIN-Budget Virements List';
    PageType = ListPart;
    SourceTable = "FIN-Budget Virement Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = all;
                }
                field("ShortCut Dimension 1"; Rec."ShortCut Dimension 1")
                {
                    ApplicationArea = all;

                }
                field("ShortCut Dimension 2"; Rec."ShortCut Dimension 2")
                {
                    ApplicationArea = all;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Account field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
