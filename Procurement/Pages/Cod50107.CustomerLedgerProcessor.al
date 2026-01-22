codeunit 50107 "Customer Ledger Processor"
{
    procedure InsertUnpostedToGenJournal()
    var
        CustUpload: Record "Customer ledger Upload";
        GenLine: Record "Gen. Journal Line";
        TemplateName: Code[10];
        BatchName: Code[10];
        LineNo: Integer;
        Custleder: Record "Cust. Ledger Entry";
    begin
        TemplateName := 'GENERAL';
        BatchName := 'DATAIMPORT';
        LineNo := 10000;

        CustUpload.Reset();
        CustUpload.SetRange(Posted, false);

        if CustUpload.FindSet() then
            repeat
                Clear(GenLine);
                GenLine.Init();
                GenLine."Journal Template Name" := TemplateName;
                GenLine."Journal Batch Name" := BatchName;
                GenLine."Line No." := LineNo;
                LineNo += 10000;

                GenLine."Posting Date" := CustUpload."Posting Date";
                GenLine."Document No." := CustUpload."Document No";
                GenLine."Account Type" := CustUpload."Account Type";
                GenLine."Account No." := CustUpload."Account No.";
                GenLine.Description := CustUpload.Description;
                GenLine.Amount := CustUpload.Amount;
                GenLine."External Document No." := CustUpload."External Doc No";
                GenLine."Bal. Account Type" := CustUpload."balalance Account Type";
                GenLine."Shortcut Dimension 1 Code" := CustUpload."Global Dimension 1 Code";
                GenLine."Shortcut Dimension 2 Code" := CustUpload."Global Dimension 2 Code";

                if GenLine.Insert(true) then begin
                    CustUpload.Posted := true;
                    CustUpload.Modify(true);
                end;
            until CustUpload.Next() = 0;
    end;
}
