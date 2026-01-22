page 51444 "Visitor Personal Items"
{
    PageType = ListPart;
    SourceTable = "Visitor Personal Items";
    Caption = 'Visitor Personal Items';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Code"; Rec."Item Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field(Cleared; Rec.Cleared)
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

