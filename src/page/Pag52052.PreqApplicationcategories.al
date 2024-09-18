page 52052 "Preq Application categories"
{
    PageType = ListPart;
    SourceTable = "Preq Application categories";
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(Period; Rec.Period)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period field.';
                }
                field("VAT Registration"; Rec."VAT Registration")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Registration field.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field("Category Approved"; Rec."Category Approved")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Approved field.';
                }
                field(Prequalified; Rec.Prequalified)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prequalified field.';
                }
            }
        }
    }

}