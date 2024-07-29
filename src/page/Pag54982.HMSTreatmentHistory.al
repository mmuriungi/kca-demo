page 54982 "HMS Treatment History"
{
    PageType = ListPart;
    SourceTable = "HMS-Treatment History";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("History Code"; Rec."History Code")
                {
                    ApplicationArea = All;
                }
                field("History Name"; Rec."History Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("History Value"; Rec."History Value")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

