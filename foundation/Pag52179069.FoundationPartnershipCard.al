page 52179069 "Foundation Partnership Card"
{
    PageType = Card;
    SourceTable = "Foundation Partnership";
    Caption = 'Foundation Partnership Card';
    
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
                    
                    trigger OnAssistEdit()
                    var
                        FoundationSetup: Record "Foundation Setup";
                        NoSeriesMgt: Codeunit NoSeriesManagement;
                    begin
                        FoundationSetup.Get();
                        FoundationSetup.TestField("Partnership Nos.");
                        if NoSeriesMgt.SelectSeries(FoundationSetup."Partnership Nos.", Rec."No. Series", Rec."No. Series") then
                            CurrPage.Update();
                    end;
                }
                field("Partner Name"; Rec."Partner Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Partnership Type"; Rec."Partnership Type")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            
            group(Dates)
            {
                Caption = 'Partnership Dates';
                
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Agreement Date"; Rec."Agreement Date")
                {
                    ApplicationArea = All;
                }
                field("Review Date"; Rec."Review Date")
                {
                    ApplicationArea = All;
                }
                field("Renewal Date"; Rec."Renewal Date")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Financial)
            {
                Caption = 'Financial Information';
                
                field("Financial Commitment"; Rec."Financial Commitment")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Style = Strong;
                }
                field("Total Contributed"; Rec."Total Contributed")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Related Donor No."; Rec."Related Donor No.")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Agreement)
            {
                Caption = 'Agreement Details';
                
                field("Agreement Type"; Rec."Agreement Type")
                {
                    ApplicationArea = All;
                }
                field("Agreement No."; Rec."Agreement No.")
                {
                    ApplicationArea = All;
                }
                field("Auto Renewal"; Rec."Auto Renewal")
                {
                    ApplicationArea = All;
                }
                field("Termination Clause"; Rec."Termination Clause")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            
            group(Contact)
            {
                Caption = 'Contact Information';
                
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Primary Contact"; Rec."Primary Contact")
                {
                    ApplicationArea = All;
                }
                field("Secondary Contact"; Rec."Secondary Contact")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Details)
            {
                Caption = 'Partnership Details';
                
                field(Objectives; Rec.Objectives)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Key Deliverables"; Rec."Key Deliverables")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Performance Metrics"; Rec."Performance Metrics")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
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
        
        area(FactBoxes)
        {
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
            group(Partnership)
            {
                Caption = 'Partnership Management';
                
                action(ViewAgreement)
                {
                    ApplicationArea = All;
                    Caption = 'View Agreement Details';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    
                    trigger OnAction()
                    begin
                        Message('Agreement Details:\n\nPartner: %1\nType: %2\nAgreement No.: %3\nStart Date: %4\nEnd Date: %5\nCommitment: %6', 
                            Rec."Partner Name", Rec."Agreement Type", Rec."Agreement No.", 
                            Rec."Start Date", Rec."End Date", Rec."Financial Commitment");
                    end;
                }
                action(FinancialSummary)
                {
                    ApplicationArea = All;
                    Caption = 'Financial Summary';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    
                    trigger OnAction()
                    begin
                        Rec.CalcFields("Total Contributed");
                        Message('Financial Summary for %1:\nTotal Commitment: %2\nTotal Contributed: %3\nRemaining: %4', 
                            Rec."Partner Name", Rec."Financial Commitment", Rec."Total Contributed", 
                            Rec."Financial Commitment" - Rec."Total Contributed");
                    end;
                }
            }
            
            group(Functions)
            {
                Caption = 'Functions';
                
                action(ActivatePartnership)
                {
                    ApplicationArea = All;
                    Caption = 'Activate Partnership';
                    Image = Start;
                    Enabled = Rec.Status = Rec.Status::UnderNegotiation;
                    
                    trigger OnAction()
                    begin
                        if Confirm('Activate partnership with %1?', false, Rec."Partner Name") then begin
                            Rec.Status := Rec.Status::Active;
                            Rec.Modify();
                            Message('Partnership with %1 has been activated.', Rec."Partner Name");
                        end;
                    end;
                }
                action(PutOnHold)
                {
                    ApplicationArea = All;
                    Caption = 'Put Partnership On Hold';
                    Image = Pause;
                    Enabled = Rec.Status = Rec.Status::Active;
                    
                    trigger OnAction()
                    begin
                        if Confirm('Put partnership with %1 on hold?', false, Rec."Partner Name") then begin
                            Rec.Status := Rec.Status::OnHold;
                            Rec.Modify();
                            Message('Partnership with %1 has been put on hold.', Rec."Partner Name");
                        end;
                    end;
                }
                action(TerminatePartnership)
                {
                    ApplicationArea = All;
                    Caption = 'Terminate Partnership';
                    Image = Stop;
                    Enabled = (Rec.Status = Rec.Status::Active) or (Rec.Status = Rec.Status::OnHold);
                    
                    trigger OnAction()
                    begin
                        if Confirm('Terminate partnership with %1?', false, Rec."Partner Name") then begin
                            Rec.Status := Rec.Status::Terminated;
                            Rec.Modify();
                            Message('Partnership with %1 has been terminated.', Rec."Partner Name");
                        end;
                    end;
                }
                action(ScheduleReview)
                {
                    ApplicationArea = All;
                    Caption = 'Schedule Review';
                    Image = Calendar;
                    Enabled = Rec.Status = Rec.Status::Active;
                    
                    trigger OnAction()
                    begin
                        Rec."Review Date" := CalcDate('+1Y', Today);
                        Rec.Modify();
                        Message('Review scheduled for partnership with %1 on %2.', Rec."Partner Name", Rec."Review Date");
                    end;
                }
            }
        }
        
        area(Reporting)
        {
            action(PrintPartnership)
            {
                ApplicationArea = All;
                Caption = 'Print Partnership Details';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Partnership Details:\n\nPartner: %1\nType: %2\nStatus: %3\nStart Date: %4\nEnd Date: %5\nFinancial Commitment: %6', 
                        Rec."Partner Name", Rec."Partnership Type", Rec.Status, 
                        Rec."Start Date", Rec."End Date", Rec."Financial Commitment");
                end;
            }
        }
    }
}