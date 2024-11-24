page 52178612 "RFQ Category Suppliers"
{
    PageType = Worksheet;
    Editable = true;
    SourceTable = "RFQ Suppliers Category";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Select field.';
                }
                field("Supplier No"; Rec."Supplier No")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier No field.';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field.';
                }
                field(Email; Rec.Email)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Telephone No."; Rec."Telephone No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Telephone No. field.';
                }
                field("Prequalification Period"; Rec."Prequalification Period")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prequalification Period field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Submit")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                image = SuggestCustomerBill;
                trigger OnAction()
                begin
                    Rec.SubmitSelected();
                    CurrPage.Close();
                end;
            }
        }
    }
}