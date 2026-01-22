page 52179078 "Foundation Campaign List"
{
    PageType = List;
    SourceTable = "Foundation Campaign";
    Caption = 'Foundation Campaign List';
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Foundation Campaign Card";
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Goal Amount"; Rec."Goal Amount")
                {
                    ApplicationArea = All;
                }
                field("Raised Amount"; Rec."Raised Amount")
                {
                    ApplicationArea = All;
                }
                field("No. of Donations"; Rec."No. of Donations")
                {
                    ApplicationArea = All;
                }
                field("Campaign Manager"; Rec."Campaign Manager")
                {
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
            }
        }
        
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(NewCampaign)
            {
                ApplicationArea = All;
                Caption = 'New';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                RunObject = page "Foundation Campaign Card";
                RunPageMode = Create;
            }
            action(ViewDonations)
            {
                ApplicationArea = All;
                Caption = 'View Donations';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Foundation Donation List";
                RunPageLink = "Campaign Code" = field("No.");
            }
        }
        
        area(Reporting)
        {
            action(CampaignAnalysis)
            {
                ApplicationArea = All;
                Caption = 'Campaign Analysis';
                Image = Report;
                // RunObject = report "Foundation Campaign Analysis";
            }
        }
    }
}