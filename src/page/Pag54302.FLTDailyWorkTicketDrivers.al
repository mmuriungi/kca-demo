page 54302 "FLT-Daily Work Ticket Drivers"
{
    PageType = ListPart;
    SourceTable = "FLT-Daily Work Ticked Drivers";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("line No."; Rec."line No.")
                {
                    ApplicationArea = All;
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                }
                field("Total Milleage"; Rec."Total Milleage")
                {
                    ApplicationArea = All;
                }
                field("Total Fuel Consumed"; Rec."Total Fuel Consumed")
                {
                    ApplicationArea = All;
                }
                field("Ticket No."; Rec."Ticket No.")
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

