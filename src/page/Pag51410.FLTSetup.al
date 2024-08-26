page 51410 "FLT-Setup"
{
    CardPageID = "FLT-Setup Card";
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "FLT-Fleet Mgt Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
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

