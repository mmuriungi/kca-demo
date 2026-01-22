page 52179018 "CRM Interaction Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "CRM Interaction Log";
    Caption = 'CRM Interaction Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Information';
                
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer No."; Rec."Customer No.")
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
                    MultiLine = true;
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                }
            }
            
            group(DateAndTime)
            {
                Caption = 'Date & Time';
                
                field("Interaction Date"; Rec."Interaction Date")
                {
                    ApplicationArea = All;
                }
                field("Interaction Time"; Rec."Interaction Time")
                {
                    ApplicationArea = All;
                }
                field("Duration (Minutes)"; Rec."Duration (Minutes)")
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
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Location"; Rec."Location")
                {
                    ApplicationArea = All;
                }
            }
            
            group(OutcomeAndFollowUp)
            {
                Caption = 'Outcome & Follow-up';
                
                field("Outcome"; Rec."Outcome")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Score"; Rec."Evaluation Score")
                {
                    ApplicationArea = All;
                }
                field("Customer Rating"; Rec."Customer Rating")
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
                field("Completed"; Rec."Completed")
                {
                    ApplicationArea = All;
                }
            }
            
            group(BusinessContext)
            {
                Caption = 'Business Context';
                
                field("Campaign Code"; Rec."Campaign Code")
                {
                    ApplicationArea = All;
                }
                field("Sales Rep Code"; Rec."Sales Rep Code")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Cost"; Rec."Cost")
                {
                    ApplicationArea = All;
                }
            }
            
            group(AdditionalInfo)
            {
                Caption = 'Additional Information';
                
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Attachment"; Rec."Attachment")
                {
                    ApplicationArea = All;
                }
            }
            
            group(AuditInfo)
            {
                Caption = 'Audit Information';
                
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
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
            // Customer interaction history factbox will be created later
        }
    }

    actions
    {
        area(Processing)
        {
            action(ScheduleFollowUp)
            {
                ApplicationArea = All;
                Caption = 'Schedule Follow-up';
                Image = DateFormula;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                
                trigger OnAction()
                begin
                    if not Rec."Follow-up Required" then begin
                        Rec."Follow-up Required" := true;
                        Rec."Follow-up Date" := WorkDate() + 7; // Default to 7 days
                        Rec.Modify();
                        Message('Follow-up scheduled for %1.', Rec."Follow-up Date");
                    end else
                        Message('Follow-up is already scheduled for %1.', Rec."Follow-up Date");
                end;
            }
            
            action(MarkCompleted)
            {
                ApplicationArea = All;
                Caption = 'Mark as Completed';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    Rec.Completed := true;
                    if Rec."Follow-up Required" then
                        Rec."Follow-up Required" := false;
                    Rec.Modify();
                    Message('Interaction marked as completed.');
                end;
            }
            
            action(CreateFollowUpInteraction)
            {
                ApplicationArea = All;
                Caption = 'Create Follow-up Interaction';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                
                trigger OnAction()
                var
                    NewInteraction: Record "CRM Interaction Log";
                begin
                    NewInteraction.Init();
                    NewInteraction."Customer No." := Rec."Customer No.";
                    NewInteraction."Interaction Type" := NewInteraction."Interaction Type"::Call;
                    NewInteraction.Subject := 'Follow-up: ' + Rec.Subject;
                    NewInteraction."Interaction Date" := WorkDate();
                    NewInteraction."Interaction Time" := Time;
                    NewInteraction.Priority := Rec.Priority;
                    if NewInteraction.Insert() then begin
                        Message('Follow-up interaction created with Entry No. %1', NewInteraction."Entry No.");
                        // Mark current interaction's follow-up as no longer required
                        Rec."Follow-up Required" := false;
                        Rec.Modify();
                    end;
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
            
            action(CampaignDetails)
            {
                ApplicationArea = All;
                Caption = 'Campaign Details';
                Image = Campaign;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."Campaign Code" <> '';
                
                trigger OnAction()
                begin
                    if Rec."Campaign Code" <> '' then
                        Message('Campaign details for %1 would open here.', Rec."Campaign Code")
                    else
                        Message('No campaign is associated with this interaction.');
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
        }
    }
}