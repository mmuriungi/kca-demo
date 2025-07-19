page 52179017 "CRM Interaction Log List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CRM Interaction Log";
    Caption = 'CRM Interaction Log';
    CardPageId = "CRM Interaction Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Interactions)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Interaction Date"; Rec."Interaction Date")
                {
                    ApplicationArea = All;
                }
                field("Interaction Type"; Rec."Interaction Type")
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
                }
                field("Contact Method"; Rec."Contact Method")
                {
                    ApplicationArea = All;
                }
                field("Duration (Minutes)"; Rec."Duration (Minutes)")
                {
                    ApplicationArea = All;
                }
                field("Outcome"; Rec."Outcome")
                {
                    ApplicationArea = All;
                }
                field("Follow-up Required"; Rec."Follow-up Required")
                {
                    ApplicationArea = All;
                }
                field("Follow-up Date"; Rec."Follow-up Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            // Customer interaction statistics factbox will be created later
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewInteraction)
            {
                ApplicationArea = All;
                Caption = 'New Interaction';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                
                trigger OnAction()
                var
                    InteractionRec: Record "CRM Interaction Log";
                begin
                    InteractionRec.Init();
                    InteractionRec."Interaction Date" := WorkDate();
                    InteractionRec."Interaction Time" := Time;
                    InteractionRec."Created By" := UserId;
                    InteractionRec."Created Date" := CurrentDateTime;
                    if InteractionRec.Insert() then
                        Message('New interaction entry created with Entry No. %1', InteractionRec."Entry No.");
                end;
            }
            
            action(ScheduleFollowUp)
            {
                ApplicationArea = All;
                Caption = 'Schedule Follow-up';
                Image = DateFormula;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if not Rec."Follow-up Required" then begin
                        Rec."Follow-up Required" := true;
                        Rec."Follow-up Date" := WorkDate() + 7; // Add 7 days
                        Rec.Modify();
                        Message('Follow-up scheduled for %1 on %2.', Rec.Subject, Rec."Follow-up Date");
                    end else
                        Message('Follow-up is already scheduled for this interaction.');
                end;
            }
            
            action(MarkComplete)
            {
                ApplicationArea = All;
                Caption = 'Mark Follow-up Complete';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec."Follow-up Required" then begin
                        Rec."Follow-up Required" := false;
                        Rec.Completed := true;
                        Rec.Modify();
                        Message('Follow-up marked as complete for %1.', Rec.Subject);
                    end else
                        Message('No follow-up is scheduled for this interaction.');
                end;
            }
        }
        
        area(Navigation)
        {
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
            
            action(CustomerInteractions)
            {
                ApplicationArea = All;
                Caption = 'All Customer Interactions';
                Image = ShowList;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                var
                    InteractionList: Page "CRM Interaction Log List";
                    InteractionRec: Record "CRM Interaction Log";
                begin
                    InteractionRec.SetRange("Customer No.", Rec."Customer No.");
                    InteractionList.SetTableView(InteractionRec);
                    InteractionList.Run();
                end;
            }
        }
        
        area(Reporting)
        {
            action(InteractionReport)
            {
                ApplicationArea = All;
                Caption = 'Interaction Report';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Interaction report would be generated here.');
                end;
            }
            
            action(FollowUpReport)
            {
                ApplicationArea = All;
                Caption = 'Follow-up Report';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Follow-up report would be generated here.');
                end;
            }
        }
    }
    
    trigger OnOpenPage()
    begin
        // Set default sorting by interaction date (newest first)
        Rec.SetCurrentKey("Interaction Date");
        Rec.Ascending(false);
    end;
}