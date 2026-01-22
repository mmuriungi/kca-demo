page 50237 "Disposal plan List"
{
    PageType = ListPart;
    SourceTable = "Disposal plan table lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ref. No."; Rec."Ref. No.")
                {
                    Visible = false;
                }
                field("Sub. Ref. No."; Rec."Sub. Ref. No.")
                {
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                }
                field("Item description"; Rec."Item description")
                {
                }
                field("Unit of Issue"; Rec."Unit of Issue")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Planned Date"; Rec."Planned Date")
                {
                }
                field("Disposal Method"; Rec."Disposal Method")
                {
                }
                field(Department; Rec.Department)
                {
                }
                field(County; Rec.County)
                {
                }
                field(Approved; Rec.Approved)
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Item/Tag No"; Rec."Item/Tag No")
                {
                    Visible = true;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                }
                field("Serial No"; Rec."Serial No")
                {
                }
                field("Disposal Period"; Rec."Disposal Period")
                {
                }
            }
        }
    }

    actions
    {
    }
}

