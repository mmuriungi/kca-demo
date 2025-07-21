page 52179055 "Foundation Pledge List"
{
    PageType = List;
    SourceTable = "Foundation Pledge";
    Caption = 'Foundation Pledge List';
    UsageCategory = Lists;
    ApplicationArea = All;
    
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
                field("Donor No."; Rec."Donor No.")
                {
                    ApplicationArea = All;
                }
                field("Donor Name"; Rec."Donor Name")
                {
                    ApplicationArea = All;
                }
                field("Pledge Date"; Rec."Pledge Date")
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                }
                field("Amount Received"; Rec."Amount Received")
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Next Payment Date"; Rec."Next Payment Date")
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
            action(NewPledge)
            {
                ApplicationArea = All;
                Caption = 'New';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                RunObject = page "Foundation Pledge Card";
                RunPageMode = Create;
            }
        }
    }
}