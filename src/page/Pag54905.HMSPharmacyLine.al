page 54905 "HMS Pharmacy Line"
{
    PageType = ListPart;
    SourceTable = "HMS-Pharmacy Line";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Pharmacy No."; Rec."Pharmacy No.")
                {
                    ApplicationArea = All;
                }
                field("Drugs Category"; Rec."Drugs Category")
                {
                    ApplicationArea = All;
                }
                field(Pharmacy; Rec.Pharmacy)
                {
                    ApplicationArea = All;
                }
                field("Drug No."; Rec."Drug No.")
                {
                    ApplicationArea = All;
                }
                field("Drug Name"; Rec."Drug Name")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Dosage1; Rec.Dosage)
                {
                    ApplicationArea = All;
                }
                field("Measuring Unit"; Rec."Measuring Unit")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Actual Qty"; Rec."Actual Qty")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Actual Price"; Rec."Actual Price")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Issued Quantity"; Rec."Issued Quantity")
                {
                    ApplicationArea = All;
                }
                field("Issued Units"; Rec."Issued Units")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Issued Price"; Rec."Issued Price")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Dosage; Rec.Dosage)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("No Stock Drugs"; Rec."No Stock Drugs")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

