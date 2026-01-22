page 50028 "Exam Time Slot Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Exam Time Slot";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
            }
            group(Schedule)
            {
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
            }
            group("Date Range")
            {
                field("Valid From Date"; Rec."Valid From Date")
                {
                    ApplicationArea = All;
                }
                field("Valid To Date"; Rec."Valid To Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Requirements)
            {
                field("Room Type Required"; Rec."Room Type Required")
                {
                    ApplicationArea = All;
                }
                field("Maximum Students Per Room"; Rec."Maximum Students Per Room")
                {
                    ApplicationArea = All;
                }
                field("Default Break Time (Minutes)"; Rec."Default Break Time (Minutes)")
                {
                    ApplicationArea = All;
                }
                field("Setup Time Required (Minutes)"; Rec."Setup Time Required (Minutes)")
                {
                    ApplicationArea = All;
                }
                field("Max Continuous Hours"; Rec."Max Continuous Hours")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}