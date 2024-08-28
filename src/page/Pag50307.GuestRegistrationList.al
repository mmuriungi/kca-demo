// Page: Guest Registration List
page 50307 "Guest Registration List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Guest Registration";
    CardPageId = "Guest Registration Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Visitor Name"; Rec."Visitor Name")
                {
                    ApplicationArea = All;
                }
                field("Reason for Visit"; Rec."Reason for Visit")
                {
                    ApplicationArea = All;
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = All;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Plate Number"; Rec."Vehicle Plate Number")
                {
                    ApplicationArea = All;
                }
                field("Is Staff"; Rec."Is Staff")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
