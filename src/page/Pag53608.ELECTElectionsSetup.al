/// <summary>
/// Page ELECT-Elections Setup (ID 60024).
/// </summary>
page 53608 "ELECT-Elections Setup"
{
    PageType = Card;
    SourceTable = "ELECT-Elections Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Current Election"; Rec."Current Election")
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

