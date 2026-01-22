page 52178552 "Proc-Purchase Direct List"
{
    CardPageID = "PROC-Purchase Direct Header";
    Editable = false;
    PageType = List;
    SourceTable = "PROC-Purchase Quote Header";
    SourceTableView = where(DocApprovalType = const(Purchase), "Procurement methods" = const("Direct Procurement"));
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
            }
        }
    }

}