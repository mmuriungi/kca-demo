report 50657 "CAT-Meals Recipe Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CAT-Meals Recipe Report.rdl';

    dataset
    {
        dataitem("CAT-Meals Setup"; "CAT-Meals Setup")
        {
            PrintOnlyIfDetail = true;
            column(pic; info.Picture)
            {
            }
            column(seq; seq)
            {
            }
            column(comp; 'KARATINA UNIVERSITY')
            {
            }
            column(tittle; 'MEAL RECIPE')
            {
            }
            column(CompName; info.Name)
            {
            }
            column(CompAddress; info.Address)
            {
            }
            column(CompPhone; info."Phone No.")
            {
            }
            column(CompMail; info."E-Mail")
            {
            }
            column(CompHomePage; info."Home Page")
            {
            }
            column(MealCode; "CAT-Meals Setup".Code)
            {
            }
            column(Desc; "CAT-Meals Setup".Discription)
            {
            }
            column(bonapettie; '***************************************** BON APETTIE *****************************************')
            {
            }
            column(RecipeCost; "CAT-Meals Setup"."Recipe Cost")
            {
            }
            column(RecipePrice; "CAT-Meals Setup"."Recipe Price")
            {
            }
            dataitem("Meals Recipe"; "Meals Recipe")
            {
                DataItemLink = "Meal Code" = FIELD("Code");
                column(Type; "Meals Recipe"."Resource Type")
                {
                }
                column(Resource; "Meals Recipe".Resource)
                {
                }
                column(Name; "Meals Recipe"."Resource Name")
                {
                }
                column(Qty; "Meals Recipe".Quantity)
                {
                }
                column(UnitCost; "Meals Recipe"."Unit Cost")
                {
                }
                column(Markup; "Meals Recipe"."Markup %")
                {
                }
                column(UnitPrice; "Meals Recipe"."Unit Price")
                {
                }
                column(FinalCost; "Meals Recipe"."Final Cost")
                {
                }
                column(FinalPrice; "Meals Recipe"."Final Price")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        DateFilter := TODAY;
    end;

    trigger OnPreReport()
    begin
        info.RESET;
        IF info.FIND('-') THEN BEGIN
            info.CALCFIELDS(info.Picture);
        END;
        CLEAR(seq);
    end;

    var
        DateFilter: Date;
        CafeSections: Option " ",Students,Staff;
        info: Record "Company Information";
        seq: Integer;
}

