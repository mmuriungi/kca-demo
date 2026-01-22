// Page: Recent Donations
page 50326 "Recent Donations"
{
    PageType = ListPart;
    SourceTable = Donation;
    Caption = 'Recent Donations';
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Donor No."; Rec."Donor No.")
                {
                    ApplicationArea = All;
                }
                field("Donation Date"; Rec."Donation Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Campaign Code"; Rec."Campaign Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Donation Date", CalcDate('<-30D>', WorkDate()), WorkDate());
        Rec.SetCurrentKey("Donation Date");
        Rec.Ascending(false);
    end;
}
