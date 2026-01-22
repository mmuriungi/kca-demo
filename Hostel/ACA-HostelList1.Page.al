#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 68132 "ACA-Hostel List1"
{
    CardPageID = "ACA-Hostel Card1";
    Editable = true;
    PageType = List;
    SourceTable = "ACA-Hostel Card";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Asset No"; Rec."Asset No")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                }
                field("Total Rooms"; Rec."Total Rooms")
                {
                    ApplicationArea = Basic;
                }
                field("Space Per Room"; Rec."Space Per Room")
                {
                    ApplicationArea = Basic;
                }
                field("Cost Per Occupant"; Rec."Cost Per Occupant")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Vaccant; Rec.Vaccant)
                {
                    ApplicationArea = Basic;
                }
                field("Partially Occupied"; Rec."Partially Occupied")
                {
                    ApplicationArea = Basic;
                }
                field("Fully Occupied"; Rec."Fully Occupied")
                {
                    ApplicationArea = Basic;
                }
                field(Blacklisted; Rec.Blacklisted)
                {
                    ApplicationArea = Basic;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = Basic;
                }
                field("Cost per Room"; Rec."Cost per Room")
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

