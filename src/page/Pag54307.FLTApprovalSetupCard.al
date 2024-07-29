page 54307 "FLT-Approval Setup Card"
{
    PageType = Card;
    SourceTable = "FLT-Mgt Approval Setups";
    Caption = 'FLT-Approval Setup Card';

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(UserID; Rec.UserID)
                {
                    ApplicationArea = All;
                }
                field("Fleet Management Area"; Rec."Fleet Management Area")
                {
                    ApplicationArea = All;
                }
                field(Create; Rec.Create)
                {
                    ApplicationArea = All;
                }
                field("Line Manager Approver"; Rec."Line Manager Approver")
                {
                    ApplicationArea = All;
                }
                field("Transport Mger Approver"; Rec."Transport Mger Approver")
                {
                    ApplicationArea = All;
                }
                field("Safari Notice Approver"; Rec."Safari Notice Approver")
                {
                    ApplicationArea = All;
                }
                field("Finance Approver"; Rec."Finance Approver")
                {
                    ApplicationArea = All;
                }
                field("IS Director"; Rec."IS Director")
                {
                    ApplicationArea = All;
                }
                field("IS HRM"; Rec."IS HRM")
                {
                    ApplicationArea = All;
                }
                field("Is Deputy Director"; Rec."Is Deputy Director")
                {
                    ApplicationArea = All;
                }
                field("View Only Department"; Rec."View Only Department")
                {
                    ApplicationArea = All;
                }
                field("User Department"; Rec."User Department")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

