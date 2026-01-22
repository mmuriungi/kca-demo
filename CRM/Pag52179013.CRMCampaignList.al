page 52179013 "CRM Campaign List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CRM Campaign";
    Caption = 'CRM Campaigns';
    CardPageId = "CRM Campaign Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Campaigns)
            {
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
                field("Channel"; Rec."Channel")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                    ApplicationArea = All;
                }
                field("Actual Cost"; Rec."Actual Cost")
                {
                    ApplicationArea = All;
                }
                field("Target Count"; Rec."Target Count")
                {
                    ApplicationArea = All;
                }
                field("Actual Response Rate"; Rec."Actual Response Rate")
                {
                    ApplicationArea = All;
                }
                field("ROI Amount"; Rec."ROI Amount")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            // Campaign Statistics factbox will be created later
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
                        Rec.Status := Rec.Status::"In Progress";
                        Rec."Start Date" := Today;
                        Rec.Modify();
                        Message('Campaign %1 has been launched successfully.', Rec."Description");
                    end else
                        Message('Campaign can only be launched from Draft status.');
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
                Caption = 'Campaign Analytics';
                Image = Analytics;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    Message('Campaign Analytics for %1:\Response Rate: %2%\ROI: %3\Actual Responses: %4', 
                        Rec."Description", Rec."Actual Response Rate", Rec."ROI Amount", Rec."Actual Responses");
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
                    Message('Campaign Performance Report would be generated here.');
                end;
            }
        }
    }
}