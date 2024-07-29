page 54945 "HMS-Setup Doctor Card"
{
    PageType = Card;
    SourceTable = "HMS-Setup Doctor";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Doctor's Name"; Rec."Doctor's Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

