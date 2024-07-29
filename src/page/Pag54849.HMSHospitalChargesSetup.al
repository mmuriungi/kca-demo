page 54849 "HMS-Hospital Charges Setup"
{
    PageType = List;
    SourceTable = "HMS-Class Setups";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                }
                field("Charge Name"; Rec."Charge Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
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

