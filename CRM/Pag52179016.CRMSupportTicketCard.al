page 52179016 "CRM Support Ticket Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "CRM Support Ticket";
    Caption = 'CRM Support Ticket Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Ticket No."; Rec."Ticket No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Subject"; Rec."Subject")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Category"; Rec."Category")
                {
                    ApplicationArea = All;
                }
                field("Sub-Category"; Rec."Sub-Category")
                {
                    ApplicationArea = All;
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Source"; Rec."Source")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Assignment)
            {
                Caption = 'Assignment & Escalation';
                
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                }
                field("Department"; Rec."Department")
                {
                    ApplicationArea = All;
                }
                field("Escalated"; Rec."Escalated")
                {
                    ApplicationArea = All;
                }
                field("Escalated To"; Rec."Escalated To")
                {
                    ApplicationArea = All;
                }
                field("Escalation Date"; Rec."Escalation Date")
                {
                    ApplicationArea = All;
                }
            }
            
            group(ContactInfo)
            {
                Caption = 'Contact Information';
                
                field("Contact Method"; Rec."Contact Method")
                {
                    ApplicationArea = All;
                }
                field("Customer Email"; Rec."Customer Email")
                {
                    ApplicationArea = All;
                }
                field("Customer Phone"; Rec."Customer Phone")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Dates)
            {
                Caption = 'Important Dates';
                
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("SLA Due Date"; Rec."SLA Due Date")
                {
                    ApplicationArea = All;
                }
                field("First Response Date"; Rec."First Response Date")
                {
                    ApplicationArea = All;
                }
                field("Resolution Date"; Rec."Resolution Date")
                {
                    ApplicationArea = All;
                }
                field("Closed Date"; Rec."Closed Date")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Performance)
            {
                Caption = 'Performance Metrics';
                
                field("Response Time (Hours)"; Rec."Response Time (Hours)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Resolution Time (Hours)"; Rec."Resolution Time (Hours)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Number of Responses"; Rec."Number of Responses")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("SLA Breached"; Rec."SLA Breached")
                {
                    ApplicationArea = All;
                }
            }
            
            group(ResolutionInfo)
            {
                Caption = 'Resolution & Feedback';
                
                field("Resolution"; Rec."Resolution")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Customer Satisfaction"; Rec."Customer Satisfaction")
                {
                    ApplicationArea = All;
                }
                field("Customer Feedback"; Rec."Customer Feedback")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            
            group(Academic)
            {
                Caption = 'Academic Information';
                
                field("Academic Programme"; Rec."Academic Programme")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
            }
            
            group(BusinessInfo)
            {
                Caption = 'Business Information';
                
                field("Product/Service"; Rec."Product/Service")
                {
                    ApplicationArea = All;
                }
                field("Cost Center"; Rec."Cost Center")
                {
                    ApplicationArea = All;
                }
                field("Bill to Customer"; Rec."Bill to Customer")
                {
                    ApplicationArea = All;
                }
                field("Billable Amount"; Rec."Billable Amount")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Additional)
            {
                Caption = 'Additional Information';
                
                field("Related Ticket No."; Rec."Related Ticket No.")
                {
                    ApplicationArea = All;
                }
                field("Knowledge Base Article"; Rec."Knowledge Base Article")
                {
                    ApplicationArea = All;
                }
                field("Tags"; Rec."Tags")
                {
                    ApplicationArea = All;
                }
                field("Internal Notes"; Rec."Internal Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Reopened"; Rec."Reopened")
                {
                    ApplicationArea = All;
                }
                field("Reopen Count"; Rec."Reopen Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Auto-Assigned"; Rec."Auto-Assigned")
                {
                    ApplicationArea = All;
                }
            }
            
            group(AuditInfo)
            {
                Caption = 'Audit Information';
                
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        
        area(FactBoxes)
        {
            // Ticket history and metrics factboxes will be created later
        }
    }

    actions
    {
        area(Processing)
        {
            action(Assign)
            {
                ApplicationArea = All;
                Caption = 'Assign to Me';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Open then begin
                        Rec."Assigned To" := UserId;
                        Rec.Status := Rec.Status::"In Progress";
                        Rec."First Response Date" := CurrentDateTime;
                        Rec.Modify();
                        Message('Ticket %1 has been assigned to you.', Rec."Ticket No.");
                    end else
                        Message('Only open tickets can be assigned.');
                end;
            }
            
            action(Escalate)
            {
                ApplicationArea = All;
                Caption = 'Escalate Ticket';
                Image = Up;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec.Status in [Rec.Status::Open, Rec.Status::"In Progress"] then begin
                        Rec.Escalated := true;
                        Rec."Escalation Date" := CurrentDateTime;
                        if Rec.Priority <> Rec.Priority::Critical then begin
                            case Rec.Priority of
                                Rec.Priority::Low:
                                    Rec.Priority := Rec.Priority::Medium;
                                Rec.Priority::Medium:
                                    Rec.Priority := Rec.Priority::High;
                                Rec.Priority::High:
                                    Rec.Priority := Rec.Priority::Critical;
                            end;
                        end;
                        Rec.Modify();
                        Message('Ticket %1 has been escalated.', Rec."Ticket No.");
                    end else
                        Message('Only open or in-progress tickets can be escalated.');
                end;
            }
            
            action(Resolve)
            {
                ApplicationArea = All;
                Caption = 'Mark as Resolved';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::"In Progress" then begin
                        Rec.Status := Rec.Status::Resolved;
                        Rec."Resolution Date" := CurrentDateTime;
                        Rec.Modify();
                        Message('Ticket %1 has been marked as resolved.', Rec."Ticket No.");
                    end else
                        Message('Only in-progress tickets can be resolved.');
                end;
            }
            
            action(Close)
            {
                ApplicationArea = All;
                Caption = 'Close Ticket';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Resolved then begin
                        Rec.Status := Rec.Status::Closed;
                        Rec."Closed Date" := CurrentDateTime;
                        Rec.Modify();
                        Message('Ticket %1 has been closed.', Rec."Ticket No.");
                    end else
                        Message('Only resolved tickets can be closed.');
                end;
            }
            
            action(Reopen)
            {
                ApplicationArea = All;
                Caption = 'Reopen Ticket';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec.Status in [Rec.Status::Resolved, Rec.Status::Closed] then begin
                        Rec.Status := Rec.Status::Reopened;
                        Rec.Reopened := true;
                        Rec."Reopen Count" += 1;
                        Rec.Modify();
                        Message('Ticket %1 has been reopened.', Rec."Ticket No.");
                    end else
                        Message('Only resolved or closed tickets can be reopened.');
                end;
            }
        }
        
        area(Navigation)
        {
            action(Responses)
            {
                ApplicationArea = All;
                Caption = 'Ticket Responses';
                Image = Response;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                
                trigger OnAction()
                begin
                    Message('Ticket responses for %1 would be shown here.', Rec."Ticket No.");
                end;
            }
            
            action(CustomerCard)
            {
                ApplicationArea = All;
                Caption = 'Customer Card';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    Message('Customer card for %1 would open here.', Rec."Customer No.");
                end;
            }
            
            action(RelatedTickets)
            {
                ApplicationArea = All;
                Caption = 'Related Tickets';
                Image = Relatives;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    Message('Related tickets for customer %1 would be shown here.', Rec."Customer No.");
                end;
            }
        }
        
        area(Reporting)
        {
            action(TicketHistory)
            {
                ApplicationArea = All;
                Caption = 'Ticket History Report';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Ticket history report for %1 would be generated here.', Rec."Ticket No.");
                end;
            }
        }
    }
}