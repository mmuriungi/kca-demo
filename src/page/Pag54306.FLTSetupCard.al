page 54306 "FLT-Setup Card"
{
    PageType = Card;
    SourceTable = "FLT-Fleet Mgt Setup";
    Caption = 'FLT-Setup Card';

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Transport Req No"; Rec."Transport Req No")
                {
                    ApplicationArea = All;
                }
                field("Daily Work Ticket"; Rec."Daily Work Ticket")
                {
                    ApplicationArea = All;
                }
                field("Fuel Register"; Rec."Fuel Register")
                {
                    ApplicationArea = All;
                }
                field("Maintenance Request"; Rec."Maintenance Request")
                {
                    ApplicationArea = All;
                }
                field("Rotation Interval"; Rec."Rotation Interval")
                {
                    ApplicationArea = All;
                }
                field("Fuel Payment Batch No"; Rec."Fuel Payment Batch No")
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

