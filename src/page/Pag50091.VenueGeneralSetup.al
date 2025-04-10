page 50091 "Venue General Setup"
{
    ApplicationArea = All;
    Caption = 'Venue General Setup';
    PageType = Card;
    SourceTable = "Venue General Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Venue Booking Nos"; Rec."Venue Booking Nos")
                {
                    ToolTip = 'Specifies the value of the Venue Booking Nos field.', Comment = '%';
                }
            }
        }
    }
}
