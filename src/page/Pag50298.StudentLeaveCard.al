page 50298 "Student Leave Card"
{
    PageType = Card;
    SourceTable = "Student Leave";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Leave No."; Rec."Leave No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Leave Type"; Rec."Leave Type")
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
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ApproveLeave)
            {
                ApplicationArea = All;
                Caption = 'Approve Leave';
                Image = Approve;
                
                trigger OnAction()
                begin
                end;
            }
        }
    }
}
