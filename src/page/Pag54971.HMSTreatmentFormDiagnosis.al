page 54971 "HMS-Treatment Form Diagnosis"
{
    PageType = ListPart;
    SourceTable = "HMS-Treatment Form Diagnosis";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Diagnosis No."; Rec."Diagnosis No.")
                {
                    ApplicationArea = All;
                }
                field("Diagnosis Name"; Rec."Diagnosis Name")
                {
                    ApplicationArea = All;
                }
                field(Confirmed; Rec.Confirmed)
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

