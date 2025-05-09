page  52178745 "Cust Ledger Entries Cust"
{
    ApplicationArea = All;
    Caption = 'Cust Ledger Entries Custom';
    PageType = List;
    UsageCategory=Administration;
    SourceTable = "Cust Ledger Entries Custom";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                 field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field(Posted;Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
               
            }
        }
        
        
    }
    actions
{
    area(Processing)
    {
        action(PostToGL)
        {
            ApplicationArea = All;
            Caption = 'Post to G/L';
            Image = PostBatch;
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
            ToolTip = 'Post unposted entries to General Ledger';
            
            trigger OnAction()
            var
                PostCustLedgerReport: Report "Post Customer Ledger Entries";
            begin
                PostCustLedgerReport.RunModal();
                CurrPage.Update(false);
            end;
        }
    }
}
}
