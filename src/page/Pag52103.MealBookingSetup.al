page 52103 "Meal Booking Setup"
{
    ApplicationArea = All;
    Caption = 'Meal Booking Setup';
    PageType = Card;
    SourceTable = "Meal Booking Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Meal Booking Nos"; Rec."Meal Booking Nos")
                {
                    ToolTip = 'Specifies the value of the Meal Booking Nos field.', Comment = '%';
                }
            }
        }
    }
}
