page 54966 "HMS Signs"
{
    PageType = List;
    SourceTable = "HMS-Signs Setup";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Sign Code"; Rec."Sign Code")
                {
                    ApplicationArea = All;
                }
                field("Signs Name"; Rec."Signs Name")
                {
                    ApplicationArea = All;
                }
                field(System; Rec.System)
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

