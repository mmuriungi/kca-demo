page 52154 "Foundation Partnership List"
{
    PageType = List;
    SourceTable = "Foundation Partnership";
    Caption = 'Foundation Partnership List';
    CardPageId = "Foundation Partnership Card";
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Partner Name"; Rec."Partner Name")
                {
                    ApplicationArea = All;
                }
                field("Partnership Type"; Rec."Partnership Type")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
                field("Agreement Type"; Rec."Agreement Type")
                {
                    ApplicationArea = All;
                }
                field("Agreement Date"; Rec."Agreement Date")
                {
                    ApplicationArea = All;
                }
                field("Financial Commitment"; Rec."Financial Commitment")
                {
                    ApplicationArea = All;
                }
                field("Total Contributed"; Rec."Total Contributed")
                {
                    ApplicationArea = All;
                }
                field("Primary Contact"; Rec."Primary Contact")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Review Date"; Rec."Review Date")
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
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ViewDetails)
            {
                ApplicationArea = All;
                Caption = 'View Partnership Details';
                Image = Document;
                RunObject = page "Foundation Partnership Card";
                RunPageLink = "No." = field("No.");
                Promoted = true;
                PromotedCategory = Process;
            }
            action(ViewFinancials)
            {
                ApplicationArea = All;
                Caption = 'View Financial Summary';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    Rec.CalcFields("Total Contributed");
                    Message('Financial Summary for %1:\nCommitment: %2\nContributed: %3\nRemaining: %4', 
                        Rec."Partner Name", Rec."Financial Commitment", Rec."Total Contributed",
                        Rec."Financial Commitment" - Rec."Total Contributed");
                end;
            }
        }
        
        area(Creation)
        {
            action(NewPartnership)
            {
                ApplicationArea = All;
                Caption = 'New Partnership';
                Image = New;
                RunObject = page "Foundation Partnership Card";
                RunPageMode = Create;
                Promoted = true;
                PromotedCategory = New;
            }
        }
        
        area(Reporting)
        {
            action(PrintList)
            {
                ApplicationArea = All;
                Caption = 'Print Partnership List';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Partnership list would be printed here.');
                end;
            }
            action(PartnershipSummary)
            {
                ApplicationArea = All;
                Caption = 'Partnership Summary Report';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Partnership summary report would be generated here.');
                end;
            }
        }
    }
}