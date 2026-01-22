page 50299 "Counseling Session List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Counseling Session";
    CardPageId = "Counseling Session Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Session No."; Rec."Session No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Counselor No."; Rec."Counselor No.")
                {
                    ApplicationArea = All;
                }
                field("Session Date"; Rec."Session Date")
                {
                    ApplicationArea = All;
                }
                field("Follow-up Required"; Rec."Follow-up Required")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
