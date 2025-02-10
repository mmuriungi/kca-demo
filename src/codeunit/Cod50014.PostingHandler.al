codeunit 50014 "Posting Handler"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforePostGenJnlLine, '', false, false)]
    local procedure HandleBOReceivableAccounts(Balancing: Boolean; sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line")
    var
        TransType: Enum "Vendor Transaction Type";
        Vendor: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";
        HrmSetup: Record "HRM-Setup";
    begin
        if (GenJournalLine."Vendor Transaction Type" in [TransType::"Inpatient Claim", TransType::"Outpatient Claim", TransType::"Optical Claim", TransType::"Part timer"]) then begin
            Vendor.Reset();
            Vendor.SetRange("No.", GenJournalLine."Account No.");
            if Vendor.FindFirst() then begin

                HrmSetup.Get();
                case GenJournalLine."Vendor Transaction Type" of
                    TransType::"Inpatient Claim":
                        GenJournalLine."Posting Group" := HrmSetup."Medical Claim Posting Group";
                    TransType::"Outpatient Claim":
                        GenJournalLine."Posting Group" := HrmSetup."Medical Claim Posting Group";
                    TransType::"Optical Claim":
                        GenJournalLine."Posting Group" := HrmSetup."Medical Claim Posting Group";
                    TransType::"Part timer":

                        GenJournalLine."Posting Group" := HrmSetup."Parttimer Posting Group";
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-post Line", OnBeforeInsertDtldVendLedgEntry, '', false, false)]
    local procedure InsertDetailedVendorTransactionalData(GenJournalLine: Record "Gen. Journal Line"; var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry")
    begin
        DtldVendLedgEntry."Vendor Transaction Type" := GenJournalLine."Vendor Transaction Type";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInitVendLedgEntry, '', false, false)]
    local procedure InsertCustLedgerBOTransactionalData(GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    var
    begin
        VendorLedgerEntry."Vendor Transaction Type" := GenJournalLine."Vendor Transaction Type";
    end;

    /* 
            DtldCustLedgEntry."Transaction Type" := GenJournalLine."Transaction Type";
            DtldCustLedgEntry.Validate("Transaction Type");
            DtldCustLedgEntry."Source Code" := GenJournalLine."Source Code";
            DtldCustLedgEntry."Loan Product Code" := GenJournalLine."Loan Product Code";
            DtldCustLedgEntry."Loan Number" := GenJournalLine."Loan Number";
            if GenJournalLine."Entry Type" = GenJournalLine."Entry Type"::Reversal then
                DtldCustLedgEntry."Entry Type" := DtldCustLedgEntry."Entry Type"::Reversal;
            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::"UnAllocated Funds" then
                DtldCustLedgEntry."UnAllocated Account No" := GenJournalLine."Account No.";
        end; */

}
