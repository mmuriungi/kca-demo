page 52179053 "Foundation Donation Card"
{
    PageType = Card;
    SourceTable = "Foundation Donation";
    Caption = 'Foundation Donation Card';
    
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
                    Importance = Promoted;
                }
                field("Donation Date"; Rec."Donation Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Donor No."; Rec."Donor No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
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
                    Importance = Promoted;
                    Style = Strong;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            
            group(Details)
            {
                Caption = 'Details';
                
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("Specific Purpose"; Rec."Specific Purpose")
                {
                    ApplicationArea = All;
                }
                field("Campaign Code"; Rec."Campaign Code")
                {
                    ApplicationArea = All;
                }
                field("Pledge No."; Rec."Pledge No.")
                {
                    ApplicationArea = All;
                }
                field(Anonymous; Rec.Anonymous)
                {
                    ApplicationArea = All;
                }
                field("In Honor Of"; Rec."In Honor Of")
                {
                    ApplicationArea = All;
                }
                field("In Memory Of"; Rec."In Memory Of")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Payment)
            {
                Caption = 'Payment Information';
                
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                }
                field("Bank Reference"; Rec."Bank Reference")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Tax)
            {
                Caption = 'Tax Information';
                
                field("Tax Deductible"; Rec."Tax Deductible")
                {
                    ApplicationArea = All;
                }
                field("Tax Certificate Issued"; Rec."Tax Certificate Issued")
                {
                    ApplicationArea = All;
                }
                field("Tax Certificate No."; Rec."Tax Certificate No.")
                {
                    ApplicationArea = All;
                }
                field("Tax Certificate Date"; Rec."Tax Certificate Date")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Acknowledgment)
            {
                Caption = 'Acknowledgment';
                
                field("Acknowledgment Sent"; Rec."Acknowledgment Sent")
                {
                    ApplicationArea = All;
                }
                field("Acknowledgment Date"; Rec."Acknowledgment Date")
                {
                    ApplicationArea = All;
                }
                field("Thank You Letter Sent"; Rec."Thank You Letter Sent")
                {
                    ApplicationArea = All;
                }
                field("Thank You Letter Date"; Rec."Thank You Letter Date")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Posting)
            {
                Caption = 'Posting';
                
                field("GL Account No."; Rec."GL Account No.")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
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
                Enabled = not Rec.Posted;
                
                trigger OnAction()
                var
                    FoundationMgt: Codeunit "Foundation Management";
                begin
                    FoundationMgt.PostDonation(Rec);
                end;
            }
            action(GenerateReceipt)
            {
                ApplicationArea = All;
                Caption = 'Generate Receipt';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;
                
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
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                var
                    FoundationMgt: Codeunit "Foundation Management";
                begin
                    FoundationMgt.SendDonationAcknowledgment(Rec);
                end;
            }
            action(IssueTaxCertificate)
            {
                ApplicationArea = All;
                Caption = 'Issue Tax Certificate';
                Image = Certificate;
                Enabled = Rec."Tax Deductible" and not Rec."Tax Certificate Issued";
                
                trigger OnAction()
                var
                    FoundationMgt: Codeunit "Foundation Management";
                begin
                    FoundationMgt.IssueTaxCertificate(Rec);
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
                Enabled = Rec."Campaign Code" <> '';
            }
            action(Pledge)
            {
                ApplicationArea = All;
                Caption = 'Pledge';
                Image = Agreement;
                RunObject = page "Foundation Pledge Card";
                RunPageLink = "No." = field("Pledge No.");
                Enabled = Rec."Pledge No." <> '';
            }
        }
    }
}