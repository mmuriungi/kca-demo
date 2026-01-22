page 50229 "Disposal Plan Table Line"
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
                field("No."; Rec."No.")
                {
                }
                field("Sub. Ref. No."; Rec."Sub. Ref. No.")
                {
                    Visible = false;
                }
                field("Item description"; Rec."Item description")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Unit of Issue"; Rec."Unit of Issue")
                {
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Planned Date"; Rec."Planned Date")
                {
                    Visible = false;
                }
                field(Department; Rec.Department)
                {
                    Caption = 'Directorate';
                }
                field(County; Rec.County)
                {
                    Caption = 'Department';
                }
                field(Approved; Rec.Approved)
                {
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Item/Tag No"; Rec."Item/Tag No")
                {
                    Visible = true;
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

