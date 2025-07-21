page 52179064 "Foundation Grant List"
{
    PageType = List;
    SourceTable = "Foundation Grant";
    Caption = 'Foundation Grant List';
    CardPageId = "Foundation Grant Card";
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
                field("Grant Name"; Rec."Grant Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Available Amount"; Rec."Available Amount")
                {
                    ApplicationArea = All;
                }
                field("Application Deadline"; Rec."Application Deadline")
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
                field("Review Committee"; Rec."Review Committee")
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
                Caption = 'View Grant Details';
                Image = Document;
                RunObject = page "Foundation Grant Card";
                RunPageLink = "No." = field("No.");
                Promoted = true;
                PromotedCategory = Process;
            }
        }
        
        area(Creation)
        {
            action(NewGrant)
            {
                ApplicationArea = All;
                Caption = 'New Grant';
                Image = New;
                RunObject = page "Foundation Grant Card";
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
                Caption = 'Print Grant List';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Grant list would be printed here.');
                end;
            }
        }
    }
}