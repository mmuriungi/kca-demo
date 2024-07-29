page 54878 "HMS Observation Signs"
{
    PageType = ListPart;
    SourceTable = "HMS-Observation Signs";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(System; Rec.System)
                {
                    ApplicationArea = All;
                }
                field("Sign Code"; Rec."Sign Code")
                {
                    ApplicationArea = All;
                }
                field("Sign Description"; Rec."Sign Description")
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

