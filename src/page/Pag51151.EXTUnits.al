page 51151 "EXT-Units"
{
    Caption = 'Timetable Units';
    PageType = List;
    SourceTable = "EXT-Units";

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
                field("Unit Code"; Rec."Unit Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                }
                field("Weighting Category"; Rec."Weighting Category")
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
            action("Unit Specific Campuses")
            {
                Caption = 'Unit Specific Campuses';
                Image = Dimensions;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "EXT-Unit Spec. Campuses";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Programme Code" = FIELD("Programme Code"),
                              "Unit Code" = FIELD("Unit Code");
                ApplicationArea = All;
            }
            action("Unit Specific Rooms")
            {
                Caption = 'Unit Specific Rooms';
                Image = GiroPlus;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "EXT-Unit Spec. Rooms";
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Programme Code" = FIELD("Programme Code"),
                              "Unit Code" = FIELD("Unit Code");
                ApplicationArea = All;
            }
        }
    }
}

