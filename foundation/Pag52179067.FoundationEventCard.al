page 52152 "Foundation Event Card"
{
    PageType = Card;
    SourceTable = "Foundation Event";
    Caption = 'Foundation Event Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    
                    trigger OnAssistEdit()
                    var
                        FoundationSetup: Record "Foundation Setup";
                        NoSeriesMgt: Codeunit NoSeriesManagement;
                    begin
                        FoundationSetup.Get();
                        FoundationSetup.TestField("Event Nos.");
                        if NoSeriesMgt.SelectSeries(FoundationSetup."Event Nos.", Rec."No. Series", Rec."No. Series") then
                            CurrPage.Update();
                    end;
                }
                field("Event Name"; Rec."Event Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Event Type"; Rec."Event Type")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            
            group(DateTime)
            {
                Caption = 'Date & Time';
                
                field("Event Date"; Rec."Event Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            
            group(Location)
            {
                Caption = 'Location';
                
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
            }
            
            group(Financial)
            {
                Caption = 'Financial Information';
                
                field("Target Amount"; Rec."Target Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Style = Strong;
                }
                field("Raised Amount"; Rec."Raised Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Style = StrongAccent;
                }
                field("Budget"; Rec."Budget")
                {
                    ApplicationArea = All;
                }
                field("Actual Cost"; Rec."Actual Cost")
                {
                    ApplicationArea = All;
                }
                field("Ticket Price"; Rec."Ticket Price")
                {
                    ApplicationArea = All;
                }
                field("Sponsor Amount"; Rec."Sponsor Amount")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Registration)
            {
                Caption = 'Registration Information';
                
                field("Registration Required"; Rec."Registration Required")
                {
                    ApplicationArea = All;
                }
                field("Registration Deadline"; Rec."Registration Deadline")
                {
                    ApplicationArea = All;
                    Enabled = Rec."Registration Required";
                }
                field("Max Registrations"; Rec."Max Registrations")
                {
                    ApplicationArea = All;
                    Enabled = Rec."Registration Required";
                }
                field("No. Registered"; Rec."No. Registered")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. Attended"; Rec."No. Attended")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expected Attendance"; Rec."Expected Attendance")
                {
                    ApplicationArea = All;
                }
                field("Actual Attendance"; Rec."Actual Attendance")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Campaign)
            {
                Caption = 'Campaign & Coordination';
                
                field("Campaign Code"; Rec."Campaign Code")
                {
                    ApplicationArea = All;
                }
                field("Event Coordinator"; Rec."Event Coordinator")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Communications)
            {
                Caption = 'Communications';
                
                field("Send Invitations"; Rec."Send Invitations")
                {
                    ApplicationArea = All;
                }
                field("Invitations Sent"; Rec."Invitations Sent")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Invitation Date"; Rec."Invitation Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Send Reminders"; Rec."Send Reminders")
                {
                    ApplicationArea = All;
                }
                field("Reminder Date"; Rec."Reminder Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Thank You Sent"; Rec."Thank You Sent")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Thank You Date"; Rec."Thank You Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    Editable = false;
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
            group("Event")
            {
                Caption = 'Event Management';
                
                action(Registrations)
                {
                    ApplicationArea = All;
                    Caption = 'View Registrations';
                    Image = Contact;
                    Enabled = Rec."Registration Required";
                    Promoted = true;
                    PromotedCategory = Process;
                    
                    trigger OnAction()
                    begin
                        Rec.CalcFields("No. Registered", "No. Attended");
                        Message('Registrations for %1:\nRegistered: %2\nMax: %3\nAttended: %4\nExpected: %5', 
                            Rec."Event Name", Rec."No. Registered", Rec."Max Registrations", 
                            Rec."No. Attended", Rec."Expected Attendance");
                    end;
                }
                action(FinancialSummary)
                {
                    ApplicationArea = All;
                    Caption = 'Financial Summary';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    
                    trigger OnAction()
                    begin
                        Message('Financial Summary for %1:\nTarget: %2\nRaised: %3\nBudget: %4\nActual Cost: %5\nSponsorship: %6', 
                            Rec."Event Name", Rec."Target Amount", Rec."Raised Amount", 
                            Rec."Budget", Rec."Actual Cost", Rec."Sponsor Amount");
                    end;
                }
            }
            
            group(Functions)
            {
                Caption = 'Functions';
                
                action(StartEvent)
                {
                    ApplicationArea = All;
                    Caption = 'Start Event';
                    Image = Start;
                    Enabled = Rec.Status = Rec.Status::Scheduled;
                    
                    trigger OnAction()
                    begin
                        if Confirm('Start event %1?', false, Rec."Event Name") then begin
                            Rec.Status := Rec.Status::InProgress;
                            Rec.Modify();
                            Message('Event %1 has started.', Rec."Event Name");
                        end;
                    end;
                }
                action(CompleteEvent)
                {
                    ApplicationArea = All;
                    Caption = 'Mark as Completed';
                    Image = Complete;
                    Enabled = Rec.Status = Rec.Status::InProgress;
                    
                    trigger OnAction()
                    begin
                        if Confirm('Mark event %1 as completed?', false, Rec."Event Name") then begin
                            Rec.Status := Rec.Status::Completed;
                            Rec.Modify();
                            Message('Event %1 marked as completed.', Rec."Event Name");
                        end;
                    end;
                }
                action(CancelEvent)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Event';
                    Image = Cancel;
                    Enabled = (Rec.Status = Rec.Status::Planning) or (Rec.Status = Rec.Status::Scheduled);
                    
                    trigger OnAction()
                    begin
                        if Confirm('Cancel event %1?', false, Rec."Event Name") then begin
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify();
                            Message('Event %1 has been cancelled.', Rec."Event Name");
                        end;
                    end;
                }
                action(SendInvitations)
                {
                    ApplicationArea = All;
                    Caption = 'Send Invitations';
                    Image = SendMail;
                    Enabled = Rec."Send Invitations" and not Rec."Invitations Sent";
                    
                    trigger OnAction()
                    begin
                        if Confirm('Send invitations for event %1?', false, Rec."Event Name") then begin
                            Rec."Invitations Sent" := true;
                            Rec."Invitation Date" := Today;
                            Rec.Modify();
                            Message('Invitations sent for event %1.', Rec."Event Name");
                        end;
                    end;
                }
            }
        }
        
        area(Reporting)
        {
            action(PrintEvent)
            {
                ApplicationArea = All;
                Caption = 'Print Event Details';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Event Details:\n\nEvent: %1\nDate: %2\nTime: %3\nVenue: %4\nStatus: %5\nTarget Amount: %6', 
                        Rec."Event Name", Rec."Event Date", Rec."Start Time", Rec.Venue, Rec.Status, Rec."Target Amount");
                end;
            }
        }
    }
}