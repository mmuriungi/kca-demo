page 52179052 "Foundation Donation List"
{
    PageType = List;
    SourceTable = "Foundation Donation";
    Caption = 'Foundation Donations';
    CardPageId = "Foundation Donation Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    
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
                field("Donation Date"; Rec."Donation Date")
                {
                    ApplicationArea = All;
                }
                field("Donor No."; Rec."Donor No.")
                {
                    ApplicationArea = All;
                }
                field("Donor Name"; Rec."Donor Name")
                {
                    ApplicationArea = All;
                }
                field("Donor Type"; Rec."Donor Type")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("Campaign Code"; Rec."Campaign Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Tax Deductible"; Rec."Tax Deductible")
                {
                    ApplicationArea = All;
                }
                field(Anonymous; Rec.Anonymous)
                {
                    ApplicationArea = All;
                }
            }
        }
        
        area(FactBoxes)
        {
            part(DonorDetails; "Foundation Donor FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Donor No.");
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
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                
                trigger OnAction()
                var
                    FoundationMgt: Codeunit "Foundation Management";
                begin
                    FoundationMgt.PostDonation(Rec);
                end;
            }
            action(PostBatch)
            {
                ApplicationArea = All;
                Caption = 'Post Batch';
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                var
                    FoundationMgt: Codeunit "Foundation Management";
                begin
                    FoundationMgt.PostDonationBatch();
                end;
            }
            action(GenerateReceipt)
            {
                ApplicationArea = All;
                Caption = 'Generate Receipt';
                Image = PrintReport;
                
                trigger OnAction()
                var
                    FoundationMgt: Codeunit "Foundation Management";
                begin
                    FoundationMgt.GenerateDonationReceipt(Rec);
                end;
            }
            action(SendAcknowledgment)
            {
                ApplicationArea = All;
                Caption = 'Send Acknowledgment';
                Image = SendMail;
                
                trigger OnAction()
                var
                    FoundationMgt: Codeunit "Foundation Management";
                begin
                    FoundationMgt.SendDonationAcknowledgment(Rec);
                end;
            }
        }
        
        area(Navigation)
        {
            action(Donor)
            {
                ApplicationArea = All;
                Caption = 'Donor';
                Image = Customer;
                RunObject = page "Foundation Donor Card";
                RunPageLink = "No." = field("Donor No.");
            }
            action(Campaign)
            {
                ApplicationArea = All;
                Caption = 'Campaign';
                Image = Campaign;
                RunObject = page "Foundation Campaign Card";
                RunPageLink = "No." = field("Campaign Code");
            }
        }
        
        area(Reporting)
        {
            action(DonationReport)
            {
                ApplicationArea = All;
                Caption = 'Donation Report';
                Image = Report;
                RunObject = report "Foundation Donation Report";
            }
            action(DonationSummary)
            {
                ApplicationArea = All;
                Caption = 'Donation Summary';
                Image = Report;
                RunObject = report "Foundation Donation Summary";
            }
        }
    }
}