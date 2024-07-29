page 52018 "ACA-Library Codes"
{
    Editable = false;
    PageType = List;
    SourceTable = "ACA-Library Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lib Code"; Rec."Lib Code")
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
}

