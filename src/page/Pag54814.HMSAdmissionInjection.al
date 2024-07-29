page 54814 "HMS Admission Injection"
{
    PageType = ListPart;
    SourceTable = "HMS-Admission Injection";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field("Injection Code"; Rec."Injection Code")
                {
                    ApplicationArea = All;
                }
                field("Injection Name"; Rec."Injection Name")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

