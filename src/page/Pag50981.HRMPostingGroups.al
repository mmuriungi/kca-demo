page 50981 "HRM-Posting Groups"
{
    PageType = ListPart;
    SourceTable = "HRM-Posting Groups";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Posting Group"; Rec."Posting Group")
                {
                }
                field("Training Debit Account"; Rec."Training Debit Account")
                {
                }
                field("Training Credit A/C Type"; Rec."Training Credit A/C Type")
                {
                }
                field("Training Credit Account"; Rec."Training Credit Account")
                {
                }
                field("Comp. Act. Debit Account"; Rec."Comp. Act. Debit Account")
                {
                }
                field("Comp. Act. Credit A/C Type"; Rec."Comp. Act. Credit A/C Type")
                {
                }
                field("Comp. Act. Credit Account"; Rec."Comp. Act. Credit Account")
                {
                }
            }
        }
    }

    actions
    {
    }
}

