// Page: Event Attendee List
page 50318 "Event Attendee List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Event Attendee";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Event No."; Rec."Event No.")
                {
                    ApplicationArea = All;
                }
                field("Attendee No."; Rec."Attendee No.")
                {
                    ApplicationArea = All;
                }
                field("Email"; Rec."Email")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                }
                field("Checked In"; Rec."Checked In")
                {
                    ApplicationArea = All;
                }
                field("Check-in Time"; Rec."Check-in Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
