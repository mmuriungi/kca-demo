page 54842 "HMS Drug Interaction Line"
{
    PageType = ListPart;
    SourceTable = "HMS-Drug Interaction";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Drug No. 1"; Rec."Drug No. 1")
                {
                    ApplicationArea = All;
                }
                field("Drug Name 1"; Rec."Drug Name 1")
                {
                    ApplicationArea = All;
                }
                field("Not Compatible"; Rec."Not Compatible")
                {
                    ApplicationArea = All;
                }
                field("Alert Remarks"; Rec."Alert Remarks")
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

