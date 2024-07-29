page 54816 "HMS Admission Nurse Notes"
{
    PageType = ListPart;
    SourceTable = "HMS-Admission Form Nurse";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Nurse ID"; Rec."Nurse ID")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field(Notes; Rec.Notes)
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

