page 54245 "Casual Tiers."
{
    PageType = List;
    SourceTable = "Casual Tiers.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Occupation Code"; Rec."Occupation Code")
                {
                    ApplicationArea = All;
                }
                field("Occupation Description"; Rec."Occupation Description")
                {
                    ApplicationArea = All;
                }
                field("Rate Per Month"; Rec."Rate Per Month")
                {
                    ApplicationArea = All;
                }
                field("Rate per Day"; Rec."Rate per Day")
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

