page 52179056 "Foundation Pledge Card"
{
    PageType = Card;
    SourceTable = "Foundation Pledge";
    Caption = 'Foundation Pledge Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Donor No."; Rec."Donor No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Donor Name"; Rec."Donor Name")
                {
                    ApplicationArea = All;
                }
                field("Pledge Date"; Rec."Pledge Date")
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            
            group(Details)
            {
                Caption = 'Details';
                
                field("Purpose"; Rec."Purpose")
                {
                    ApplicationArea = All;
                }
                field("Campaign Code"; Rec."Campaign Code")
                {
                    ApplicationArea = All;
                }
                field("Frequency"; Rec."Frequency")
                {
                    ApplicationArea = All;
                }
                field("Next Payment Date"; Rec."Next Payment Date")
                {
                    ApplicationArea = All;
                }
                field("Installment Amount"; Rec."Installment Amount")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Fulfillment)
            {
                Caption = 'Fulfillment';
                
                field("Amount Received"; Rec."Amount Received")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Last Payment Date"; Rec."Last Payment Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(CreateDonation)
            {
                ApplicationArea = All;
                Caption = 'Create Donation';
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                var
                    DonationPage: Page "Foundation Donation Card";
                    DonationRec: Record "Foundation Donation";
                begin
                    DonationRec.Init();
                    DonationRec."Donor No." := Rec."Donor No.";
                    DonationRec."Pledge No." := Rec."No.";
                    DonationRec."Amount" := Rec."Installment Amount";
                    DonationRec."Purpose" := Rec."Purpose";
                    DonationRec."Campaign Code" := Rec."Campaign Code";
                    DonationPage.SetRecord(DonationRec);
                    DonationPage.Run();
                end;
            }
        }
    }
}