// Page: Event Feedback List
page 50319 "Event Feedback List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Event Feedback";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Event No."; Rec."Event No.")
                {
                    ApplicationArea = All;
                }
                field("Attendee No."; Rec."Attendee No.")
                {
                    ApplicationArea = All;
                }
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Feedback Date"; Rec."Feedback Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
