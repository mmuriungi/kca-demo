codeunit 51810 "Deposit-Post (Yes/No)"
{
    TableNo = "Deposit Header";

    trigger OnRun()
    begin
        DepositHeader.Copy(Rec);

        //IF NOT CONFIRM(Text000,FALSE) THEN
        // EXIT;

        DepositPost.Run(DepositHeader);
        Rec := DepositHeader;
    end;

    var
        DepositHeader: Record "Deposit Header";
        DepositPost: Codeunit "Deposit-Post";
        Text000: Label 'Do you want to post the Deposit?';
}

