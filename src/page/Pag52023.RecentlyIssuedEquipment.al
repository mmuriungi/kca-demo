
// Page: Recently Issued Equipment
page 52023 "Recently Issued Equipment"
{
    PageType = ListPart;
    SourceTable = "Equipment Issuance";
    Caption = 'Recently Issued Equipment';

    layout
    {
        area(content)
        {
            repeater(RecentIssuances)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Status, Rec.Status::Issued);
        Rec.SetCurrentKey("Issue Date");
        Rec.SetAscending("Issue Date", false);
        Rec.SetRange("Issue Date", CalcDate('<-30D>', Today), Today);
    end;
}