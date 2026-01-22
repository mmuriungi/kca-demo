page 50181 "Prequalified Cat/Years List"
{
    Caption = 'Prequalified Cat/Years List';
    CardPageId = Prequalification;
    PageType = List;
    SourceTable = "Preq Categories/Years";


    layout
    {
        area(content)
        {
            repeater(General)
            {
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
