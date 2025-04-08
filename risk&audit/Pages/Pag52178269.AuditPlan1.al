page 50107 "Audit Plan 1"
{
    AutoSplitKey = true;
    PageType = ListPlus;
    SourceTable = "Audit Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                }
                field("Risk Rating"; Rec."Risk Rating")
                {
                }
            }
        }
    }

    actions
    {
    }
}

