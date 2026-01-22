page 51583 "fuel Type Card"
{
    Caption = 'fuel Type Card';
    PageType = Card;
    SourceTable = "Fuel Type";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Fuel Code"; Rec."Fuel Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fuel Code field.', Comment = '%';
                }
                field("Fuel Name"; Rec."Fuel Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fuel Name field.', Comment = '%';
                }
            }
        }
    }
}
