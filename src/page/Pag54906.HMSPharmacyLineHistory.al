page 54906 "HMS Pharmacy Line History"
{
    PageType = Document;
    SourceTable = "HMS-Pharmacy Line";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field("Drug No."; Rec."Drug No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Drug Name"; Rec."Drug Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Measuring Unit"; Rec."Measuring Unit")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Actual Qty"; Rec."Actual Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Actual Price"; Rec."Actual Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Issued Quantity"; Rec."Issued Quantity")
                {
                    ApplicationArea = All;
                }
                field("Issued Units"; Rec."Issued Units")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Issued Price"; Rec."Issued Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Dosage; Rec.Dosage)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

