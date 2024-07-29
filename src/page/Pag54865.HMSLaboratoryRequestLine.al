page 54865 "HMS-Laboratory Request Line"
{
    PageType = ListPart;
    SourceTable = "HMS-Laboratory Test Line";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Laboratory Test Code"; Rec."Laboratory Test Code")
                {
                    ApplicationArea = All;
                }
                field("Laboratory Test Name"; Rec."Laboratory Test Name")
                {
                    ApplicationArea = All;
                }
                field("Specimen Code"; Rec."Specimen Code")
                {
                    ApplicationArea = All;
                }
                field("Specimen Name"; Rec."Specimen Name")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
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

