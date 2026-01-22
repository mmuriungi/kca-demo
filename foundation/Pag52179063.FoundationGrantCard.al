page 52179063 "Foundation Grant Card"
{
    PageType = Card;
    SourceTable = "Foundation Grant";
    Caption = 'Foundation Grant Card';
    
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
                        FoundationSetup.TestField("Grant Nos.");
                        if NoSeriesMgt.SelectSeries(FoundationSetup."Grant Nos.", Rec."No. Series", Rec."No. Series") then
                            CurrPage.Update();
                    end;
                }
                field("Grant Name"; Rec."Grant Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Style = Strong;
                }
                field("Available Amount"; Rec."Available Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Editable = false;
                    Style = StrongAccent;
                }
            }
            
            group(Dates)
            {
                Caption = 'Important Dates';
                
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Application Deadline"; Rec."Application Deadline")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            
            group(Eligibility)
            {
                Caption = 'Eligibility & Requirements';
                
                field("Min Amount Per Applicant"; Rec."Min Amount Per Applicant")
                {
                    ApplicationArea = All;
                }
                field("Max Amount Per Applicant"; Rec."Max Amount Per Applicant")
                {
                    ApplicationArea = All;
                }
                field("Eligibility Criteria"; Rec."Eligibility Criteria")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Application Form"; Rec."Application Form")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Review)
            {
                Caption = 'Review Information';
                
                field("Review Committee"; Rec."Review Committee")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Donor No."; Rec."Donor No.")
                {
                    ApplicationArea = All;
                }
                field("Donor Name"; Rec."Donor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
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
            group(Grant)
            {
                Caption = 'Grant Management';
                
                action(Applications)
                {
                    ApplicationArea = All;
                    Caption = 'View Applications';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    
                    trigger OnAction()
                    begin
                        Message('Applications for grant %1: %2', Rec."Grant Name", Rec."No. of Applications");
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    
                    trigger OnAction()
                    begin
                        Rec.CalcFields("Allocated Amount", "Disbursed Amount", "No. of Applications", "No. Approved");
                        Message('Grant Statistics:\nTotal: %1\nAvailable: %2\nAllocated: %3\nDisbursed: %4\nApplications: %5\nApproved: %6',
                            Rec."Total Amount", Rec."Available Amount", Rec."Allocated Amount", 
                            Rec."Disbursed Amount", Rec."No. of Applications", Rec."No. Approved");
                    end;
                }
            }
            
            group(Functions)
            {
                Caption = 'Functions';
                
                action(OpenApplications)
                {
                    ApplicationArea = All;
                    Caption = 'Open for Applications';
                    Image = Start;
                    Enabled = Rec.Status <> Rec.Status::ApplicationOpen;
                    
                    trigger OnAction()
                    begin
                        if Confirm('Open grant %1 for applications?', false, Rec."Grant Name") then begin
                            Rec.Status := Rec.Status::ApplicationOpen;
                            Rec.Modify();
                            Message('Grant %1 is now open for applications.', Rec."Grant Name");
                        end;
                    end;
                }
                action(CloseApplications)
                {
                    ApplicationArea = All;
                    Caption = 'Close Applications';
                    Image = Stop;
                    Enabled = Rec.Status = Rec.Status::ApplicationOpen;
                    
                    trigger OnAction()
                    begin
                        if Confirm('Close applications for grant %1?', false, Rec."Grant Name") then begin
                            Rec.Status := Rec.Status::UnderReview;
                            Rec.Modify();
                            Message('Applications closed for grant %1.', Rec."Grant Name");
                        end;
                    end;
                }
                action(ApproveGrant)
                {
                    ApplicationArea = All;
                    Caption = 'Approve Grant';
                    Image = Approve;
                    Enabled = Rec.Status = Rec.Status::UnderReview;
                    
                    trigger OnAction()
                    begin
                        if Confirm('Approve grant %1?', false, Rec."Grant Name") then begin
                            Rec.Status := Rec.Status::Approved;
                            Rec.Modify();
                            Message('Grant %1 has been approved.', Rec."Grant Name");
                        end;
                    end;
                }
            }
        }
        
        area(Reporting)
        {
            action(PrintGrant)
            {
                ApplicationArea = All;
                Caption = 'Print Grant Details';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Grant Details:\n\nGrant: %1\nAmount: %2\nStatus: %3\nDeadline: %4', 
                        Rec."Grant Name", Rec."Total Amount", Rec.Status, Rec."Application Deadline");
                end;
            }
        }
    }
}