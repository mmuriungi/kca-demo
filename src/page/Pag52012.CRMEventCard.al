// Page: CRM Event Card
page 52012 "CRM Event Card"
{
    PageType = Card;
    SourceTable = "CRM Event";
    Caption = 'CRM Event';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the event.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the name of the event.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the event.';
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the time of the event.';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location of the event.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the category of the event.';
                }
            }
            group(Details)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies a detailed description of the event.';
                }
            }
            group(Statistics)
            {
                field("Registered Attendees"; Rec."Registered Attendees")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Shows the number of registered attendees for this event.';
                }
                field("Checked-in Attendees"; Rec."Checked-in Attendees")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Shows the number of attendees who have checked in for this event.';
                }
                field("Feedback Score"; Rec."Feedback Score")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Shows the average feedback score for this event.';
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
                Caption = 'Attendees';
                Image = PersonInCharge;
                RunObject = page "Event Attendee List";
                RunPageLink = "Event No." = field("No.");
                ToolTip = 'View the list of attendees for this event.';
            }
            action(Feedback)
            {
                ApplicationArea = All;
                Caption = 'Feedback';
                Image = Questionnaire;
                RunObject = page "Event Feedback List";
                RunPageLink = "Event No." = field("No.");
                ToolTip = 'View the feedback received for this event.';
            }
        }
        area(Processing)
        {
            // action(RegisterAttendee)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Register Attendee';
            //     Image = Add;
            //     ToolTip = 'Register a new attendee for this event.';

            //     trigger OnAction()
            //     var
            //         CRMManagement: Codeunit "CRM Management";
            //         AttendeeNo: Code[20];
            //     begin
            //         // AttendeeNo := Page.RunModal(Page::"Contact List"); 
            //         //  if Page.RunModal(Page::crm att) = Action::LookupOK then begin
            //         CRMManagement.RegisterAttendee(Rec."No.", AttendeeNo);
            //         //  end;
            //     end;
            // }
            action(CheckInAttendee)
            {
                ApplicationArea = All;
                Caption = 'Check-In Attendee';
                Image = CheckList;
                ToolTip = 'Check in an attendee for this event.';

                trigger OnAction()
                var
                    CRMManagement: Codeunit "CRM Management";
                    EventAttendee: Record "Event Attendee";
                begin
                    EventAttendee.SetRange("Event No.", Rec."No.");
                    EventAttendee.SetRange("Checked In", false);
                    if Page.RunModal(Page::"Event Attendee List", EventAttendee) = Action::LookupOK then
                        CRMManagement.CheckInAttendee(Rec."No.", EventAttendee."Attendee No.");
                end;
            }
        }
        area(Reporting)
        {
            action(EventReport)
            {
                ApplicationArea = All;
                Caption = 'Event Report';
                Image = Report;
                RunObject = report "Event Report";
                ToolTip = 'Generate a report for this event.';
            }
        }
    }
}
