#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 99411 "POS Sales Lines"
{
    PageType = ListPart;
    SourceTable = "POS Sales Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Line Total"; Rec."Line Total")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

