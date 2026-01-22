codeunit 50115 "Normalize DocNo Processor"

{
    Subtype = Normal;

    trigger OnRun()
    var
        Entry: Record "Detailed Cust ledger Custom";
        Count: Integer;
    begin
        Entry.Reset();
        if Entry.FindSet(true) then begin
            repeat
                Entry."Normalized Document No." := NormalizeDocNo(Entry."Document No.");
                Entry.Modify();
                Count += 1;
            until Entry.Next() = 0;
        end;

        Message('Normalized %1 document numbers.', Count);
    end;

    local procedure NormalizeDocNo(DocNo: Code[20]): Code[20]
    var
        i: Integer;
    begin
        for i := 1 to StrLen(DocNo) do begin
            if CopyStr(DocNo, i, 1) <> '0' then
                exit(CopyStr(DocNo, i));
        end;

        exit('');
    end;
}
