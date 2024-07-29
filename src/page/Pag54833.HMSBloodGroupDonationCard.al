page 54833 "HMS-Blood Group Donation Card"
{
    PageType = Card;
    SourceTable = "HMS-Setup Blood Donation";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(Donor; Rec.Donor)
                {
                    ApplicationArea = All;
                }
                field(Recipient; Rec.Recipient)
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

