page 51216 "FRM Vital Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "FRM Vital Setup";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Card Charges"; Rec."Card Charges")
                {
                }
                field("Farmer Nos."; Rec."Farmer Nos.")
                {
                }
                field("Milk Collection Nos."; Rec."Milk Collection Nos.")
                {
                }
                field("Minimum Shares"; Rec."Minimum Shares")
                {
                }
                field("Maximum Shares"; Rec."Maximum Shares")
                {
                }
                field("Raw Milk Item journal Temp."; Rec."Raw Milk Item journal Temp.")
                {
                }
                field("Raw Milk Item Journal Batch"; Rec."Raw Milk Item Journal Batch")
                {
                }
                field("Share Market Value"; Rec."Share Market Value")
                {
                }
                field("Milk Reception Store"; Rec."Milk Reception Store")
                {
                }
                field("Temporary In-Transit Location"; Rec."Temporary In-Transit Location")
                {
                }
                field("Milk Invoice Numbers"; Rec."Milk Invoice Numbers")
                {
                }
                field("Milk Collection Batch Nos."; Rec."Milk Collection Batch Nos.")
                {
                }
                field("Can Numbers"; Rec."Can Numbers")
                {
                }
                field("Farmer Application Nos."; Rec."Farmer Application Nos.")
                {
                }
                field("Farmer Registration Nos."; Rec."Farmer Registration Nos.")
                {
                }
                field("Farmer General Bus. Posting G."; Rec."Farmer General Bus. Posting G.")
                {
                }
                field("Farmer (Cust. Posting Group)"; Rec."Farmer (Cust. Posting Group)")
                {
                }
                field("Farmer (Supp. Posting Group)"; Rec."Farmer (Supp. Posting Group)")
                {
                }
                field("Farmer Milk Collection Nos."; Rec."Farmer Milk Collection Nos.")
                {
                }
                field("Net Payment Code"; Rec."Net Payment Code")
                {
                }
                field("Milk Collection Code"; Rec."Milk Collection Code")
                {
                }
                field("Farmer Company Nos."; Rec."Farmer Company Nos.")
                {
                }
                field("Farmer Application Approver"; Rec."Farmer Application Approver")
                {
                }
                field("Collection Dispatch Nos."; Rec."Collection Dispatch Nos.")
                {
                }
                field("Milk Payment Account"; Rec."Milk Payment Account")
                {
                }
                field("Raw Milk Item No"; Rec."Raw Milk Item No")
                {
                }
                field("Milk Receiving No. Series"; Rec."Milk Receiving No. Series")
                {
                }
                field("Milk Posting No. Series"; Rec."Milk Posting No. Series")
                {
                }
                field("Credit Sales Transaction Code"; Rec."Credit Sales Transaction Code")
                {
                }
                field("Dividents Code"; Rec."Dividents Code")
                {
                }
                field("Pending Credit Sales Code"; Rec."Pending Credit Sales Code")
                {
                }
                field("Invt. Posting Group Code"; Rec."Invt. Posting Group Code")
                {
                }
                field("Inventory Account"; Rec."Inventory Account")
                {
                }
                field("Inventory Account (Interim)"; Rec."Inventory Account (Interim)")
                {
                }
                field("WIP Account"; Rec."WIP Account")
                {
                }
                field("Material Variance Account"; Rec."Material Variance Account")
                {
                }
                field("Capacity Variance Account"; Rec."Capacity Variance Account")
                {
                }
                field("Mfg. Overhead Variance Account"; Rec."Mfg. Overhead Variance Account")
                {
                }
                field("Cap. Overhead Variance Account"; Rec."Cap. Overhead Variance Account")
                {
                }
                field("Subcontracted Variance Account"; Rec."Subcontracted Variance Account")
                {
                }
                field("Farmer Payment Template"; Rec."Farmer Payment Template")
                {
                }
                field("Farmer Payment Batch"; Rec."Farmer Payment Batch")
                {
                }
                field("Milk Approval Start Time"; Rec."Milk Approval Start Time")
                {
                }
                field("Default Customer Farmer"; Rec."Default Customer Farmer")
                {
                }
                field("VET Credit Trans no."; Rec."VET Credit Trans no.")
                {
                }
                field("Stores Credit Trans no."; Rec."Stores Credit Trans no.")
                {
                }
                field("Lab. Credit Trans no."; Rec."Lab. Credit Trans no.")
                {
                }
                field("Registration Fee Code"; Rec."Registration Fee Code")
                {
                }
                field("Registration Fee Amount"; Rec."Registration Fee Amount")
                {
                }
                field("Use Period Instalments"; Rec."Use Period Instalments")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}