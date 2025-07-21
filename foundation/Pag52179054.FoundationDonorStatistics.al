page 52179054 "Foundation Donor Statistics"
{
    PageType = CardPart;
    SourceTable = "Foundation Donor";
    Caption = 'Foundation Donor Statistics';
    
    layout
    {
        area(Content)
        {
            group(Statistics)
            {
                Caption = 'Statistics';
                
                field("Total Donations"; Rec."Total Donations")
                {
                    ApplicationArea = All;
                    Caption = 'Total Donations';
                    DrillDown = true;
                    
                    trigger OnDrillDown()
                    begin
                        PAGE.Run(PAGE::"Foundation Donation List", Rec);
                    end;
                }
                field("No. of Donations"; Rec."No. of Donations")
                {
                    ApplicationArea = All;
                    Caption = 'Number of Donations';
                }
                field("Last Donation Date"; Rec."Last Donation Date")
                {
                    ApplicationArea = All;
                    Caption = 'Last Donation Date';
                }
                field("Active Pledges"; Rec."Active Pledges")
                {
                    ApplicationArea = All;
                    Caption = 'Active Pledges Amount';
                }
            }
        }
    }
}