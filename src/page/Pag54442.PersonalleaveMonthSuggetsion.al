page 54442 "Personal leave-MonthSuggetsion"
{
    Caption = 'Personal leave-Month suggetsion';
    PageType = ListPart;
    SourceTable = "Leave RoasterMonth suggestion";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Code"; Rec."Suggestion No")
                {
                    Caption = 'Suggestion No';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Month Description"; Rec."leave Month")
                {
                    ApplicationArea = all;
                }
                field("proposed no of days"; Rec."proposed no of days")
                {

                }
                field("Purpose"; Rec.Purpose)
                {
                    ApplicationArea = all;
                }
                field(Cleared; Rec.Priority)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}
