page 50115 "Audit Subform"
{
    PageType = ListPart;
    SourceTable = "Audit Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Audit Code"; Rec."Audit Code")
                {
                    ApplicationArea = All;
                }
                field("Audit Description"; Rec."Audit Description")
                {
                    ApplicationArea = All;
                }
                field("Audit Type"; Rec."Audit Type")
                {
                    ApplicationArea = All;
                }
                field("Audit Type Description"; Rec."Audit Type Description")
                {
                    ApplicationArea = All;
                }
                field("Assessment Rating"; Rec."Assessment Rating")
                {
                    ApplicationArea = All;
                }
                field("Scheduled End Date"; Rec."Scheduled End Date")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Start Date"; Rec."Scheduled Start Date")
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

