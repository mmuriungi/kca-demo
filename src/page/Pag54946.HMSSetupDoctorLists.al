page 54946 "HMS-Setup Doctor Lists"
{
    PageType = List;
    SourceTable = "HMS-Setup Doctor";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Doctor's Name"; Rec."Doctor's Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

