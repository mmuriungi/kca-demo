page 50931 "PRL-Bank Structure (B)"
{
    Editable = true;
    PageType = Card;
    SourceTable = "PRL-Bank Structure";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = all;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = all;
                }
                field("KBA Branch Code"; Rec."KBA Branch Code")
                {
                    ApplicationArea = all;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = all;
                }
                field("Branch Name"; Rec."Branch Name")
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

