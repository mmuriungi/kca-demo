page 50896 "ACA-Student Picture"
{
    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group("Student Picture")
            {
                field(Picture; Rec.Image)
                {
                    ApplicationArea = All;
                }
                field("Barcode/QR Code"; Rec."Barcode Picture")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

