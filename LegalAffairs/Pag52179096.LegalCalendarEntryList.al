page 52179096 "Legal Calendar Entry List"
{
    PageType = List;
    SourceTable = "Legal Calendar Entry";
    Caption = 'Legal Calendar Entry List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Legal Calendar Entry Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                }
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
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related case number.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related contract number.';
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
                field("Reminder Sent"; Rec."Reminder Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the reminder has been sent.';
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
                RunPageMode = Create;
                RunObject = page "Legal Calendar Entry Card";
            }
            action("Mark Completed")
            {
                ApplicationArea = All;
                Caption = 'Mark Completed';
                Image = Completed;
                ToolTip = 'Mark the selected event as completed.';
                
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Completed;
                    Rec.Modify(true);
                    CurrPage.Update();
                end;
            }
            action("Send Reminder")
            {
                ApplicationArea = All;
                Caption = 'Send Reminder';
                Image = SendMail;
                ToolTip = 'Send a reminder for this event.';
                
                trigger OnAction()
                begin
                    SendEventReminder();
                end;
            }
        }
        area(Navigation)
        {
            group("Calendar Views")
            {
                Caption = 'Calendar Views';
                
                action("Today's Events")
                {
                    ApplicationArea = All;
                    Caption = 'Today''s Events';
                    Image = Calendar;
                    ToolTip = 'View today''s events.';
                    
                    trigger OnAction()
                    begin
                        Rec.SetRange("Event Date", Today);
                        CurrPage.Update();
                    end;
                }
                action("This Week")
                {
                    ApplicationArea = All;
                    Caption = 'This Week';
                    Image = Calendar;
                    ToolTip = 'View this week''s events.';
                    
                    trigger OnAction()
                    begin
                        Rec.SetRange("Event Date", CalcDate('<-CW>', Today), CalcDate('<CW>', Today));
                        CurrPage.Update();
                    end;
                }
                action("Clear Filters")
                {
                    ApplicationArea = All;
                    Caption = 'Clear Filters';
                    Image = ClearFilter;
                    ToolTip = 'Clear all date filters.';
                    
                    trigger OnAction()
                    begin
                        Rec.SetRange("Event Date");
                        CurrPage.Update();
                    end;
                }
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
        
        // Date styling
        if Rec."Event Date" = Today then
            DateStyle := 'Attention'
        else if Rec."Event Date" < Today then
            DateStyle := 'Subordinate'
        else if Rec."Event Date" <= Today + 7 then
            DateStyle := 'Favorable';
            
        // Priority styling
        case Rec.Priority of
            Rec.Priority::Critical:
                PriorityStyle := 'Unfavorable';
            Rec.Priority::High:
                PriorityStyle := 'Unfavorable';
            Rec.Priority::Medium:
                PriorityStyle := 'Attention';
        end;
        
        // Status styling
        case Rec.Status of
            Rec.Status::Completed:
                StatusStyle := 'Favorable';
            Rec.Status::Cancelled:
                StatusStyle := 'Subordinate';
            Rec.Status::Overdue:
                StatusStyle := 'Unfavorable';
        end;
    end;
    
    local procedure SendEventReminder()
    begin
        if not Rec."Reminder Sent" then begin
            // Here would be the actual reminder sending logic
            Rec."Reminder Sent" := true;
            Rec.Modify(true);
            Message('Reminder sent for event: %1', Rec."Event Description");
        end else
            Message('Reminder has already been sent for this event.');
    end;
    
    var
        DateStyle: Text;
        PriorityStyle: Text;
        StatusStyle: Text;
}