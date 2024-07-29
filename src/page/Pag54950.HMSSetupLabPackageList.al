page 54950 "HMS-Setup Lab Package List"
{
    PageType = List;
    SourceTable = "HMS-Setup Lab Package";

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

