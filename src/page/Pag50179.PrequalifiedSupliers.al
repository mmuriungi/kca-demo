page 50179 "Prequalified Supliers"
{
    Caption = 'Prequalified Supliers';
    PageType = ListPart;
    SourceTable = "Preq Suppliers/Category";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Supplier_Code; Rec.Supplier_Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier_Code field.';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field.';
                }
                field("RFQ Placed"; Rec."RFQ Placed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RFQ Placed field.';
                }
                field("Quoted Received "; Rec."Quoted Received ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quoted Received  field.';
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone field.';
                }
                field("Lpos Placed"; Rec."Lpos Placed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lpos Placed field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
            }
        }
    }
}
