page 52179057 "Foundation Event Reg. List"
{
    PageType = List;
    SourceTable = "Foundation Event Registration";
    Caption = 'Foundation Event Registration List';
    UsageCategory = Lists;
    ApplicationArea = All;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Event No."; Rec."Event No.")
                {
                    ApplicationArea = All;
                }
                field("Event Name"; Rec."Event Name")
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
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                }
                field("Attendance Status"; Rec."Attendance Status")
                {
                    ApplicationArea = All;
                }
                field("Ticket Type"; Rec."Ticket Type")
                {
                    ApplicationArea = All;
                }
                field("Registration Fee"; Rec."Registration Fee")
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
            action(NewRegistration)
            {
                ApplicationArea = All;
                Caption = 'New Registration';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                RunObject = page "Foundation Event Reg. Card";
                RunPageMode = Create;
            }
        }
    }
}