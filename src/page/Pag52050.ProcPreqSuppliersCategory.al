page 52050 "Proc-Preq. Suppliers/Category"
{
    PageType = ListPart;
    SourceTable = "Proc-Preq. Suppliers/Category";

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field(Supplier_Code; Rec.Supplier_Code)
                {
                    ApplicationArea = All;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }

                field(Email; Rec.Email)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Agpo Categorization"; Rec."Agpo Categorization")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agpo Categorization field.';
                }



            }
        }
    }

    actions
    {
    }
}

