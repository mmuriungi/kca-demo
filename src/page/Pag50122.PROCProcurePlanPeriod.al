page 50122 "PROC-Procure. Plan Period"
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
                }
                field("Period Name"; Rec."Period Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

