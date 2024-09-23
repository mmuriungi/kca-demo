page 52058 "Student Communication Log"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Postgrad Messages";

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
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Supervisor Code"; Rec."Supervisor Code")
                {
                    ApplicationArea = All;
                }
                field("Communication Date"; Rec."Communication Date")
                {
                    ApplicationArea = All;
                }
                field("Message"; Rec."Message")
                {
                    ApplicationArea = All;
                }
                field("Sender Type"; Rec."Sender Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
