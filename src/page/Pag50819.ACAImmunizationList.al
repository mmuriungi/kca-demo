page 50819 "ACA-Immunization List"
{
    PageType = List;
    SourceTable = "ACA-Immunization";

    layout
    {
        area(content)
        {
            repeater(general)
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
                field(Mandatory; Rec.Mandatory)
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

