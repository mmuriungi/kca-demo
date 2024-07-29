page 54834 "HMS-Blood Group Donation List"
{
    PageType = List;
    SourceTable = "HMS-Setup Blood Donation";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
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

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

