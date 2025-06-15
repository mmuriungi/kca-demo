codeunit 50108 "Normalize DocNo Processor"
{
    Subtype = Normal;

    trigger OnRun()
    var
        Entry: Record "Detailed Cust ledger Custom";
        Count: Integer;
    begin
        Count := 0;
        Entry.Reset();
        if Entry.FindSet(true) then begin
            repeat
                Entry."Normalized Document No." := PadOrNormalizeDocNo(Entry."Document No.");
                Entry.Modify();
                Count += 1;
            until Entry.Next() = 0;
        end;
        Message('Normalized %1 entries.', Count);
    end;

    local procedure PadOrNormalizeDocNo(DocNo: Code[20]): Code[20]
    var
        DocInt: Integer;
    begin
        if Evaluate(DocInt, DocNo) then
            exit(PadLeft(Format(DocInt), 4, '0'))
        else
            exit(DocNo);
    end;

    local procedure PadLeft(TextIn: Text; TotalLength: Integer; PadChar: Char): Text
    begin
        while StrLen(TextIn) < TotalLength do
            TextIn := PadChar + TextIn;
        exit(TextIn);
    end;
}
