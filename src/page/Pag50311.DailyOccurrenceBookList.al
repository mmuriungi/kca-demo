// Page: Daily Occurrence Book List
page 50311 "Daily Occurrence Book List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Daily Occurrence Book";
    CardPageId = "Daily Occurrence Card";

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
                field("OB No."; Rec."OB No.")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                }
                field("Time"; Rec."Time")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Recorded By"; Rec."Recorded By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
