page 52179050 "Foundation Donor Card"
{
    PageType = Card;
    SourceTable = "Foundation Donor";
    Caption = 'Foundation Donor Card';
    
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
                field("Donor Type"; Rec."Donor Type")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Donor Since"; Rec."Donor Since")
                {
                    ApplicationArea = All;
                }
                field("Donor Category"; Rec."Donor Category")
                {
                    ApplicationArea = All;
                }
                field("Recognition Level"; Rec."Recognition Level")
                {
                    ApplicationArea = All;
                }
                field("Anonymous Donor"; Rec."Anonymous Donor")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Contact)
            {
                Caption = 'Contact Information';
                
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Preferred Contact Method"; Rec."Preferred Contact Method")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Alumni)
            {
                Caption = 'Alumni Information';
                Visible = IsAlumni;
                
                field("Alumni ID"; Rec."Alumni ID")
                {
                    ApplicationArea = All;
                }
                field("Graduation Year"; Rec."Graduation Year")
                {
                    ApplicationArea = All;
                }
                field(Faculty; Rec.Faculty)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
            }
            
            group(Financial)
            {
                Caption = 'Financial Information';
                
                field("Total Donations"; Rec."Total Donations")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Style = Strong;
                }
                field("Last Donation Date"; Rec."Last Donation Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Donations"; Rec."No. of Donations")
                {
                    ApplicationArea = All;
                }
                field("Active Pledges"; Rec."Active Pledges")
                {
                    ApplicationArea = All;
                }
                field("Tax Exempt No."; Rec."Tax Exempt No.")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Banking)
            {
                Caption = 'Banking Information';
                
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("PayPal Email"; Rec."PayPal Email")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Communication)
            {
                Caption = 'Communication Preferences';
                
                field("Marketing Opt-In"; Rec."Marketing Opt-In")
                {
                    ApplicationArea = All;
                }
                field("Newsletter Subscription"; Rec."Newsletter Subscription")
                {
                    ApplicationArea = All;
                }
                field("Event Invitations"; Rec."Event Invitations")
                {
                    ApplicationArea = All;
                }
                field("Annual Report"; Rec."Annual Report")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Notes Field"; Rec.Notes)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Caption = 'Notes';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
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
        
        area(FactBoxes)
        {
            part(DonorStatistics; "Foundation Donor Statistics")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            group(Donor)
            {
                Caption = 'Donor';
                
                action(Donations)
                {
                    ApplicationArea = All;
                    Caption = 'Donations';
                    Image = Payment;
                    RunObject = page "Foundation Donation List";
                    RunPageLink = "Donor No." = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action(Pledges)
                {
                    ApplicationArea = All;
                    Caption = 'Pledges';
                    Image = Agreement;
                    RunObject = page "Foundation Pledge List";
                    RunPageLink = "Donor No." = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action(Events)
                {
                    ApplicationArea = All;
                    Caption = 'Event Registrations';
                    Image = Calendar;
                    RunObject = page "Foundation Event Reg. List";
                    RunPageLink = "Donor No." = field("No.");
                }
                action(Communications)
                {
                    ApplicationArea = All;
                    Caption = 'Communications';
                    Image = SendMail;
                    RunObject = page "Foundation Communication List";
                    RunPageLink = "Donor No." = field("No.");
                }
            }
            
            group(Functions)
            {
                Caption = 'Functions';
                
                action(CreateDonation)
                {
                    ApplicationArea = All;
                    Caption = 'Create Donation';
                    Image = NewDocument;
                    Promoted = true;
                    PromotedCategory = New;
                    
                    trigger OnAction()
                    var
                        FoundationMgt: Codeunit "Foundation Management";
                    begin
                        FoundationMgt.CreateDonationFromDonor(Rec);
                    end;
                }
                action(CreatePledge)
                {
                    ApplicationArea = All;
                    Caption = 'Create Pledge';
                    Image = NewDocument;
                    Promoted = true;
                    PromotedCategory = New;
                    
                    trigger OnAction()
                    var
                        FoundationMgt: Codeunit "Foundation Management";
                    begin
                        FoundationMgt.CreatePledgeFromDonor(Rec);
                    end;
                }
                action(SendThankYou)
                {
                    ApplicationArea = All;
                    Caption = 'Send Thank You';
                    Image = SendEmailPDF;
                    
                    trigger OnAction()
                    var
                        FoundationMgt: Codeunit "Foundation Management";
                    begin
                        FoundationMgt.SendThankYouLetter(Rec);
                    end;
                }
                action(PrintTaxCertificate)
                {
                    ApplicationArea = All;
                    Caption = 'Print Tax Certificate';
                    Image = PrintReport;
                    
                    trigger OnAction()
                    var
                        FoundationMgt: Codeunit "Foundation Management";
                    begin
                        FoundationMgt.PrintTaxCertificate(Rec);
                    end;
                }
            }
        }
        
        area(Reporting)
        {
            action(DonorStatement)
            {
                ApplicationArea = All;
                Caption = 'Donor Statement';
                Image = Report;
                RunObject = report "Foundation Donor Statement";
            }
            action(DonationHistory)
            {
                ApplicationArea = All;
                Caption = 'Donation History';
                Image = Report;
                RunObject = report "Foundation Donation History";
            }
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        IsAlumni := Rec."Donor Type" = Rec."Donor Type"::Alumni;
    end;
    
    var
        IsAlumni: Boolean;
}