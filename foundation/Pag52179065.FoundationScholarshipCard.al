page 52179065 "Foundation Scholarship Card"
{
    PageType = Card;
    SourceTable = "Foundation Scholarship";
    Caption = 'Foundation Scholarship Card';
    
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
                        FoundationSetup.TestField("Scholarship Nos.");
                        if NoSeriesMgt.SelectSeries(FoundationSetup."Scholarship Nos.", Rec."No. Series", Rec."No. Series") then
                            CurrPage.Update();
                    end;
                }
                field("Scholarship Name"; Rec."Scholarship Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            
            group(Financial)
            {
                Caption = 'Financial Information';
                
                field("Amount Per Student"; Rec."Amount Per Student")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Style = Strong;
                }
                field("No. of Awards"; Rec."No. of Awards")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Total Budget"; Rec."Total Budget")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Style = StrongAccent;
                }
                field("Total Awarded Amount"; Rec."Total Awarded Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            
            group(Application)
            {
                Caption = 'Application Information';
                
                field("Application Start Date"; Rec."Application Start Date")
                {
                    ApplicationArea = All;
                }
                field("Application End Date"; Rec."Application End Date")
                {
                    ApplicationArea = All;
                }
                field("Semester"; Rec."Semester")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Eligibility)
            {
                Caption = 'Eligibility Criteria';
                
                field("Min GPA"; Rec."Min GPA")
                {
                    ApplicationArea = All;
                }
                field("Program Level"; Rec."Program Level")
                {
                    ApplicationArea = All;
                }
                field("Year of Study"; Rec."Year of Study")
                {
                    ApplicationArea = All;
                }
                field("Faculty"; Rec."Faculty")
                {
                    ApplicationArea = All;
                }
                field("Department"; Rec."Department")
                {
                    ApplicationArea = All;
                }
                field("Scholarship Type"; Rec."Scholarship Type")
                {
                    ApplicationArea = All;
                }
                field(Renewable; Rec.Renewable)
                {
                    ApplicationArea = All;
                }
            }
            
            group(Funding)
            {
                Caption = 'Funding Source';
                
                field("Donor No."; Rec."Donor No.")
                {
                    ApplicationArea = All;
                }
                field("Donor Name"; Rec."Donor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Renewal Criteria"; Rec."Renewal Criteria")
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
                field("Eligibility Criteria"; Rec."Eligibility Criteria")
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
            group(Scholarship)
            {
                Caption = 'Scholarship Management';
                
                action(Applications)
                {
                    ApplicationArea = All;
                    Caption = 'View Applications';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    
                    trigger OnAction()
                    begin
                        Rec.CalcFields("No. of Applications", "No. Awarded");
                        Message('Applications for scholarship %1:\nTotal Applications: %2\nAwarded: %3', 
                            Rec."Scholarship Name", Rec."No. of Applications", Rec."No. Awarded");
                    end;
                }
                action(Recipients)
                {
                    ApplicationArea = All;
                    Caption = 'Current Recipients';
                    Image = Contact;
                    Promoted = true;
                    PromotedCategory = Process;
                    
                    trigger OnAction()
                    begin
                        Message('Current recipients for scholarship %1: %2', Rec."Scholarship Name", Rec."No. Awarded");
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
                    Enabled = Rec.Status <> Rec.Status::Open;
                    
                    trigger OnAction()
                    begin
                        if Confirm('Open scholarship %1 for applications?', false, Rec."Scholarship Name") then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                            Message('Scholarship %1 is now open for applications.', Rec."Scholarship Name");
                        end;
                    end;
                }
                action(CloseApplications)
                {
                    ApplicationArea = All;
                    Caption = 'Close Applications';
                    Image = Stop;
                    Enabled = Rec.Status = Rec.Status::Open;
                    
                    trigger OnAction()
                    begin
                        if Confirm('Close applications for scholarship %1?', false, Rec."Scholarship Name") then begin
                            Rec.Status := Rec.Status::Closed;
                            Rec.Modify();
                            Message('Applications closed for scholarship %1.', Rec."Scholarship Name");
                        end;
                    end;
                }
                action(AwardScholarship)
                {
                    ApplicationArea = All;
                    Caption = 'Award Scholarships';
                    Image = Approve;
                    Enabled = Rec.Status = Rec.Status::Closed;
                    
                    trigger OnAction()
                    begin
                        if Confirm('Mark scholarship %1 as awarded?', false, Rec."Scholarship Name") then begin
                            Rec.Status := Rec.Status::Awarded;
                            Rec.Modify();
                            Message('Scholarship %1 has been awarded.', Rec."Scholarship Name");
                        end;
                    end;
                }
            }
        }
        
        area(Reporting)
        {
            action(PrintScholarship)
            {
                ApplicationArea = All;
                Caption = 'Print Scholarship Details';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Scholarship Details:\n\nScholarship: %1\nAmount per Student: %2\nNumber of Awards: %3\nTotal Budget: %4\nStatus: %5', 
                        Rec."Scholarship Name", Rec."Amount Per Student", Rec."No. of Awards", Rec."Total Budget", Rec.Status);
                end;
            }
        }
    }
}