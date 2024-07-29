page 50189 "Proc-Low Value List"
{
    CardPageId = "Proc-Low Value Card";
    Caption = 'Low Value List';
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "PROC-Purchase Quote Header1";
    SourceTableView = where(DocApprovalType = const(Purchase), "Procurement methods" = const("Low Value Procurement"));

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
