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
        Ptimer.getEmployee(Employee, Claim."Member No");
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
        PVHeader."Source Document Type" := PVHeader."Source Document Type"::"Medical Claim";
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
            case
                Claim."Claim Type" of
                Claim."Claim Type"::Inpatient:
                    PvLines."Vendor Transaction Type" := PvLines."Vendor Transaction Type"::"Inpatient Claim";
                Claim."Claim Type"::Outpatient:
                    PvLines."Vendor Transaction Type" := PvLines."Vendor Transaction Type"::"Outpatient Claim";
                Claim."Claim Type"::Optical:
                    PvLines."Vendor Transaction Type" := PvLines."Vendor Transaction Type"::"Optical Claim";
            end;
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

    procedure CreatePurchaseHeader(VendorNo: Code[20]; GlobalDim1: Code[20]; GlobalDim2: Code[20]; GlobalDim3: Code[20]; Date: Date; Description: Text[100]; ClaimNo: Code[20]; ClaimType: Enum "Claim Type"): Record "Purchase Header"
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

        NextOderNo: Code[20];
        PurchHeader: Record "Purchase Header";
    begin
        PurchHeader.Init();
        PurchHeader."Document Type" := PurchHeader."Document Type"::Invoice;
        PurchHeader."No." := '';
        PurchHeader."Buy-from Vendor No." := VendorNo;
        PurchHeader.VALIDATE(PurchHeader."Buy-from Vendor No.");
        PurchHeader."Document Date" := TODAY;
        PurchHeader."Posting Date" := TODAY;
        PurchHeader."Posting Description" := Description;
        PurchHeader."Order Date" := TODAY;
        PurchHeader."Due Date" := TODAY;
        PurchHeader."Shortcut Dimension 1 Code" := GlobalDim1;
        PurchHeader.Validate("Shortcut Dimension 1 Code");
        PurchHeader."Shortcut Dimension 2 Code" := GlobalDim2;
        PurchHeader.Validate("Shortcut Dimension 2 Code");
        PurchHeader."Shortcut Dimension 3 Code" := GlobalDim3;
        PurchHeader.Validate("Shortcut Dimension 3 Code");
        PurchHeader."Claim No." := ClaimNo;
        PurchHeader."Claim Type" := ClaimType;
        if PurchHeader.INSERT(TRUE) then begin
            exit(PurchHeader);

        end;



    end;

    procedure CreatePurchaseLine(PurchHeader: Record "Purchase Header"; No: Code[20]; AccountTYpe: Enum "Purchase Line Type"; Quantity: Decimal; UnitCost: Decimal)
    var
        PurchLine: Record "Purchase Line";
        LineNo: Integer;
    begin
        PurchLine.Init();
        PurchLine."Document Type" := PurchLine."Document Type"::Invoice;
        PurchLine."Document No." := PurchHeader."No.";
        PurchLine."Line No." := LineNo;
        PurchLine.Type := AccountTYpe;
        PurchLine.VALIDATE(Type);
        PurchLine."No." := No;
        PurchLine.VALIDATE("No.");
        PurchLine.Quantity := Quantity;
        PurchLine.VALIDATE(Quantity);
        PurchLine."Direct Unit Cost" := UnitCost;
        PurchLine.VALIDATE("Direct Unit Cost");
        PurchLine.INSERT(TRUE);
    end;

    procedure CreatePurchaseInvoiceFromClaim(Claim: Record "HRM-Medical Claims")
    var
        PurchHeader: Record "Purchase Header";
        Employee: Record "HRM-Employee C";
        PurchLine: Record "Purchase Line";
        HrSetup: Record "HRM-Setup";
    begin
        Employee.get(Claim."Member No");
        HrSetup.Get();
        PurchHeader := CreatePurchaseHeader(Employee."Vendor No.", Claim."Global Dimension 1 Code", Claim."Global Dimension 2 Code", Claim."Shortcut Dimension 3 Code", TODAY, Format(Claim."Claim Type") +
         ' Claim No: ' + Claim."Claim No" + ' ' + Claim."Member Names", Claim."Claim No", Enum::"Claim Type"::Medical);
        CreatePurchaseLine(PurchHeader, HrSetup."Claim G/L Account", PurchLine.Type::"G/L Account", 1, Claim."Claim Amount");
    end;




}