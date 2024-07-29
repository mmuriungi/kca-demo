page 50120 "PROC-Procurement Plan Lines"
{
    PageType = ListPart;
    SourceTable = "PROC-Procurement Plan Lines";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(Type; Rec.Type)
                {
                }
                field("Type No"; Rec."Type No")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Category; Rec.Category)
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Remaining Qty"; Rec."Remaining Qty")
                {
                }
                field("Procurement Plan Period"; Rec."Procurement Plan Period")
                {
                    ToolTip = 'Specifies the value of the Procurement Plan Period field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

