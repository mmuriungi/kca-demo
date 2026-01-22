page 52179015 "CRM Support Ticket List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CRM Support Ticket";
    Caption = 'CRM Support Tickets';
    CardPageId = "CRM Support Ticket Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Tickets)
            {
                field("Ticket No."; Rec."Ticket No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Subject"; Rec."Subject")
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec."Category")
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
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("SLA Due Date"; Rec."SLA Due Date")
                {
                    ApplicationArea = All;
                }
                field("SLA Breached"; Rec."SLA Breached")
                {
                    ApplicationArea = All;
                }
                field("Resolution Date"; Rec."Resolution Date")
                {
                    ApplicationArea = All;
                }
                field("Customer Satisfaction"; Rec."Customer Satisfaction")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            // Ticket Statistics factbox will be created later
        }
    }

    actions
    {
        area(Processing)
        {
            action(Assign)
            {
                ApplicationArea = All;
                Caption = 'Assign Ticket';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                
                trigger OnAction()
                var
                    AssignToUser: Code[50];
                begin
                    if Rec.Status = Rec.Status::Open then begin
                        AssignToUser := UserId;
                        Rec."Assigned To" := AssignToUser;
                        Rec.Status := Rec.Status::"In Progress";
                        Rec."First Response Date" := CurrentDateTime;
                        Rec.Modify();
                        Message('Ticket %1 has been assigned to %2.', Rec."Ticket No.", AssignToUser);
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
                        if Rec.Priority <> Rec.Priority::High then begin
                            case Rec.Priority of
                                Rec.Priority::Low:
                                    Rec.Priority := Rec.Priority::Medium;
                                Rec.Priority::Medium:
                                    Rec.Priority := Rec.Priority::High;
                            end;
                            Rec.Modify();
                            Message('Ticket %1 has been escalated to %2 priority.', Rec."Ticket No.", Rec.Priority);
                        end else
                            Message('Ticket is already at highest priority.');
                    end else
                        Message('Only open or in-progress tickets can be escalated.');
                end;
            }
            
            action(Resolve)
            {
                ApplicationArea = All;
                Caption = 'Resolve Ticket';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::"In Progress" then begin
                        Rec.Status := Rec.Status::Resolved;
                        Rec."Resolution Date" := CurrentDateTime;
                        Rec.Modify();
                        Message('Ticket %1 has been resolved.', Rec."Ticket No.");
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
                        Rec.Modify();
                        Message('Ticket %1 has been closed.', Rec."Ticket No.");
                    end else
                        Message('Only resolved tickets can be closed.');
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
        }
        
        area(Reporting)
        {
            action(TicketReport)
            {
                ApplicationArea = All;
                Caption = 'Ticket Report';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Ticket report would be generated here.');
                end;
            }
            
            action(SLAReport)
            {
                ApplicationArea = All;
                Caption = 'SLA Performance Report';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('SLA Performance report would be generated here.');
                end;
            }
        }
    }
    
    trigger OnOpenPage()
    begin
        // Set default filter to show only open tickets
        Rec.SetFilter(Status, '%1|%2|%3', Rec.Status::Open, Rec.Status::"In Progress", Rec.Status::"Pending Customer");
    end;
}