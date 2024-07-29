page 54450 "Fuel Type List"
{
    Caption = 'Fuel Type List';
    PageType = List;
    CardPageId = "fuel Type Card";
    SourceTable = "Fuel Type";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
