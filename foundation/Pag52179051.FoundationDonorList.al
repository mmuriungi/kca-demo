page 52179051 "Foundation Donor List"
{
    PageType = List;
    SourceTable = "Foundation Donor";
    Caption = 'Foundation Donors';
    CardPageId = "Foundation Donor Card";
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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Donor Type"; Rec."Donor Type")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Total Donations"; Rec."Total Donations")
                {
                    ApplicationArea = All;
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
                field("Donor Category"; Rec."Donor Category")
                {
                    ApplicationArea = All;
                }
                field("Recognition Level"; Rec."Recognition Level")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
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
            action(ImportDonors)
            {
                ApplicationArea = All;
                Caption = 'Import Donors';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                var
                    FoundationMgt: Codeunit "Foundation Management";
                begin
                    FoundationMgt.ImportDonors();
                end;
            }
            action(ExportDonors)
            {
                ApplicationArea = All;
                Caption = 'Export Donors';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                var
                    FoundationMgt: Codeunit "Foundation Management";
                begin
                    FoundationMgt.ExportDonors();
                end;
            }
            action(UpdateRecognitionLevels)
            {
                ApplicationArea = All;
                Caption = 'Update Recognition Levels';
                Image = UpdateDescription;
                
                trigger OnAction()
                var
                    FoundationMgt: Codeunit "Foundation Management";
                begin
                    FoundationMgt.UpdateDonorRecognitionLevels();
                end;
            }
        }
        
        area(Reporting)
        {
            action(DonorList)
            {
                ApplicationArea = All;
                Caption = 'Donor List';
                Image = Report;
                RunObject = report "Foundation Donor List";
            }
            action(DonorAnalysis)
            {
                ApplicationArea = All;
                Caption = 'Donor Analysis';
                Image = Report;
                RunObject = report "Foundation Donor Analysis";
            }
            action(MajorDonors)
            {
                ApplicationArea = All;
                Caption = 'Major Donors Report';
                Image = Report;
                RunObject = report "Foundation Major Donors";
            }
        }
        
        area(Navigation)
        {
            action(Donations)
            {
                ApplicationArea = All;
                Caption = 'Donations';
                Image = Payment;
                RunObject = page "Foundation Donation List";
                RunPageLink = "Donor No." = field("No.");
            }
            action(Pledges)
            {
                ApplicationArea = All;
                Caption = 'Pledges';
                Image = Agreement;
                RunObject = page "Foundation Pledge List";
                RunPageLink = "Donor No." = field("No.");
            }
        }
    }
}