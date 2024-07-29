page 54801 "HMIS-Referal Facilities List"
{
    PageType = List;
    SourceTable = "HMIS-Referal Facilities";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Facility Name"; Rec."Facility Name")
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Contact Phone"; Rec."Contact Phone")
                {
                    ApplicationArea = All;
                }
                field("Contact Mail"; Rec."Contact Mail")
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

