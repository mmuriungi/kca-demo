page 52179058 "Foundation Communication List"
{
    PageType = List;
    SourceTable = "Foundation Communication";
    Caption = 'Foundation Communication List';
    UsageCategory = Lists;
    ApplicationArea = All;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Communication Date"; Rec."Communication Date")
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
                field("Communication Type"; Rec."Communication Type")
                {
                    ApplicationArea = All;
                }
                field("Subject"; Rec."Subject")
                {
                    ApplicationArea = All;
                }
                field("Method"; Rec."Method")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
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
            action(NewCommunication)
            {
                ApplicationArea = All;
                Caption = 'New Communication';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                RunObject = page "Foundation Communication Card";
                RunPageMode = Create;
            }
        }
    }
}