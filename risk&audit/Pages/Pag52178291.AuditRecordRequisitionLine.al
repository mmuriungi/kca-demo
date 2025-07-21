page 50187 "Audit Record Requisition Line"
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
                field("Assessment Rating"; Rec."Assessment Rating")
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
                field("Scheduled Start Date"; Rec."Scheduled Start Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Scheduled End Date"; Rec."Scheduled End Date")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
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

