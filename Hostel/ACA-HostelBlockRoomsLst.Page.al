#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 77335 "ACA-Hostel Block Rooms Lst"
{
    PageType = List;
    SourceTable = "ACA-Hostel Block Rooms";
    SourceTableView = sorting(Sequence, "Hostel Code", "Room Code")
                      order(ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Room Code"; Rec."Room Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bed Spaces"; Rec."Bed Spaces")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Room Cost"; Rec."Room Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Total Spaces"; Rec."Total Spaces")
                {
                    ApplicationArea = Basic;
                }
                field("Vacant Spaces"; Rec."Vacant Spaces")
                {
                    ApplicationArea = Basic;
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

