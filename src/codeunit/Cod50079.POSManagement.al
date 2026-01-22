codeunit 50079 "POS Management"
{
    var
        POSSetup: Record "POS Setup";
        ItemLedger: Record "POS Item Ledger";
        POSLines: Record "POS Sales Lines";
        POSSaleHeader: Record "POS Sales Header";

    procedure GetLastEntryNo(): Integer;
    var
        PosLedger: Record "POS Item Ledger";
    begin
        PosLedger.Reset();
        if PosLedger.FindLast() then
            exit(PosLedger."Entry No.")
        else
            exit(0);
    end;

    // Procedure to convert a Code type to a hexadecimal string
    procedure GenerateHexadecimal(Number: Code[10]): Code[10]
    var
        HexString: Code[10];
        IntValue: Integer;
        Success: Boolean;
    begin
        // Try to convert the input to an integer
        Success := Evaluate(IntValue, Number);
        if not Success then
            Error('Invalid number format: %1', Number);

        // Convert the integer to a hexadecimal string
        HexString := ConvertToHex(IntValue);
        exit(HexString);
    end;

    // Helper function to convert an integer to a hexadecimal string
    procedure ConvertToHex(Value: Integer): Code[10]
    var
        HexChars: array[16] of Char;
        HexString: Text[10];
        Remainder: Integer;
    begin
        HexChars[1] := '0';
        HexChars[2] := '1';
        HexChars[3] := '2';
        HexChars[4] := '3';
        HexChars[5] := '4';
        HexChars[6] := '5';
        HexChars[7] := '6';
        HexChars[8] := '7';
        HexChars[9] := '8';
        HexChars[10] := '9';
        HexChars[11] := 'A';
        HexChars[12] := 'B';
        HexChars[13] := 'C';
        HexChars[14] := 'D';
        HexChars[15] := 'E';
        HexChars[16] := 'F';

        HexString := '';
        while Value > 0 do begin
            Remainder := Value mod 16;
            HexString := Format(HexChars[Remainder + 1]) + HexString; // Use Remainder + 1 for correct indexing
            Value := Value div 16;
        end;

        if HexString = '' then
            HexString := '0';

        exit(HexString);
    end;



    procedure PostNonRevenueSale(SaleNo: Code[50])
    var
        PostedSuccess: Label 'Non-Revenue Sale was posted successfully';
    begin

        PosSetup.Get();
        POSSaleHeader.Reset();
        if POSSaleHeader.Get(SaleNo) then begin
            POSLines.Reset();
            POSLines.SetRange("Document No.", SaleNo);
            if POSLines.Find('-') then begin
                repeat
                    ItemLedger.Init();
                    ItemLedger."Entry No." := GetLastEntryNo + 1;
                    ItemLedger."Item No." := POSLines."No.";
                    ItemLedger."Document No." := POSLines."No." + POSLines."Document No.";
                    ItemLedger."Entry Type" := ItemLedger."Entry Type"::"Negative Adjmt.";
                    ItemLedger."Posting Date" := POSSaleHeader."Posting Date";
                    ItemLedger.Quantity := -POSLines.Quantity;
                    ItemLedger.Description := POSLines.Description;
                    ItemLedger.Insert(true);
                    POSLines.Posted := true;
                    POSLines.Modify();
                until POSLines.Next() = 0;
            end;
            POSSaleHeader.Posted := True;
            POSSaleHeader.Modify(true);
            Message(PostedSuccess);
        end;
    end;
}
