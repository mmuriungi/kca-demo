page 52507 "EXT-Lecturers"
{
    Caption = 'Timetable Lecturers';
    PageType = List;
    SourceTable = "EXT-Lecturers";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lecturer Code"; Rec."Lecturer Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Lecturer Specific Days")
            {
                Caption = 'Lecturer Specific Days';
                Image = CalendarWorkcenter;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "EXT-Lect. Spec. Days";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Lecturer Code" = FIELD("Lecturer Code");
                ApplicationArea = All;
            }
            action("Lecturer Specific Lessons")
            {
                Caption = 'Lecturer Specific Lessons';
                Image = Compress;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "EXT-Lect. Spec. Lessons";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Lecturer Code" = FIELD("Lecturer Code");
                ApplicationArea = All;
            }
        }
    }
}

