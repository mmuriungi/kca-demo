page 52179059 "Foundation Donor FactBox"
{
    PageType = CardPart;
    SourceTable = "Foundation Donor";
    Caption = 'Foundation Donor FactBox';
    
    layout
    {
        area(Content)
        {
            group(DonorInfo)
            {
                Caption = 'Donor Information';
                
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Donor No.';
                    
                    trigger OnDrillDown()
                    begin
                        PAGE.Run(PAGE::"Foundation Donor Card", Rec);
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Donor Type"; Rec."Donor Type")
                {
                    ApplicationArea = All;
                }
                field("Donor Category"; Rec."Donor Category")
                {
                    ApplicationArea = All;
                }
                field("Total Donations"; Rec."Total Donations")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    
                    trigger OnDrillDown()
                    var
                        DonationList: Page "Foundation Donation List";
                        DonationRec: Record "Foundation Donation";
                    begin
                        DonationRec.SetRange("Donor No.", Rec."No.");
                        DonationList.SetTableView(DonationRec);
                        DonationList.Run();
                    end;
                }
                field("No. of Donations"; Rec."No. of Donations")
                {
                    ApplicationArea = All;
                }
                field("Last Donation Date"; Rec."Last Donation Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}