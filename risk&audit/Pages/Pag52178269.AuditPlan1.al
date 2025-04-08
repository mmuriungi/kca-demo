page 52178269 "Audit Plan 1"
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
                field(Description; Description)
                {
                }
                field("Risk Rating"; "Risk Rating")
                {
                }
            }
        }
    }

    actions
    {
    }
}

