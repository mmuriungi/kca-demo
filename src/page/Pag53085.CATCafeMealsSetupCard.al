page 53085 "CAT-Cafe. Meals Setup Card"
{
    PageType = Card;
    SourceTable = "CAT-Meals Setup";

    layout
    {
        area(content)
        {
            group("Meals Setup")
            {
                field(Code; Rec.Code)
                {
                }
                field(Discription; Rec.Discription)
                {
                }
                field(Price; Rec.Price)
                {
                }
                field(Category; Rec.Category)
                {
                }
                field("Food Value"; Rec."Food Value")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Active; Rec.Active)
                {
                }
                field("Exclude in Summary"; Rec."Exclude in Summary")
                {
                }
                field("Recipe Cost"; Rec."Recipe Cost")
                {
                    Editable = false;
                }
                field("Recipe Price"; Rec."Recipe Price")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Recipe Setup")
            {
                Caption = 'Recipe Setup';
                Image = SetupPayment;
                Promoted = true;
                PromotedIsBig = true;
                // RunObject = Page "Meals Recipe";
                //  RunPageLink = "Meal Code"=FIELD(Code);
            }
            action("Update Meal Price from Recipe")
            {
                Caption = 'Update Meal Price from Recipe';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF CONFIRM('This will update the set prices with computed Prices from the Recipe, Continue?', FALSE) = FALSE THEN
                        ERROR('Cancelled by User!');

                    Rec.CALCFIELDS("Recipe Cost", "Recipe Price");
                    Rec.Price := Rec."Recipe Price";
                    Rec.MODIFY;
                    CurrPage.UPDATE;
                end;
            }
            action("Recipe Report")
            {
                Caption = 'Recipe Report';
                Image = AddWatch;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "CAT-Meals Recipe Report";
            }
        }
    }
}

