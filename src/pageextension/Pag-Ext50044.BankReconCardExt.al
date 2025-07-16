pageextension 50044 "Bank Recon Card Ext" extends "Bank Acc. Reconciliation"
{
    layout
    {
        addafter(BankAccountNo)
        {

        }
    }




    actions
    {


        addafter("P&osting")
        {
            action("Post Reconciliation")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post Reconciliation';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Codeunit "bank Reconciliation Management";

                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
            }
            action("Receipts and Payments Report")
            {
                ApplicationArea = All;
                Caption = 'Receipts and Payments Report';
                Image = TestReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SetFilter("Statement No.", Rec."Statement No.");
                    Rec.SetFilter("Bank Account No.", Rec."Bank Account No.");


                    REPORT.RUN(50070, TRUE, TRUE, Rec);
                end;
            }

            action("&Test Report2")
            {

                Caption = 'Test Bank Rec. Report';
                Image = TestReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SetFilter("Statement No.", Rec."Statement No.");
                    Rec.SetFilter("Bank Account No.", Rec."Bank Account No.");
                    REPORT.RUN(50066, TRUE, TRUE, Rec);
                end;
            }
            action("Forward for verification")
            {
                ApplicationArea = all;
                trigger OnAction()
                begin
                    TransferToJournalVoucher(Rec);

                end;
            }

        }
    }
    // Transfer to Journal Voucher
    procedure TransferToJournalVoucher(Bankrecon: Record "Bank Acc. Reconciliation")
    var

        TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        JournalVoucherLine: Record "Journal Voucher Lines";
        JournalVoucherHeader: Record "Journal Voucher Headder";
        GenLedgerSetup: Record "Cash Office Setup";
        NextNo: Code[20];
        NoSeriesMgt: Codeunit 396;
        UserConfirm: Boolean;
        Username: Text;
        user: Record User;
    begin
        // Get current user
        user.Reset;
        user.SetRange(user."User Name", UserId);
        if user.Find('-') then begin
            if user."Full Name" = '' then
                UserName := user."User Name"
            else
                UserName := user."Full Name";
        end;

        // First check if there are records to transfer
        TempBankAccReconciliationLine.RESET;
        TempBankAccReconciliationLine.SetFilter(Difference, '<>%1', 0);
        TempBankAccReconciliationLine.SetRange(select, True);
        TempBankAccReconciliationLine.SetRange("Statement No.", Bankrecon."Statement No.");
        TempBankAccReconciliationLine.SetRange("Bank Account No.", Bankrecon."Bank Account No.");

        if not TempBankAccReconciliationLine.FindSet() then
            Error('No records found to transfer.');

        // Ask for user confirmation
        if not Confirm('Do you want to transfer the selected records to Journal Voucher, %1?', false, Username) then
            exit;

        if TempBankAccReconciliationLine.FindSet() then begin
            JournalVoucherHeader.RESET;
            JournalVoucherHeader.SetRange("Reference No.", Bankrecon."Statement No.");
            JournalVoucherHeader.SetRange("Bank Account No", Bankrecon."Bank Account No.");

            if JournalVoucherHeader.FindFirst() then begin
                // Instead of deleting, mark existing lines as processed
                JournalVoucherLine.RESET;
                JournalVoucherLine.SetRange("Docuument No", JournalVoucherHeader."No.");
                JournalVoucherLine.SetRange("Reference No", TempBankAccReconciliationLine."Reference No");
                if JournalVoucherLine.FindSet() then begin
                    repeat
                        JournalVoucherLine."Processed" := true; // Assuming "Processed" is the field to mark the status
                        JournalVoucherLine.Modify();
                    until JournalVoucherLine.Next() = 0;
                end;
            end else begin
                // Create new Journal Voucher Header
                GenLedgerSetup.Get();
                GenLedgerSetup.TESTFIELD(GenLedgerSetup."Journal Vouchers");
                NextNo := NoSeriesMgt.GetNextNo(GenLedgerSetup."Journal Vouchers", Today, true);

                JournalVoucherHeader.INIT;
                JournalVoucherHeader."No." := NextNo;
                JournalVoucherHeader."Created By" := USERID;
                JournalVoucherHeader."Document Date" := Today;
                JournalVoucherHeader."Reference No." := Bankrecon."Statement No.";
                JournalVoucherHeader."Bank Account No" := Bankrecon."Bank Account No.";
                JournalVoucherHeader.INSERT;
            end;

            // Insert new Journal Voucher Lines
            repeat
                JournalVoucherLine.INIT;
                JournalVoucherLine."Docuument No" := JournalVoucherHeader."No.";
                JournalVoucherLine."Account Type" := JournalVoucherLine."Account Type"::"Bank Account";
                JournalVoucherLine."Account No" := Bankrecon."Bank Account No.";
                JournalVoucherLine."Posting Date" := TempBankAccReconciliationLine."Transaction Date";
                JournalVoucherLine.Description := TempBankAccReconciliationLine.Description;
                JournalVoucherLine.externalDocumentNo := TempBankAccReconciliationLine."Reference No";
                JournalVoucherLine.Amount := TempBankAccReconciliationLine.Difference;
                JournalVoucherLine."Document Type" := JournalVoucherLine."Document Type"::Payment;
                JournalVoucherLine."Line No" := getJournalVoucherLinelastLine() + 1;
                JournalVoucherLine."Reference No" := TempBankAccReconciliationLine."Reference No";
                JournalVoucherLine."Processed" := false; // New line is not yet processed

                JournalVoucherLine.Insert(true);
            until TempBankAccReconciliationLine.Next = 0;

            Message('Hello %1,\Transfer to Journal Voucher completed successfully.\Journal Voucher No: %2', Username, JournalVoucherHeader."No.");
        end;
    end;



    procedure getJournalVoucherLinelastLine(): Integer
    var
        JournalVoucherLine: Record "Journal Voucher Lines";
    begin
        JournalVoucherLine.RESET;
        if JournalVoucherLine.FINDLAST then begin
            exit(JournalVoucherLine."Line No");
        end;
    end;


    //end;
}
