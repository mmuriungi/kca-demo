page 54891 "HMS Patient Immunization"
{
    PageType = ListPart;
    Editable = true;
    SourceTable = "HMS-Patient Immunization";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Immunization Code"; Rec."Immunization Code")
                {
                    ApplicationArea = All;
                }
                field("Immunization Name"; Rec."Immunization Name")
                {
                    ApplicationArea = All;
                }
                field(Yes; Rec.Yes)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
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

