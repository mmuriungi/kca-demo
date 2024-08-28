page 51228 "Posted Cafe Receipt Lines"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Sales Shipment Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                Enabled = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Enabled = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    Enabled = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
    }
}

