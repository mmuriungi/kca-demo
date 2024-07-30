report 50022 "Payment Voucher Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payment Voucher Report.rdl';

    dataset
    {
        dataitem(FINPaymentsHeader; "FIN-Payments Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; Company.Name)
            {
            }
            column(log; Company.Picture)
            {
            }
            column(Add; company.Address)
            {
            }
            /*  column(CurrReport_PAGENO; CurrReport.PAGENO)
             {
             } */
            column(USERID; USERID)
            {
            }
            column(Payments_HeaderCaption; Payments_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Payments_Header_No_; "No.")
            {
            }
            column(ChequeNo; "Cheque No.")
            {
            }
            column(PayingBank; "Paying Bank Account")
            {
            }
            column(Payee; Payee)
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankNo; BankNo)
            {
            }
            column(AmntApplied; AmntApplied)
            {
            }
            column(VATHeaderAmount; "Total VAT Amount")
            {
            }
            column(PaymentNarration_PaymentsHeader; "Payment Narration")
            {
            }
            column(NetHeaderAmount; "Total Net Amount")
            {
            }
            column(TotalPayment_Amount; "Total Payment Amount")
            {
            }
            column(PayMode; "Pay Mode")
            {
            }
            dataitem(DataItem3474; "FIN-Payment Line")
            {
                DataItemLink = No = FIELD("No.");
                column(Payment_Line__Account_Name_; "Account Name")
                {
                }
                column(Payment_Line__Withholding_Tax_Amount_; "Withholding Tax Amount")
                {
                }
                column(Payment_Line__Net_Amount_; "Net Amount")
                {
                }
                column(Payment_Line_Line_No_; "Line No.")
                {
                }
                column(Payment_Line_No; No)
                {
                }
                column(Payment_Line_Type; Type)
                {
                }
                column(Payment_Line_Account_No_; "Account No.")
                {
                }
                column(InvPaid; InvPaid)
                {
                }
                column(PAYE; "PAYE Amount")
                {
                }
                column(AmountInWords; AmountInWords)
                {
                }
                column(TTotal; TTotal)
                {
                }
                column(NumberText_1_; NumberText[1])
                {
                }
                column(InvNo; InvNo)
                {
                }
                column(VatLinesAmount; "VAT Amount")
                {
                }
                column(InvDate; InvDate)
                {
                }
                dataitem(DataItem4114; 25)
                {
                    DataItemLink = "Vendor No." = FIELD("Account No."),
                                   "Applies-to ID" = FIELD(No);
                    column(Vendor_Ledger_Entry__Posting_Date_; "Posting Date")
                    {
                    }
                    column(Vendor_Ledger_Entry__Amount_to_Apply_; "Amount to Apply")
                    {
                    }
                    column(Vendor_Ledger_Entry_Description; Description)
                    {
                    }
                    column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                    {
                    }
                    column(Vendor_Ledger_Entry_Applies_to_ID; "Applies-to ID")
                    {
                    }
                    column(ExDocNo; "External Document No.")
                    {
                    }
                    column(OrderNo; "Order No")
                    {
                    }
                    column(InvAmount; InvAmount)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        InvAmount := "Amount to Apply" * -1;
                    end;
                }

                trigger OnAfterGetRecord()

                begin

                    TTotal := TTotal + FINPaymentLine."Net Amount";
                    CheckReport.InitTextVariable();
                    CheckReport.FormatNoText(NumberText, TTotal, '');

                    IF FINPaymentLine."Account Type" = FINPaymentLine."Account Type"::"G/L Account" THEN BEGIN
                        InvNo := FINPaymentLine."Account No.";
                        InvDate := FINPaymentLine.Date;
                    END ELSE
                        InvNo := '';
                    InvDate := 0D;
                end;
            }
            dataitem(DataItem35; 454)
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Document Type" = FIELD("Document Type");
                column(SequenceNo_ApprovalEntry; "Sequence No.")
                {
                }
                column(ApproverID_ApprovalEntry; "Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Last Date-Time Modified")
                {
                }
                column(SenderID_ApprovalEntry; "Sender ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Date-Time Sent for Approval")
                {
                }
                column(AStatus; Status)
                {
                }
                dataitem(DataItem55; 91)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(Signature_UserSetup; "User Signature")
                    {
                    }
                    column(ApprovalDesignation_UserSetup; "Approval Title")
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()

            begin
                AmntApplied := '';
                VendorLedgEntry.RESET;
                VendorLedgEntry.SETRANGE(VendorLedgEntry."Applies-to ID", "No.");
                IF VendorLedgEntry.FIND('-') THEN BEGIN
                    InvPaid := 'Summary of Invoices Paid';
                    //AppliedAmount:="Vendor Ledger Entry"."Amount to Apply";
                END ELSE
                    InvPaid := '';
                //AppliedAmount:=FORMAT(AmntApplied);
                //AmntApplied:='';
                TTotal := 0;
                //Get bank name and AC.NO..........JLL
                BankRec.RESET;
                BankRec.SETRANGE(BankRec."No.", "Paying Bank Account");
                IF BankRec.FIND('-') THEN BEGIN
                    BankName := BankRec.Name;
                    BankNo := BankRec."Bank Account No.";
                END;


                IF vends.GET(FINPaymentsHeader."Vendor No.") THEN BEGIN
                END;
                StrCopyText := '';
                IF "No. Printed" >= 1 THEN BEGIN
                    StrCopyText := 'DUPLICATE';
                END;
                TTotal := 0;

                IF FINPaymentsHeader."Payment Type" = FINPaymentsHeader."Payment Type"::Normal THEN
                    DOCNAME := 'PAYMENT VOUCHER'
                ELSE
                    DOCNAME := 'PETTY CASH VOUCHER';

                //Set currcode to Default if blank
                GLSetup.GET();
                IF FINPaymentsHeader."Currency Code" = '' THEN BEGIN
                    CurrCode := GLSetup."LCY Code";
                END ELSE
                    CurrCode := FINPaymentsHeader."Currency Code";

                //For Inv Curr Code
                IF FINPaymentsHeader."Invoice Currency Code" = '' THEN BEGIN
                    InvoiceCurrCode := GLSetup."LCY Code";
                END ELSE
                    InvoiceCurrCode := FINPaymentsHeader."Invoice Currency Code";

                //End;
                CALCFIELDS("Total Payment Amount", "Total Witholding Tax Amount", FINPaymentsHeader."Total Net Amount");

                InitTextVariable;
                FormatNoText(NumberText, FINPaymentsHeader."Total Net Amount", CurrencyCodeText);
            end;


            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        company.RESET;
        IF company.FINDFIRST THEN BEGIN
            company.CALCFIELDS(Picture);
        END;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Payments_HeaderCaptionLbl: Label 'Payments Header';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        InvPaid: Code[30];
        FINPaymentLine: Record "FIN-Payment Line";
        VendorLedgEntry: Record "Vendor Ledger Entry";
        AmountInWords: Text[200];
        DOCNAME: Text[30];
        CurrencyCodeText: Code[10];
        vends: Record Vendor;
        CheckReport: Report 1401;
        NumberText: array[2] of Text[100];
        TTotal: Decimal;
        BankName: Text[100];
        BankNo: Code[50];
        BankRec: Record 270;
        StrCopyText: Text[30];
        CurrCode: Code[10];
        InvNo: Code[20];
        InvDate: Date;
        AmntApplied: Text;
        AppliedAmount: Decimal;
        InvAmount: Decimal;
        company: Record 79;
        NumberTextOne: Text;
        InvoiceCurrCode: Code[30];
        GLSetup: Record "General Ledger Setup";
        NumberTextTwo: Text;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        Text001: Label 'Last Check No. must be filled in.';
        Text002: Label 'Filters on %1 and %2 are not allowed.';
        Text003: Label 'XXXXXXXXXXXXXXXX';
        Text004: Label 'must be entered.';
        Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text006: Label 'Salesperson';
        Text007: Label 'Purchaser';
        Text008: Label 'Both Bank Accounts must have the same currency.';
        Text009: Label 'Our Contact';
        Text010: Label 'XXXXXXXXXX';
        Text011: Label 'XXXX';
        Text012: Label 'XX.XXXXXXXXXX.XXXX';
        Text013: Label '%1 already exists.';
        Text014: Label 'Check for %1 %2';
        Text015: Label 'Payment';
        Text016: Label 'In the Check report, One Check per Vendor and Document No.\';
        Text017: Label 'must not be activated when Applies-to ID is specified in the journal lines.';
        Text018: Label 'XXX';
        Text019: Label 'Total';
        Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022: Label 'NON-NEGOTIABLE';
        Text023: Label 'Test print';
        Text024: Label 'XXXX.XX';
        Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label ' is already applied to %1 %2 for customer %3.';
        Text031: Label ' is already applied to %1 %2 for vendor %3.';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        Text063: Label 'Net Amount %1';
        Text064: Label '%1 must not be %2 for %3 %4.';

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        else begin
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;
        end;

        if CurrencyCode = '' then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' KENYA SHILLINGS');
            if No <> 0 then begin
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
                //Translate KOBO to words
                if (No * 100) > 0 then begin
                    No := No * 100;
                    for Exponent := 4 downto 1 do begin
                        PrintExponent := false;
                        Ones := No div Power(1000, Exponent - 1);
                        Hundreds := Ones div 100;
                        Tens := (Ones mod 100) div 10;
                        Ones := Ones mod 10;
                        if Hundreds > 0 then begin
                            AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                            AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                        end;
                        if Tens >= 2 then begin
                            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                            if Ones > 0 then
                                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                        end else
                            if (Tens * 10 + Ones) > 0 then
                                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                        if PrintExponent and (Exponent > 1) then
                            AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                        No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
                    end;
                end;

                AddToNoText(NoText, NoTextIndex, PrintExponent, FORMAT(No * 100) + ' KOBO');
                AddToNoText(NoText, NoTextIndex, PrintExponent, ' CENTS');
            end;
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ONLY****');
        end;
        if CurrencyCode <> '' then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
            if No <> 0 then begin
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
                AddToNoText(NoText, NoTextIndex, PrintExponent, Format(No * 100) + ' CENTS');
            end;
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ONLY');
        end;
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(Text029, AddText);
        end;

        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;
}

