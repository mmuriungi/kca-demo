page 52117 "Item Transfer lines"
{
    Caption = 'Item Transfer Lines';
    PageType = ListPart;
    SourceTable = "Item Transfer Line";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }

                field("Location From Code"; Rec."Location From Code")
                {
                    ApplicationArea = All;
                }

                field("Location To Code"; Rec."Location To Code")
                {
                    ApplicationArea = All;
                }

                field("Quantity Available"; Rec."Quantity Available")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }

                field("Quantity to Transfer"; Rec."Quantity to Transfer")
                {
                    ApplicationArea = All;
                    Style = Attention;
                }

                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }

                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
