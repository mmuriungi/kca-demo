// Page: CRM Event List
page 50317 "CRM Event List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CRM Event";
    CardPageId = "CRM Event Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Registered Attendees"; Rec."Registered Attendees")
                {
                    ApplicationArea = All;
                }
                field("Checked-in Attendees"; Rec."Checked-in Attendees")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Attendees)
            {
                ApplicationArea = All;
                RunObject = page "Event Attendee List";
                RunPageLink = "Event No." = field("No.");
                Image = PersonInCharge;
            }
            action(Feedback)
            {
                ApplicationArea = All;
                RunObject = page "Event Feedback List";
                RunPageLink = "Event No." = field("No.");
                Image = Questionnaire;
            }
        }
    }
}
