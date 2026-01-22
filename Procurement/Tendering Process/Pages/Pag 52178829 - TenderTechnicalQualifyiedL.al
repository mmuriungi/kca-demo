page 52178829 "Tender Technical QualifyiedL"
{
    CardPageID = "Tender Technical QualifyiedC";
    Editable = false;
    PageType = List;
    SourceTable = "Tender Header";
    //SourceTableView = where("Bid Status" = filter("Prelim Disqualif"));

    layout
    {
        area(content)
        {
            repeater(___)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Expected Opening Date"; Rec."Expected Opening Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Closing Date"; Rec."Expected Closing Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                }

                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {

    }

    var
        PurchHeader: Record "Purchase Header";
        PParams: Record "PROC-Purchase Quote Params";
        Lines: Record "PROC-Purchase Quote Line";
        PQH: Record "PROC-Purchase Quote Header";
        repVend: Report "Purchase Quote Report";
        RFQ: Code[10];
        Purchaselines: Record "Purchase Line";
        GETLINES: Page "PROC-PRF Lines";
}