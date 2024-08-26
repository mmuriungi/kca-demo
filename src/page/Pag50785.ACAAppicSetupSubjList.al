page 50785 "ACA-Appic. Setup Subj. List"
{
    Editable = true;
    PageType = List;
    SourceTable = "ACA-Applic. Setup Subjects";

    layout
    {
        area(content)
        {
            repeater(___)
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

