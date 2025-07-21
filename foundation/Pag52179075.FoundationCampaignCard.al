page 52179075 "Foundation Campaign Card"
{
    PageType = Card;
    SourceTable = "Foundation Campaign";
    Caption = 'Foundation Campaign Card';
    
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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Purpose"; Rec."Purpose")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            
            group(Dates)
            {
                Caption = 'Campaign Period';
                
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Financial)
            {
                Caption = 'Financial Information';
                
                field("Goal Amount"; Rec."Goal Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Raised Amount"; Rec."Raised Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ROI Percentage"; Rec."ROI Percentage")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. of Donations"; Rec."No. of Donations")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
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
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(Donations)
            {
                ApplicationArea = All;
                Caption = 'View Donations';
                Image = Payment;
                RunObject = page "Foundation Donation List";
                RunPageLink = "Campaign Code" = field("No.");
                Promoted = true;
                PromotedCategory = Process;
            }
        }
    }
}