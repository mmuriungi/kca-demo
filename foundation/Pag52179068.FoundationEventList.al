page 52153 "Foundation Event List"
{
    PageType = List;
    SourceTable = "Foundation Event";
    Caption = 'Foundation Event List';
    CardPageId = "Foundation Event Card";
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Event Name"; Rec."Event Name")
                {
                    ApplicationArea = All;
                }
                field("Event Type"; Rec."Event Type")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Event Date"; Rec."Event Date")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Target Amount"; Rec."Target Amount")
                {
                    ApplicationArea = All;
                }
                field("Raised Amount"; Rec."Raised Amount")
                {
                    ApplicationArea = All;
                }
                field("Expected Attendance"; Rec."Expected Attendance")
                {
                    ApplicationArea = All;
                }
                field("No. Registered"; Rec."No. Registered")
                {
                    ApplicationArea = All;
                }
                field("Registration Required"; Rec."Registration Required")
                {
                    ApplicationArea = All;
                }
                field("Event Coordinator"; Rec."Event Coordinator")
                {
                    ApplicationArea = All;
                }
            }
        }
        
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ViewDetails)
            {
                ApplicationArea = All;
                Caption = 'View Event Details';
                Image = Document;
                RunObject = page "Foundation Event Card";
                RunPageLink = "No." = field("No.");
                Promoted = true;
                PromotedCategory = Process;
            }
            action(ViewRegistrations)
            {
                ApplicationArea = All;
                Caption = 'View Registrations';
                Image = Contact;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    Rec.CalcFields("No. Registered", "No. Attended");
                    Message('Event: %1\nRegistered: %2\nMax: %3\nAttended: %4\nExpected: %5', 
                        Rec."Event Name", Rec."No. Registered", Rec."Max Registrations", 
                        Rec."No. Attended", Rec."Expected Attendance");
                end;
            }
        }
        
        area(Creation)
        {
            action(NewEvent)
            {
                ApplicationArea = All;
                Caption = 'New Event';
                Image = New;
                RunObject = page "Foundation Event Card";
                RunPageMode = Create;
                Promoted = true;
                PromotedCategory = New;
            }
        }
        
        area(Reporting)
        {
            action(PrintList)
            {
                ApplicationArea = All;
                Caption = 'Print Event List';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Event list would be printed here.');
                end;
            }
            action(EventCalendar)
            {
                ApplicationArea = All;
                Caption = 'Event Calendar';
                Image = Calendar;
                
                trigger OnAction()
                begin
                    Message('Event calendar would be displayed here.');
                end;
            }
        }
    }
}