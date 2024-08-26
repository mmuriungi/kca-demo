page 51056 "Lect Load Central Setup"
{
    PageType = List;
    SourceTable = "Lect Load Central Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Part-Time Charge"; Rec."Part-Time Charge")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Part-Time Expenses Account"; Rec."Part-Time Expenses Account")
                {
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = All;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
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

