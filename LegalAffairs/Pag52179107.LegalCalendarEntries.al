page 52179107 "Legal Calendar Entries"
{
    PageType = ListPart;
    SourceTable = "Legal Calendar Entry";
    Caption = 'Legal Calendar Entries';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Event Type"; Rec."Event Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event type.';
                }
                field("Event Date"; Rec."Event Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event date.';
                    StyleExpr = DateStyle;
                }
                field("Event Time"; Rec."Event Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event time.';
                }
                field("Event Description"; Rec."Event Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event description.';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event location.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsible person.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                    StyleExpr = PriorityStyle;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event status.';
                    StyleExpr = StatusStyle;
                }
                field("Reminder Date"; Rec."Reminder Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reminder date.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("New Event")
            {
                ApplicationArea = All;
                Caption = 'New Event';
                Image = New;
                ToolTip = 'Create a new calendar event.';
                
                trigger OnAction()
                var
                    CalendarEntry: Record "Legal Calendar Entry";
                begin
                    CalendarEntry.Init();
                    if Rec."Case No." <> '' then
                        CalendarEntry."Case No." := Rec."Case No.";
                    CalendarEntry.Insert(true);
                    Page.Run(Page::"Legal Calendar Entry Card", CalendarEntry);
                end;
            }
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;
    
    local procedure SetStyles()
    begin
        DateStyle := 'Standard';
        PriorityStyle := 'Standard';
        StatusStyle := 'Standard';
        
        if Rec."Event Date" = Today then
            DateStyle := 'Attention'
        else if Rec."Event Date" < Today then
            DateStyle := 'Subordinate'
        else if Rec."Event Date" <= Today + 7 then
            DateStyle := 'Favorable';
            
        case Rec.Priority of
            Rec.Priority::Critical:
                PriorityStyle := 'Unfavorable';
            Rec.Priority::High:
                PriorityStyle := 'Unfavorable';
            Rec.Priority::Medium:
                PriorityStyle := 'Attention';
        end;
        
        case Rec.Status of
            Rec.Status::Completed:
                StatusStyle := 'Favorable';
            Rec.Status::Cancelled:
                StatusStyle := 'Subordinate';
            Rec.Status::Overdue:
                StatusStyle := 'Unfavorable';
        end;
    end;
    
    var
        DateStyle: Text;
        PriorityStyle: Text;
        StatusStyle: Text;
}