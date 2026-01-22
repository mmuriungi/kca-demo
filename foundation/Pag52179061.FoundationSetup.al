page 52179061 "Foundation Setup"
{
    PageType = Card;
    SourceTable = "Foundation Setup";
    Caption = 'Foundation Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Donor Nos."; Rec."Donor Nos.")
                {
                    ApplicationArea = All;
                }
                field("Donation Nos."; Rec."Donation Nos.")
                {
                    ApplicationArea = All;
                }
                field("Campaign Nos."; Rec."Campaign Nos.")
                {
                    ApplicationArea = All;
                }
                field("Pledge Nos."; Rec."Pledge Nos.")
                {
                    ApplicationArea = All;
                }
                field("Grant Nos."; Rec."Grant Nos.")
                {
                    ApplicationArea = All;
                }
                field("Scholarship Nos."; Rec."Scholarship Nos.")
                {
                    ApplicationArea = All;
                }
                field("Event Nos."; Rec."Event Nos.")
                {
                    ApplicationArea = All;
                }
                field("Partnership Nos."; Rec."Partnership Nos.")
                {
                    ApplicationArea = All;
                }
            }
            
            group(FinancialAccounts)
            {
                Caption = 'Financial Accounts';
                
                field("Default Donation GL Account"; Rec."Default Donation GL Account")
                {
                    ApplicationArea = All;
                }
                field("Default Grant GL Account"; Rec."Default Grant GL Account")
                {
                    ApplicationArea = All;
                }
                field("Default Scholarship GL Account"; Rec."Default Scholarship GL Account")
                {
                    ApplicationArea = All;
                }
            }
            
            group(PaymentIntegration)
            {
                Caption = 'Payment Integration';
                
                group(PayPal)
                {
                    Caption = 'PayPal';
                    
                    field("Enable PayPal"; Rec."Enable PayPal")
                    {
                        ApplicationArea = All;
                    }
                    field("PayPal API Key"; Rec."PayPal API Key")
                    {
                        ApplicationArea = All;
                        Editable = Rec."Enable PayPal";
                    }
                    field("PayPal Secret"; Rec."PayPal Secret")
                    {
                        ApplicationArea = All;
                        Editable = Rec."Enable PayPal";
                    }
                }
                
                group(MPesa)
                {
                    Caption = 'M-Pesa';
                    
                    field("Enable M-Pesa"; Rec."Enable M-Pesa")
                    {
                        ApplicationArea = All;
                    }
                    field("M-Pesa Consumer Key"; Rec."M-Pesa Consumer Key")
                    {
                        ApplicationArea = All;
                        Editable = Rec."Enable M-Pesa";
                    }
                    field("M-Pesa Consumer Secret"; Rec."M-Pesa Consumer Secret")
                    {
                        ApplicationArea = All;
                        Editable = Rec."Enable M-Pesa";
                    }
                    field("M-Pesa Shortcode"; Rec."M-Pesa Shortcode")
                    {
                        ApplicationArea = All;
                        Editable = Rec."Enable M-Pesa";
                    }
                }
            }
            
            group(CommunicationSettings)
            {
                Caption = 'Communication Settings';
                
                field("Auto Send Acknowledgment"; Rec."Auto Send Acknowledgment")
                {
                    ApplicationArea = All;
                }
                field("Acknowledgment Template"; Rec."Acknowledgment Template")
                {
                    ApplicationArea = All;
                }
                field("Thank You Template"; Rec."Thank You Template")
                {
                    ApplicationArea = All;
                }
                field("Tax Certificate Template"; Rec."Tax Certificate Template")
                {
                    ApplicationArea = All;
                }
            }
            
            group(RecognitionLevels)
            {
                Caption = 'Recognition Levels';
                
                field("Min. Major Donor Amount"; Rec."Min. Major Donor Amount")
                {
                    ApplicationArea = All;
                }
                field("Bronze Level Amount"; Rec."Bronze Level Amount")
                {
                    ApplicationArea = All;
                }
                field("Silver Level Amount"; Rec."Silver Level Amount")
                {
                    ApplicationArea = All;
                }
                field("Gold Level Amount"; Rec."Gold Level Amount")
                {
                    ApplicationArea = All;
                }
                field("Platinum Level Amount"; Rec."Platinum Level Amount")
                {
                    ApplicationArea = All;
                }
                field("Diamond Level Amount"; Rec."Diamond Level Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}