page 52178550 "Proc-Consultancy Services List"
{
    Caption = 'Consultancy Services List';
    PageType = List;
    Editable = false;
    DeleteAllowed = false;
    SourceTable = "PROC-Purchase Quote Header";
    SourceTableView = where(DocApprovalType = const(Purchase), "Procurement methods" = const("Consultancy Services"));
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
