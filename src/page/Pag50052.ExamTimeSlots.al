page 50052 "Exam Time Slots"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Exam Time Slot";
    CardPageId = "Exam Time Slot Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Day of Week"; Rec."Day of Week")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                }
                field("Duration (Hours)"; Rec."Duration (Hours)")
                {
                    ApplicationArea = All;
                }
                field("Session Type"; Rec."Session Type")
                {
                    ApplicationArea = All;
                }
                field("Valid From Date"; Rec."Valid From Date")
                {
                    ApplicationArea = All;
                }
                field("Valid To Date"; Rec."Valid To Date")
                {
                    ApplicationArea = All;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

