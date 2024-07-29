page 54267 "FLT-Transport Requisition St"
{
    PageType = Listpart;
    SourceTable = "FLT-Travel Requisition Staff";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Passenger Type"; Rec."Passenger Type")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Passenger No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Passenger Name")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

