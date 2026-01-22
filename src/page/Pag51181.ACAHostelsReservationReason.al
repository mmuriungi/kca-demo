page 51181 "ACA-Hostels Reserv. Reason X"
{
    PageType = List;
    SourceTable = "ACA-Host Reservation Reasons";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

