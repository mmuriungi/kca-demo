page 52422 "TT-Blocks"
{
    PageType = List;
    SourceTable = "TT-Blocks";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Block Code"; Rec."Block Code")
                {
                    ApplicationArea = All;
                }
                field("Block Description"; Rec."Block Description")
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
            action(Rooms)
            {
                Caption = 'Rooms';
                Image = Reuse;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "TT-Rooms";
                RunPageLink = "Block Code" = FIELD("Block Code"),
                              "Academic year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
        }
    }
}

