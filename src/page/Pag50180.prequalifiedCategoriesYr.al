page 50180 "prequalified Categories/Yr"
{
    Caption = 'prequalified Categories/Yr';
    PageType = Card;
    SourceTable = "Preq Categories/Years";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Preq Category"; Rec."Preq Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq Category field.';
                }
                field("Preq Year"; Rec."Preq Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq Year field.';
                }
                field("Prequalified Supliers"; Rec."Prequalified Supliers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prequalified Supliers field.';
                }
            }
        }
    }
}
