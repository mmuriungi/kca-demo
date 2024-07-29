page 54912 "HMS-Radiology Form Line"
{
    PageType = ListPart;
    SourceTable = "HMS-Radiology Form Line";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Radiology Type Code"; Rec."Radiology Type Code")
                {
                    ApplicationArea = All;
                }
                field("Radiology Type Name"; Rec."Radiology Type Name")
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

