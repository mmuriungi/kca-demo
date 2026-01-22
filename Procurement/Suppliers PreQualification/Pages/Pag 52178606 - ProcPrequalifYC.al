page 52178606 "Proc-Prequalif.YC"
{
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "Proc-Prequalif. Categories";
    PromotedActionCategories = 'New, Update';

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("Category Code"; Rec."Category Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Code field.';
                }
                field("Preq Year"; Rec."Preq Year")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq Year field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Preq. Suppliers"; Rec."Preq. Suppliers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq. Suppliers field.';
                }

            }
            part(Suppliers; "Proc-Preq. Suppliers/Category")
            {
                ApplicationArea = All;
                SubPageLink = "Preq. Year" = field("Preq Year"), "Preq. Category" = field("Category Code");
            }
        }


    }


}