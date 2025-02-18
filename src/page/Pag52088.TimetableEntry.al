page 52088 "Timetable Entry"
{
    ApplicationArea = All;
    Caption = 'Timetable Entry';
    PageType = ListPart;
    SourceTable = "Timetable Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ToolTip = 'Specifies the value of the Unit Code field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field("Lecture Hall Code"; Rec."Lecture Hall Code")
                {
                    ToolTip = 'Specifies the value of the Lecture Hall Code field.', Comment = '%';
                }
                field("Lecturer Code"; Rec."Lecturer Code")
                {
                    ToolTip = 'Specifies the value of the Lecturer Code field.', Comment = '%';
                }
                field("Time Slot Code"; Rec."Time Slot Code")
                {
                    ToolTip = 'Specifies the value of the Time Slot Code field.', Comment = '%';
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ToolTip = 'Specifies the value of the Stage Code field.', Comment = '%';
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ToolTip = 'Specifies the value of the Programme Code field.', Comment = '%';
                }
                field("Day of Week"; Rec."Day of Week")
                {
                    ToolTip = 'Specifies the value of the Day of Week field.', Comment = '%';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specifies the value of the End Time field.', Comment = '%';
                }
                field("Duration (Hours)"; Rec."Duration (Hours)")
                {
                    ToolTip = 'Specifies the value of the Duration (Hours) field.', Comment = '%';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Timeslot)
            {
                ApplicationArea = All;
                Caption = 'Time Slot';
                Promoted = true;
                PromotedCategory = Process;
                Image = TimeSlot;
                RunObject = page "Time Slots";
                RunPageLink = Code = field("Time Slot Code");
            }
        }
    }

}