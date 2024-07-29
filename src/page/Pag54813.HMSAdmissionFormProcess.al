page 54813 "HMS Admission Form Process"
{
    PageType = ListPart;
    SourceTable = "HMS-Admission Form Process";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Process Code"; Rec."Process Code")
                {
                    ApplicationArea = All;
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                }
                field(Performed; Rec.Performed)
                {
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

