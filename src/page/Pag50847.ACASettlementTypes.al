page 50847 "ACA-Settlement Types"
{
    PageType = List;
    SourceTable = "ACA-Settlement Type";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Tuition G/L Account"; Rec."Tuition G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Reg. No Prefix"; Rec."Reg. No Prefix")
                {
                    ApplicationArea = All;
                }
                field(Installments; Rec.Installments)
                {
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

