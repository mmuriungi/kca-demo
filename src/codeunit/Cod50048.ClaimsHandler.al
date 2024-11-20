codeunit 50048 "Claims Handler"
{
    procedure createPaymentVoucher(Var Claim: Record "HRM-Medical Claims") posted: Boolean
    var
        PVHeader: Record "FIN-Payments Header";
        PvLines: Record "FIN-Payment Line";
        Employee: Record "HRM-Employee C";
        PayTypes: Record "FIN-Receipts and Payment Types";
        Ptimer: Codeunit "PartTimer Management";
    begin
        PVHeader.Init();
        PVHeader."Document Type" := PVHeader."Document Type"::"Payment Voucher";
        PVHeader."No." := '';
        PVHeader."Global Dimension 1 Code" := Claim."Global Dimension 1 Code";
        PVHeader."Shortcut Dimension 2 Code" := Claim."Global Dimension 2 Code";
        PVHeader."Shortcut Dimension 3 Code" := Claim."Shortcut Dimension 3 Code";
        PVHeader."Payment Type" := PVHeader."Payment Type"::Normal;
        //PVHeader."Paying Bank Account" := Claim.;
        PVHeader."Pay Mode" := PVHeader."Pay Mode";
        PVHeader."Responsibility Center" := Claim."Responsibility Center";
        PVHeader."Payment Narration" := Claim.Comments;
        PVHeader.Payee := Claim."Member Names";
        PVHeader."Source Document No" := Claim."Claim No";
        PVHeader."Source Table" := Claim.RecordId.TableNo;
        PVHeader.Date := Today;
        if PVHeader.Insert(true) then begin
            // Claim.CalcFields("Payment Amount");
            getPayType(PayTypes);
            Ptimer.getEmployee(Employee, Claim."Member No");
            PvLines.Init();
            PvLines.No := PVHeader."No.";
            PvLines.Type := PayTypes.Code;
            PvLines.Validate("Type");
            PvLines."Account No." := Employee."Vendor No.";
            PvLines.Validate("Account No.");
            PvLines."Global Dimension 1 Code" := Claim."Global Dimension 1 Code";
            PvLines."Shortcut Dimension 2 Code" := Claim."Global Dimension 2 Code";
            PvLines."Shortcut Dimension 3 Code" := Claim."Shortcut Dimension 3 Code";
            PvLines.Amount := Claim."Claim Amount";
            PvLines.Validate("Amount");
            if PvLines.Insert(true) then begin
                Message('Payment Voucher Created Successfully');
                posted := true;
            end;
        end;
    end;

    procedure getPayType(var PayTypes: Record "FIN-Receipts and Payment Types")
    begin
        PayTypes.Reset();
        PayTypes.SetRange("Medical Claim?", true);
        PayTypes.FindFirst();
    end;


}
