page 50340 "Memo PRN Details"
{
    PageType = ListPart;
    SourceTable = "Memo PRN Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = true;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

