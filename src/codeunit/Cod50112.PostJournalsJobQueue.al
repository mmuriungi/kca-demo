codeunit 50112 "Post Journals by Queue"
{
    trigger OnRun()
    begin
        process();
    end;

    procedure process()
    var
        GenJnlLine: Record "Gen. Journal Line";

    begin
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'DATAIMPORT');
        if GenJnlLine.FindSet() then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLine);
    end;
}
