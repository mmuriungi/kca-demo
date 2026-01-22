page 50232 "Disposal Line"
{
    PageType = ListPart;
    SourceTable = "Disposal Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Item/Tag No"; Rec."Item/Tag No")
                {
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field("Disposal Plan No."; Rec."Disposal Plan No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Planned Quantity"; Rec."Planned Quantity")
                {
                }
                field("Actual Disposal Price"; Rec."Actual Disposal Price")
                {
                }
                field("Total Price"; Rec."Total Price")
                {
                }
                field(Date; Rec.Date)
                {
                    Visible = false;
                }
                field(Disposed; Rec.Disposed)
                {
                    Visible = false;
                }
                field(County; Rec.Department)
                {
                    Caption = 'Directorate';
                }
                field(Department; Rec.County)
                {
                    Caption = 'Department';
                }
                field("Disposal Methods"; Rec."Disposal Methods")
                {
                }
                field("Actual Quantity"; Rec."Actual Quantity")
                {
                }
                field("Disposed To"; Rec."Disposed To")
                {
                }
                field("Reserved Price"; Rec."Reserved Price")
                {
                    Visible = false;
                }
                field(Confirmed; Rec.Confirmed)
                {
                }
                field("Confirmed By"; Rec."Confirmed By")
                {
                }
                field("Disposal Period"; Rec."Disposal Period")
                {
                }
                field("Serial No"; Rec."Serial No")
                {
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

