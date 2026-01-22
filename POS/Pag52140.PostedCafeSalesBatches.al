page 52140 "Posted Cafe Sales Batches"
{
    Caption = 'Posted Cafe Sales Batches';
    PageType = List;
    SourceTable = "Cafeteria Sales Batches";
    SourceTableView = where("Batch Status" = filter(Posted));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = All;
    UsageCategory = History;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(User_Id; Rec.User_Id)
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                    ToolTip = 'Specifies the user ID for this batch.';
                }
                field(Batch_Date; Rec.Batch_Date)
                {
                    ApplicationArea = All;
                    Caption = 'Batch Date';
                    ToolTip = 'Specifies the date of the batch.';
                }
                field(Batch_Id; Rec.Batch_Id)
                {
                    ApplicationArea = All;
                    Caption = 'Batch ID';
                    ToolTip = 'Specifies the batch identifier.';
                }
                field("Batch Status"; Rec."Batch Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the batch.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(PostBatch)
            {
                ApplicationArea = All;
                Caption = 'Post Batch';
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                ToolTip = 'Post the selected receipt batch to the journal.';

                trigger OnAction()
                var
                    POSSalesHeader: Record "POS Sales Header"; // Table 99408
                    BatchNotOpenErr: Label 'Batch is not open.';
                    NoReceiptsErr: Label 'No receipts associated with this batch';
                    ConfirmPostMsg: Label 'Post receipt Batches?';
                    CancelledByUserErr: Label 'Cancelled by user!';
                begin
                    if Rec."Batch Status" <> Rec."Batch Status"::New then
                        Error(BatchNotOpenErr);

                    Rec.CalcFields("Un-posted Receipts");
                    if Rec."Un-posted Receipts" = 0 then
                        Error(NoReceiptsErr);

                    if not Confirm(ConfirmPostMsg, true) then
                        Error(CancelledByUserErr);

                    POSSalesHeader.PostReceiptToJournal(Rec);
                    CurrPage.Update();
                end;
            }
            action(UnPostedReceipts)
            {
                ApplicationArea = All;
                Caption = 'Un-Posted Receipts';
                Image = UntrackedQuantity;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "POS Receipts Header Lst";
                RunPageView = where("Receipt Posted to Ledger" = filter(false),
                                    Posted = filter(true),
                                    "Receipt Amount" = filter(<> 0));
                RunPageLink = "Posting date" = field(Batch_Date),
                              Cashier = field(User_Id),
                              Batch_Id = field(Batch_Id);
                ToolTip = 'View receipts that have not been posted to the ledger.';
            }
            action(PostedReceipts)
            {
                ApplicationArea = All;
                Caption = 'Posted Receipts';
                Image = CompareContacts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "POS Receipts Header Lst";
                RunPageView = where("Receipt Posted to Ledger" = filter(true),
                                    Posted = filter(true),
                                    "Receipt Amount" = filter(<> 0));
                RunPageLink = "Posting date" = field(Batch_Date),
                              Cashier = field(User_Id),
                              Batch_Id = field(Batch_Id);
                ToolTip = 'View receipts that have been posted to the ledger.';
            }
            action(AllReceipts)
            {
                ApplicationArea = All;
                Caption = 'All Receipts';
                Image = AddToHome;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "POS Receipts Header Lst";
                RunPageView = where(Posted = filter(true),
                                    "Receipt Amount" = filter(> 0));
                RunPageLink = "Posting date" = field(Batch_Date),
                              Cashier = field(User_Id),
                              Batch_Id = field(Batch_Id);
                ToolTip = 'View all receipts for this batch.';
            }
        }
    }
}