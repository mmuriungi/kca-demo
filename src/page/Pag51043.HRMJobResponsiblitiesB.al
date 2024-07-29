page 51043 "HRM-Job Responsiblities (B)"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Caption = 'Job Responsiblities';
    PageType = List;
    SourceTable = "HRM-Job Responsiblities (B)";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Responsibility Code"; Rec."Responsibility Code")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Description"; Rec."Responsibility Description")
                {
                    ApplicationArea = all;
                }
                field(Remarks; Rec.Remarks)
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

