page 51280 "Venue Setup List"
{
    PageType = List;
    SourceTable = "Venue Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Venue Code"; Rec."Venue Code")
                {
                }
                field("Venue Description"; Rec."Venue Description")
                {
                    Enabled = false;
                }
                field(Capacity; Rec.Capacity)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Book Id"; Rec."Book Id")
                {
                    Editable = false;
                }
                field("Booked From Date"; Rec."Booked From Date")
                {
                    Editable = false;
                }
                field("Booked To Date"; Rec."Booked To Date")
                {
                    Editable = false;
                }
                field("Booked From Time"; Rec."Booked From Time")
                {
                    Editable = false;
                }
                field("Booked To Time"; Rec."Booked To Time")
                {
                    Editable = false;
                }
                field("Booked Department"; Rec."Booked Department")
                {
                    Editable = false;
                }
                field("Booked Department Name"; Rec."Booked Department Name")
                {
                    Editable = false;
                }
                field("Booked By Name"; Rec."Booked By Name")
                {
                    Editable = false;
                }
                field("Booked By Phone"; Rec."Booked By Phone")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

