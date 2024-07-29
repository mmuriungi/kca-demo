page 52510 "EXT-Programmes"
{
    Caption = 'Timetable Programs';
    PageType = List;
    SourceTable = "EXT-Programmes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Programme Code"; Rec."Programme Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Timetable Color"; Rec."Timetable Color")
                {
                    ApplicationArea = All;
                }
                field("Prog. Name"; Rec."Prog. Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Timetable Units")
            {
                Caption = 'Timetable Units';
                Image = Default;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "TT-Timetable Units";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Programme Code" = FIELD("Programme Code");
                ApplicationArea = All;
            }
            action("Prog. Campuses")
            {
                Caption = 'Prog. Campuses';
                Image = Delivery;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "TT-Prog. Specific Campuses";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Programme Code" = FIELD("Programme Code");
                ApplicationArea = All;
            }
            action("Prog. Specific Days")
            {
                Caption = 'Prog. Specific Days';
                Image = CreateBins;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "TT-Prog. Specific Days";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Programme Code" = FIELD("Programme Code");
                ApplicationArea = All;
            }
            action("Prog. Specific Rooms")
            {
                Caption = 'Prog. Specific Rooms';
                Image = CreatePutAway;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "TT-Prog. Spec. Rooms";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Programme Code" = FIELD("Programme Code");
                ApplicationArea = All;
            }
        }
    }
}

