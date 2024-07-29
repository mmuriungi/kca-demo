/// <summary>
/// Page TT-Unit Spec. Weighting (ID 74515).
/// </summary>
page 52489 "TT-Unit Spec. Weighting"
{
    Caption = 'Unit Specific Weighting';
    PageType = List;
    SourceTable = "TT-Unit Spec. Weighting";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Weighting Category"; Rec."Weighting Category")
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

