page 50054 "Exam Timetable Entry"
{
    ApplicationArea = All;
    Caption = 'Exam Timetable Entry';
    PageType = ListPart;
    SourceTable = "Exam Timetable Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Room Capacity"; Rec."Room Capacity")
                {
                    ToolTip = 'Specifies the value of the Room Capacity field.', Comment = '%';
                }
                field("Student Count"; Rec."Student Count")
                {
                    ToolTip = 'Specifies the value of the Student Count field.', Comment = '%';
                }
                field("No. of Students"; Rec."No. of Students")
                {
                    ApplicationArea = All;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field("Exam Date"; Rec."Exam Date")
                {
                    ApplicationArea = All;
                }
                field("Time Slot"; Rec."Time Slot")
                {
                    ApplicationArea = All;
                }
                field("Lecture Hall"; Rec."Lecture Hall")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                }
                field("Stage Code"; Rec."Stage Code")
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
                field("Exam Type"; Rec."Exam Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Invigilators")
            {
                RunObject = Page "Exam Invigilators";
                RunPageLink = "Date" = field("Exam Date"), Semester = field(Semester), Unit = field("Unit Code"), Hall = field("Lecture Hall");
            }
        }
    }
}