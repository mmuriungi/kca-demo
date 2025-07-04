#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 77393 "KUCCPS Imports Hostel Allocati"
{
    PageType = List;
    SourceTable = "KUCCPS Imports";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Admin; Rec.Admin)
                {
                    ApplicationArea = Basic;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = Basic;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field("Assigned Block"; Rec."Assigned Block")
                {
                    ApplicationArea = Basic;
                }
                field("Assigned Room"; Rec."Assigned Room")
                {
                    ApplicationArea = Basic;
                }
                field("Assigned Space"; Rec."Assigned Space")
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

