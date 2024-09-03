// Page: Equipment Issuance
page 52016 "Equipment Issuance"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Equipment Issuance";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("User Type"; Rec."User Type")
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                }
                field("Game Code"; Rec."Game Code")
                {
                    ApplicationArea = All;
                }
                field("Game Name"; Rec."Game Name")
                {
                    ApplicationArea = All;
                }
                                field("Receipient No.";Rec."Receipient No.")
                {
                    ApplicationArea = All;
                }
                field("Receipient Name";Rec."Receipient Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
