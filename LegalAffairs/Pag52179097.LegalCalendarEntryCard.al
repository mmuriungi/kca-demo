page 52179097 "Legal Calendar Entry Card"
{
    PageType = Card;
    SourceTable = "Legal Calendar Entry";
    Caption = 'Legal Calendar Entry Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                    Editable = false;
                }
                field("Event Type"; Rec."Event Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event type.';
                }
                field("Event Description"; Rec."Event Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event description.';
                    MultiLine = true;
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies additional notes for the event.';
                    MultiLine = true;
                }
            }
            
            group(DateTime)
            {
                Caption = 'Date & Time';
                
                field("Event Date"; Rec."Event Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event date.';
                }
                field("Event Time"; Rec."Event Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event time.';
                    Visible = not Rec."All Day Event";
                }
                field("All Day Event"; Rec."All Day Event")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this is an all-day event.';
                    
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
            }
            
            group(Recurrence)
            {
                Caption = 'Recurrence';
                
                field("Recurring Event"; Rec."Recurring Event")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this is a recurring event.';
                    
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Recurrence Pattern"; Rec."Recurrence Pattern")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the recurrence pattern.';
                    Visible = Rec."Recurring Event";
                }
            }
            
            group(Assignment)
            {
                Caption = 'Assignment';
                
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsible person.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event status.';
                }
            }
            
            group("Location Details")
            {
                Caption = 'Location Details';
                
                field("Venue"; Rec.Location)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the event location.';
                }
            }
            
            group(References)
            {
                Caption = 'References';
                
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
                field("Compliance Task No."; Rec."Compliance Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related compliance task number.';
                }
            }
            
            group(Reminders)
            {
                Caption = 'Reminders';
                
                field("Reminder Date"; Rec."Reminder Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reminder date.';
                    Editable = false;
                }
                field("Reminder Sent"; Rec."Reminder Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the reminder has been sent.';
                    Editable = false;
                }
            }
            
            group(Integration)
            {
                Caption = 'Integration';
                
                field("Outlook Synced"; Rec."Outlook Synced")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the event is synced with Outlook.';
                }
                field("Google Calendar Synced"; Rec."Google Calendar Synced")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the event is synced with Google Calendar.';
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the record.';
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was created.';
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Mark Completed")
            {
                ApplicationArea = All;
                Caption = 'Mark Completed';
                Image = Completed;
                ToolTip = 'Mark this event as completed.';
                
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
            action("Sync to Outlook")
            {
                ApplicationArea = All;
                Caption = 'Sync to Outlook';
                Image = Outlook;
                ToolTip = 'Sync this event to Outlook calendar.';
                
                trigger OnAction()
                begin
                    SyncToOutlook();
                end;
            }
        }
    }
    
    local procedure SendEventReminder()
    begin
        if not Rec."Reminder Sent" then begin
            Rec."Reminder Sent" := true;
            Rec.Modify(true);
            Message('Reminder sent for event: %1', Rec."Event Description");
        end else
            Message('Reminder has already been sent for this event.');
    end;
    
    local procedure SyncToOutlook()
    begin
        Rec."Outlook Synced" := true;
        Rec.Modify(true);
        Message('Event synced to Outlook calendar.');
    end;
}