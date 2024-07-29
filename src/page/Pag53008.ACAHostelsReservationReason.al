page 53008 "ACA-Hostels Reservation Reason"
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

