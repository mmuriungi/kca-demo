// Page: Incident Report List
page 50309 "Incident Report List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Incident Report";
    CardPageId = "Incident Report Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                }
                field("Accused Name"; Rec."Accused Name")
                {
                    ApplicationArea = All;
                }
                field("Victim/Reporting Party"; Rec."Victim/Reporting Party")
                {
                    ApplicationArea = All;
                }
                field("Nature of Case"; Rec."Nature of Case")
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
