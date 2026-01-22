page 50789 "ACA-Applic. Setup District Lis"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "ACA-Applic. Setup County";

    layout
    {
        area(content)
        {
            repeater(__)
            {
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

