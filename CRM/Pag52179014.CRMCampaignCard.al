page 52179014 "CRM Campaign Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "CRM Campaign";
    Caption = 'CRM Campaign Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Campaign Type"; Rec."Campaign Type")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                }
                field("Campaign Manager"; Rec."Campaign Manager")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Dates)
            {
                Caption = 'Dates & Scheduling';
                
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Send Date"; Rec."Scheduled Send Date")
                {
                    ApplicationArea = All;
                }
                field("Actual Send Date"; Rec."Actual Send Date")
                {
                    ApplicationArea = All;
                }
            }
            
            group(TargetAudience)
            {
                Caption = 'Target Audience';
                
                field("Target Audience"; Rec."Target Audience")
                {
                    ApplicationArea = All;
                }
                field("Segmentation Code"; Rec."Segmentation Code")
                {
                    ApplicationArea = All;
                }
                field("Target Count"; Rec."Target Count")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Budget)
            {
                Caption = 'Budget & ROI';
                
                field("Budget Amount"; Rec."Budget Amount")
                {
                    ApplicationArea = All;
                }
                field("Actual Cost"; Rec."Actual Cost")
                {
                    ApplicationArea = All;
                }
                field("ROI Amount"; Rec."ROI Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            
            group(Content)
            {
                Caption = 'Campaign Content';
                
                field("Channel"; Rec."Channel")
                {
                    ApplicationArea = All;
                }
                field("Subject Line"; Rec."Subject Line")
                {
                    ApplicationArea = All;
                }
                field("Message Content"; Rec."Message Content")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Call to Action"; Rec."Call to Action")
                {
                    ApplicationArea = All;
                }
                field("Landing Page URL"; Rec."Landing Page URL")
                {
                    ApplicationArea = All;
                }
                field("Tracking Code"; Rec."Tracking Code")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Performance)
            {
                Caption = 'Performance Metrics';
                
                field("Expected Response Rate"; Rec."Expected Response Rate")
                {
                    ApplicationArea = All;
                }
                field("Actual Response Rate"; Rec."Actual Response Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Responses"; Rec."Actual Responses")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Conversion Rate"; Rec."Conversion Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Email Opens"; Rec."Email Opens")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Email Clicks"; Rec."Email Clicks")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unsubscribes"; Rec."Unsubscribes")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            
            group(Approval)
            {
                Caption = 'Approval';
                
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            
            group(Testing)
            {
                Caption = 'A/B Testing';
                
                field("A/B Testing"; Rec."A/B Testing")
                {
                    ApplicationArea = All;
                }
                field("Test Variant"; Rec."Test Variant")
                {
                    ApplicationArea = All;
                }
            }
            
            group(FollowUp)
            {
                Caption = 'Follow-up';
                
                field("Auto Follow-up"; Rec."Auto Follow-up")
                {
                    ApplicationArea = All;
                }
                field("Follow-up Days"; Rec."Follow-up Days")
                {
                    ApplicationArea = All;
                }
            }
            
            group(AdditionalInfo)
            {
                Caption = 'Additional Information';
                
                field("Tags"; Rec."Tags")
                {
                    ApplicationArea = All;
                }
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
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
            // Campaign metrics factbox will be created later
        }
    }

    actions
    {
        area(Processing)
        {
            action(Launch)
            {
                ApplicationArea = All;
                Caption = 'Launch Campaign';
                Image = Start;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Draft then begin
                        if Rec."Approval Status" = Rec."Approval Status"::Approved then begin
                            Rec.Status := Rec.Status::"In Progress";
                            Rec."Start Date" := Today;
                            Rec."Actual Send Date" := CurrentDateTime;
                            Rec.Modify();
                            Message('Campaign %1 has been launched successfully.', Rec."Description");
                        end else
                            Message('Campaign must be approved before launching.');
                    end else
                        Message('Campaign can only be launched from Draft status.');
                end;
            }
            
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve Campaign';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec."Approval Status" = Rec."Approval Status"::Pending then begin
                        Rec."Approval Status" := Rec."Approval Status"::Approved;
                        Rec."Approved By" := UserId;
                        Rec."Approved Date" := CurrentDateTime;
                        Rec.Modify();
                        Message('Campaign %1 has been approved.', Rec."Description");
                    end else
                        Message('Only pending campaigns can be approved.');
                end;
            }
            
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject Campaign';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec."Approval Status" = Rec."Approval Status"::Pending then begin
                        Rec."Approval Status" := Rec."Approval Status"::Rejected;
                        Rec.Modify();
                        Message('Campaign %1 has been rejected.', Rec."Description");
                    end else
                        Message('Only pending campaigns can be rejected.');
                end;
            }
            
            action(Pause)
            {
                ApplicationArea = All;
                Caption = 'Pause Campaign';
                Image = Pause;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::"In Progress" then begin
                        Rec.Status := Rec.Status::Paused;
                        Rec.Modify();
                        Message('Campaign %1 has been paused.', Rec."Description");
                    end else
                        Message('Only active campaigns can be paused.');
                end;
            }
            
            action(Resume)
            {
                ApplicationArea = All;
                Caption = 'Resume Campaign';
                Image = Start;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Paused then begin
                        Rec.Status := Rec.Status::"In Progress";
                        Rec.Modify();
                        Message('Campaign %1 has been resumed.', Rec."Description");
                    end else
                        Message('Only paused campaigns can be resumed.');
                end;
            }
            
            action(Complete)
            {
                ApplicationArea = All;
                Caption = 'Complete Campaign';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec.Status in [Rec.Status::"In Progress", Rec.Status::Paused] then begin
                        Rec.Status := Rec.Status::Completed;
                        Rec."End Date" := Today;
                        Rec.Modify();
                        Message('Campaign %1 has been completed.', Rec."Description");
                    end else
                        Message('Only active or paused campaigns can be completed.');
                end;
            }
        }
        
        area(Navigation)
        {
            action(Responses)
            {
                ApplicationArea = All;
                Caption = 'Campaign Responses';
                Image = Response;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                
                trigger OnAction()
                begin
                    Message('Campaign responses for %1 would be shown here.', Rec."Description");
                end;
            }
            
            action(Analytics)
            {
                ApplicationArea = All;
                Caption = 'Analytics Dashboard';
                Image = Analytics;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    Message('Campaign Analytics Dashboard for %1 would open here.', Rec."Description");
                end;
            }
        }
        
        area(Reporting)
        {
            action(CampaignReport)
            {
                ApplicationArea = All;
                Caption = 'Campaign Performance Report';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Campaign Performance Report for %1 would be generated here.', Rec."Description");
                end;
            }
            
            action(ROIReport)
            {
                ApplicationArea = All;
                Caption = 'ROI Analysis Report';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('ROI Analysis Report for %1 would be generated here.', Rec."Description");
                end;
            }
        }
    }
}