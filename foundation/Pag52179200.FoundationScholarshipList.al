page 52155 "Foundation Scholarship List"
{
    PageType = List;
    SourceTable = "Foundation Scholarship";
    Caption = 'Foundation Scholarship List';
    CardPageId = "Foundation Scholarship Card";
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
                field("Scholarship Name"; Rec."Scholarship Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Amount Per Student"; Rec."Amount Per Student")
                {
                    ApplicationArea = All;
                }
                field("No. of Awards"; Rec."No. of Awards")
                {
                    ApplicationArea = All;
                }
                field("Total Budget"; Rec."Total Budget")
                {
                    ApplicationArea = All;
                }
                field("Application Start Date"; Rec."Application Start Date")
                {
                    ApplicationArea = All;
                }
                field("Application End Date"; Rec."Application End Date")
                {
                    ApplicationArea = All;
                }
                field("Min GPA"; Rec."Min GPA")
                {
                    ApplicationArea = All;
                }
                field(Renewable; Rec.Renewable)
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
                Caption = 'View Scholarship Details';
                Image = Document;
                RunObject = page "Foundation Scholarship Card";
                RunPageLink = "No." = field("No.");
                Promoted = true;
                PromotedCategory = Process;
            }
            action(ViewApplications)
            {
                ApplicationArea = All;
                Caption = 'View Applications';
                Image = Contact;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    Rec.CalcFields("No. of Applications", "No. Awarded");
                    Message('Applications for %1:\nTotal: %2\nAwarded: %3', Rec."Scholarship Name", Rec."No. of Applications", Rec."No. Awarded");
                end;
            }
        }
        
        area(Creation)
        {
            action(NewScholarship)
            {
                ApplicationArea = All;
                Caption = 'New Scholarship';
                Image = New;
                RunObject = page "Foundation Scholarship Card";
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
                Caption = 'Print Scholarship List';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Scholarship list would be printed here.');
                end;
            }
        }
    }
}