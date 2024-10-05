page 50269 "Purchase Quote List"
{
    CardPageID = "PROC-Purchase Quot Req. Header";
    Editable = false;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "PROC-Purchase Quote Header";
    SourceTableView = where(DocApprovalType = const(Purchase), "Procurement methods" = const("Request for Quotation"));

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
                field("Posting Description"; Rec."Description")
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
}