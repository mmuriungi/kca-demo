page 54841 "HMS Drug Interaction Header"
{
    PageType = Document;
    SourceTable = 27;

    layout
    {
        area(content)
        {
            group(gr)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(Part; "HMS Drug Interaction Line")
            {
                SubPageLink = "Drug No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

