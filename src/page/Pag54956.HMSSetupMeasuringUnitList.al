page 54956 "HMS-Setup Measuring Unit List"
{
    PageType = List;
    SourceTable = "HMS-Setup Measuring Unit";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
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

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

