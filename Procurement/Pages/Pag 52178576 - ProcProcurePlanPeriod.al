page 52178576 "Proc-Procure. Plan Period"
{
    PageType = List;
    SourceTable = "PROC-Procurement Plan Period";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Period Name"; Rec."Period Name")
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

