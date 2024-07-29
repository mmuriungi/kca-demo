/// <summary>
/// Page TT-Timetable Lecturers (ID 74503).
/// </summary>
page 52455 "TT-Timetable Lecturers"
{
    Caption = 'Timetable Lecturers';
    PageType = List;
    SourceTable = "TT-Lecturers";

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
            action("Lecturer Specific Campuses")
            {
                Caption = 'Lecturer Specific Campuses';
                Image = CheckList;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "TT-Lecturer Spec. Campuses";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Lecturer Code" = FIELD("Lecturer Code");
                ApplicationArea = All;
            }
            action("Lecturer Specific Days")
            {
                Caption = 'Lecturer Specific Days';
                Image = CalendarWorkcenter;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "TT-Lect. Spec. Days";
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
                RunObject = Page "TT-Lect. Spec. Lessons";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Lecturer Code" = FIELD("Lecturer Code");
                ApplicationArea = All;
            }
        }
    }
}

