page 51273 "CAT-Food Menu List"
{
    PageType = ListPart;
    SourceTable = "CAT-Food Menu";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Units Of Measure"; Rec."Units Of Measure")
                {
                }
            }
        }
    }

    actions
    {
    }
}

