report 50005 "Payment Voucher Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PaymentVoucherRequisitions.rdl';

    dataset
    {
        dataitem(PaymentHeader; "FIN-Payments Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(BankCriteria_PaymentsHeader; "Bank Criteria")
            {
            }
            column(DOCNAME; DOCNAME)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress2; CompInfo."Address 2")
            {
            }
            column(Budgeted_Amount; "Budgeted Amount") { }

            column(Payment_Release_Date; format("Payment Release Date")) { }
            column(Bank_Name; "Bank Name") { }
            column(CompInfoAddress1; CompInfo.Address)
            {
            }
            column(CompInfoPostCode; CompInfo."Post Code")
            {
            }
            column(CompInfoCity; CompInfo.City)
            {
            }
            column(CompInfoPhoneNo; CompInfo."Phone No.")
            {
            }
            column(CompInfoEMail; CompInfo."E-Mail")
            {
            }
            column(CompInfoHomePage; CompInfo."Home Page")
            {
            }
            column(Payments_Header__No__; "No.")
            {
            }
            column(UserName; UserName) { }
            column(NetHeaderAmount; "Total Net Amount")
            {
            }
            column(VATHeaderAmount; "Total VAT Amount")
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(StrCopyText; StrCopyText)
            {
            }
            column(Payments_Header__Cheque_No__; "Cheque No.")
            {
            }
            column(Payments_Header_Payee; Payee)
            {
            }
            column(TotalPayment_Amount; "Total Payment Amount")
            {
            }
            column(Adress1; CompInfo.Address + ', ' + CompInfo.City)
            {
            }
            column(Payments_Header__Payments_Header__Date; Format(PaymentHeader.Date))
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(Payments_Header__Shortcut_Dimenssion_2_Code_; "Shortcut Dimension 2 Code")
            {
            }
            column(BankName_PaymentsHeader; "Bank Name")
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankNo; BankNo)
            {
            }
            column(USERID; USERID)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(DimValName; DimValName) { }
            column(TTotal; TTotal)
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + FORMAT(TIME))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + FORMAT(TODAY, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(CurrCode_Control1102756010; CurrCode)
            {
            }
            column(CurrCode_Control1102756012; CurrCode)
            {
            }
            column(Approved_; 'Approved')
            {
                AutoFormatType = 1;
            }
            column(cashier; Cashier)
            {
            }
            column(Approval_Status_____; 'Approval Status' + ':')
            {
                AutoFormatType = 1;
            }
            column(TIME_PRINTED_____FORMAT_TIME__Control1102755003; 'TIME PRINTED:' + FORMAT(TIME))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4__Control1102755004; 'DATE PRINTED:' + FORMAT(TODAY, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(USERID_Control1102755012; USERID)
            {
            }
            column(NumberText_1__Control1102755016; NumberText[1])
            {
            }
            column(TTotal_Control1102755034; TTotal)
            {
            }
            column(CurrCode_Control1102755035; CurrCode)
            {
            }
            column(CurrCode_Control1102755037; CurrCode)
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            column(PAYMENT_DETAILSCaption; PAYMENT_DETAILSCaptionLbl)
            {
            }
            column(AMOUNTCaption; AMOUNTCaptionLbl)
            {
            }
            column(NET_AMOUNTCaption; NET_AMOUNTCaptionLbl)
            {
            }
            column(W_TAXCaption; W_TAXCaptionLbl)
            {
            }
            column(Document_No___Caption; Document_No___CaptionLbl)
            {
            }
            column(Currency_Caption; Currency_CaptionLbl)
            {
            }
            column(Payment_To_Caption; Payment_To_CaptionLbl)
            {
            }
            column(Document_Date_Caption; Document_Date_CaptionLbl)
            {
            }
            column(Cheque_No__Caption; Cheque_No__CaptionLbl)
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_Caption; FIELDCAPTION("Global Dimension 1 Code"))
            {
            }
            column(Payments_Header__Shortcut_Dimension_2_Code_Caption; FIELDCAPTION("Shortcut Dimension 2 Code"))
            {
            }
            column(R_CENTERCaption; R_CENTERCaptionLbl)
            {
            }
            column(PROJECTCaption; PROJECTCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Printed_By_Caption; Printed_By_CaptionLbl)
            {
            }
            column(Amount_in_wordsCaption; Amount_in_wordsCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(RecipientCaption; RecipientCaptionLbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(name; name)
            {
            }
            column(PaymentNarration_PaymentsHeader; PaymentHeader."Payment Narration")
            {
            }
            column(names; "name+")
            {
            }
            column(addr; addr)
            {
            }
            column(email; email)
            {
            }
            column(PIN; PIN)
            {
            }
            column(VAT; VAT)
            {
            }
            column(lpo; no)
            {
            }
            column(ret; ret)
            {
            }
            column(appliedinv; appliedinv)
            {
            }
            column(co; confir)
            {
            }
            column(next1; next1)
            {
            }
            column(DATE; dat)
            {
            }
            column(CHECKED; checked)
            {
            }
            column(PREPARED; PREPARE)
            {
            }
            column(APPROVED; appr)
            {
            }
            column(com; confirma)
            {
            }
            column(internals; internals)
            {
            }
            column(paymentapp; paymentapp)
            {
            }
            column(md; md)
            {
            }
            column(authorized; Authorized)
            {
            }
            column(emptystr; emptystr)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755013; EmptyStringCaption_Control1102755013Lbl)
            {
            }
            column(Amount_in_wordsCaption_Control1102755021; Amount_in_wordsCaption_Control1102755021Lbl)
            {
            }
            column(Printed_By_Caption_Control1102755026; Printed_By_Caption_Control1102755026Lbl)
            {
            }
            column(finance_controller; fincont)
            {
            }
            column(Accountant; accntnt)
            {
            }
            column(TotalPAYE; PaymentHeader."Total PAYE Amount")
            {
            }
            column(TotalVATWithholdingAmount_PaymentsHeader; PaymentHeader."Total VAT Withholding Amount")
            {
            }
            column(TotalCaption_Control1102755033; TotalCaption_Control1102755033Lbl)
            {
            }
            column(Paymode; PaymentHeader."Pay Mode")
            {
            }
            column(Narration; PaymentHeader."Payment Narration")
            {
            }
            column(payeeNo; PaymentHeader.Payee)
            {
            }
            column(VendNo; PaymentHeader."Vendor No.")
            {
            }
            column(VendName; PaymentHeader."Vendor Name")
            {
            }
            column(vendAddr; vends.Address + ' ' + vends."Address 2" + ', ' + vends.City)
            {
            }
            dataitem("<Payment Line>"; "FIN-Payment Line")
            {
                DataItemLink = No = FIELD("No.");
                DataItemTableView = SORTING("Line No.", No, Type)
                                    ORDER(Ascending);
                column(Payment_Line__Net_Amount__; "Net Amount")
                {
                }
                column(Payment_Line_Amount; Amount)
                {
                }
                column(PayLineBudget_Balance; "Budget Balance") { }
                column(BudgetBalance; BudgetBalance) { }
                column(Budget_Amount; "Budgeted Amount") { }

                column(AccountName_PaymentLine; "Account Name")
                {
                }
                column(TransactionName_PaymentLine; "Transaction Name")
                {
                }
                column(Account_No_; "Account No.")
                {

                }
                column(Transaction_Name_______Account_No________Account_Name_____; "Transaction Name" + '[' + "Account No." + ':' + "Account Name" + ']')
                {
                }
                column(Payment_Line__Withholding_Tax_Amount_; "Withholding Tax Amount")
                {
                }
                column(ID; id)
                {
                }
                column(PAYE; "PAYE Amount")
                {
                }
                column(Payment_Line__VAT_Amount_; "VAT Amount")
                {
                }
                column(Payment_Line__Global_Dimension_1_Code_; "Global Dimension 1 Code")
                {
                }
                column(witheld6; "VAT Withheld Amount")
                {
                }
                column(Payment_Line__Shortcut_Dimension_2_Code_; "Shortcut Dimension 2 Code")
                {
                }
                column(Payment_Line_Line_No_; "Line No.")
                {
                }
                column(Payment_Line_No; No)

                {
                }
                column(VatLinesAmount; "VAT Amount")
                {
                }
                column(Retention; "Retention  Amount")
                {
                }
                column(Payment_Line_Type; Type)
                {
                }
                column(PAYEAmount_PaymentLine; "PAYE Amount")
                {
                }
                column(Account; "<Payment Line>"."Account No.")
                {
                }
                column(VATWithheldAmount_PaymentLine; "<Payment Line>"."VAT Withheld Amount")
                {
                }
                column(payee; "<Payment Line>".Payee)
                {
                }
                column(ApproverID_ApprovalEntr_5; ApprovalEntry5."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry_5; ApprovalEntry5."Last Date-Time Modified")
                {
                }
                column(Signature_UserSetup_5; ApprovalUserSetUp5."User Signature")
                {
                }
                column(ApproverID_ApprovalEntr_4; ApprovalEntry4."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry_4; ApprovalEntry4."Last Date-Time Modified")
                {
                }
                column(Signature_UserSetup_4; ApprovalUserSetUp4."User Signature")
                {
                }
                column(ApprovalDesignation_UserSetup_4; ApprovalUserSetUp4."Approval Title")
                {
                }

                column(ApproverID_ApprovalEntr_3; ApprovalEntry3."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry_3; ApprovalEntry3."Last Date-Time Modified")
                {
                }
                column(Signature_UserSetup_3; ApprovalUserSetUp3."User Signature")
                {
                }
                column(ApprovalDesignation_UserSetup_3; ApprovalUserSetUp3."Approval Title")
                {
                }
                column(ApproverID_ApprovalEntr_2; ApprovalEntry2."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry_2; ApprovalEntry2."Last Date-Time Modified")
                {
                }
                column(Signature_UserSetup_2; ApprovalUserSetUp2."User Signature")
                {
                }
                column(ApprovalDesignation_UserSetup_2; ApprovalUserSetUp2."Approval Title")
                {
                }
                column(ApproverID_ApprovalEntr_1; ApprovalEntry1."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry_1; ApprovalEntry1."Last Date-Time Modified")
                {
                }
                column(Signature_UserSetup_1; ApprovalUserSetUp1."User Signature")
                {
                }
                column(ApprovalDesignation_UserSetup_1; ApprovalUserSetUp1."Approval Title")
                {
                }
                column(payeAcc; payeAcc) { }
                column(payeNm; payeNm) { }
                column(glCode; glCode) { }
                column(glName; glName) { }
                column(renetionName; renetionName) { }
                column(Renetiongl; Renetiongl) { }

                column(Ac_Charged; payTypes."G/L Account")
                {
                }
                dataitem(VendorLedgEntries; 25)
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
                    column(Approver1; Approver1) { }
                    column(Approver2; Approver2) { }
                    column(approver3; approver3) { }
                    column(approver4; approver4) { }
                    column(AppravalDate1; AppravalDate1) { }
                    column(ApprovalDate2; ApprovalDate2) { }
                    column(ApprovalDate3; ApprovalDate2) { }
                    column(approvalDate4; approvalDate4) { }


                    trigger OnAfterGetRecord()
                    begin
                        InvAmount := "Amount to Apply" * -1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    DimVal.RESET;
                    DimVal.SETRANGE(DimVal."Dimension Code", 'DEPARTMENT');
                    DimVal.SETRANGE(DimVal.Code, "Shortcut Dimension 2 Code");
                    DimValName := '';
                    IF DimVal.FINDFIRST THEN BEGIN
                        DimValName := DimVal.Name;
                    END;

                    TTotal := TTotal + PaymentHeader."Total Payment Amount";
                    CheckReport.InitTextVariable();
                    FormatNoText(NumberText, PaymentHeader."Total Payment Amount", '');



                    payTypes.RESET;
                    payTypes.SETRANGE(payTypes.Code, "<Payment Line>".Type);
                    IF payTypes.FIND('-') THEN BEGIN
                    END;
                end;
            }
            // dataitem(Total; Table2000000026)
            // {
            //     DataItemTableView = SORTING (Number)ORDER(Ascending)WHERE (Number = CONST (0));

            //     trigger OnAfterGetRecord()
            //     begin
            //         CheckReport.InitTextVariable();
            //         CheckReport.FormatNoText(NumberText,TTotal,'');
            //     end;
            // }
            dataitem(Summary; "FIN-Payment Line")
            {
                DataItemLink = No = FIELD("No.");
                DataItemTableView = SORTING("Line No.", No, Type)
                                    ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    DimVal.RESET;
                    DimVal.SETRANGE(DimVal."Dimension Code", 'DEPARTMENT');
                    DimVal.SETRANGE(DimVal.Code, "Shortcut Dimension 2 Code");
                    DimValName := '';
                    IF DimVal.FINDFIRST THEN BEGIN
                        DimValName := DimVal.Name;
                    END;

                    STotal := STotal + "Net Amount";
                end;
            }
            // dataitem(DataItem5444; Table2000000026)
            // {
            //     DataItemTableView = SORTING(Number)ORDER(Ascending) WHERE(Number = CONST(1));
            // }
            dataitem(DataItem1937; "FIN-CshMgt Application")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Line Number")
                                    ORDER(Ascending)
                                    WHERE("Document Type" = CONST(PV));
            }
            dataitem(ApprovalEntry; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(ApproverID_ApprovalEntry; ApprovalEntry."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; format(ApprovalEntry."Last Date-Time Modified"))
                {
                }


                dataitem(UserSetUp; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(Signature_UserSetup; UserSetUp."User Signature")
                    {
                    }
                    column(ApprovalDesignation_UserSetup; UserSetUp."Approval Title")
                    {
                    }
                }

                trigger OnPreDataItem()
                begin
                    ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                    ApprovalEntry.SetFilter(ApprovalEntry."Approver ID", '<>%1', PaymentHeader.Cashier);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(Picture);
                payTypes.RESET;
                payTypes.SETRANGE(payTypes.Code, "<Payment Line>".Type);
                IF payTypes.FIND('-') THEN BEGIN
                END;
                tarrifs.Reset();
                tarrifs.SetRange(Code, "<Payment Line>"."Withholding Tax Code");
                if tarrifs.Find('-') then begin
                    glCode := tarrifs."G/L Account";
                    gl.Reset();
                    gl.SetRange("No.", tarrifs."G/L Account");
                    if gl.Find('-') then begin
                        glName := gl.Name;
                    end;
                end;
                //Paye 
                tarrifs.Reset();
                tarrifs.SetRange(Code, "<Payment Line>"."PAYE Code");
                if tarrifs.Find('-') then begin
                    payeAcc := tarrifs."G/L Account";
                    gl.Reset();
                    gl.SetRange("No.", tarrifs."G/L Account");
                    if gl.Find('-') then begin
                        payeNm := gl.Name;
                    end;
                end;

                //retention
                tarrifs.Reset();
                tarrifs.SetRange(Code, "<Payment Line>"."Retention Code");
                if tarrifs.Find('-') then begin
                    Renetiongl := tarrifs."G/L Account";
                    gl.Reset();
                    gl.SetRange("No.", tarrifs."G/L Account");
                    if gl.Find('-') then begin
                        renetionName := gl.Name;
                    end;
                end;
                Users.Reset;
                Users.SetRange(Users."User Name", Cashier);
                if Users.Find('-') then begin
                    if Users."Full Name" = '' then UserName := Users."User Name" else UserName := Users."Full Name";
                end;





                IF vends.GET(PaymentHeader."Vendor No.") THEN BEGIN
                END;
                StrCopyText := '';
                IF "No. Printed" >= 1 THEN BEGIN
                    StrCopyText := 'DUPLICATE';
                END;
                TTotal := 0;

                IF PaymentHeader."Payment Type" = PaymentHeader."Payment Type"::Normal THEN
                    DOCNAME := 'PAYMENT VOUCHER'
                ELSE
                    DOCNAME := 'PETTY CASH VOUCHER';

                //Set currcode to Default if blank
                GLSetup.GET();
                IF PaymentHeader."Currency Code" = '' THEN BEGIN
                    CurrCode := GLSetup."LCY Code";
                END ELSE
                    CurrCode := PaymentHeader."Currency Code";

                //For Inv Curr Code
                IF PaymentHeader."Invoice Currency Code" = '' THEN BEGIN
                    InvoiceCurrCode := GLSetup."LCY Code";
                END ELSE
                    InvoiceCurrCode := PaymentHeader."Invoice Currency Code";

                //End;
                CALCFIELDS("Total Payment Amount", "Total Witholding Tax Amount", PaymentHeader."Total Net Amount");

                InitTextVariable;
                FormatNoText(NumberText, "Total Net Amount", CurrencyCodeText);

                userSet.Reset();
                userSet.SetRange("User ID", Cashier);
                if userSet.FindFirst() then begin
                    userSet.CalcFields("User Signature");
                end;
                /*ApprovalEntry.reset;
                ApprovalEntry.SetRange("Document No.", PaymentHeader."No.");
                ApprovalEntry.SetFilter("Sequence No.", '=%1', 1);
                if ApprovalEntry.FindFirst() then begin
                    Approver1 := ApprovalEntry."Approver ID";
                    AppravalDate1 := (ApprovalEntry."Last Date-Time Modified");
                    UserSetUp.Reset();
                    UserSetUp.setrange("User ID", ApprovalEntry."Approver ID");
                    if UserSetUp.findfirst() then begin
                        UserSetUp.CalcFields("User Signature");
                        Verificationofficer := UserSetUp."Approval Title";
                        // SigNature1:=UserSetUp."User Signature";


                    end
                end;

                ApprovalEntry.reset;
                ApprovalEntry.SetRange("Document No.", PaymentHeader."No.");
                ApprovalEntry.SetFilter("Sequence No.", '=%1', 2);
                if ApprovalEntry.FindFirst() then begin
                    Approver2 := ApprovalEntry."Approver ID";
                    ApprovalDate2 := (ApprovalEntry."Last Date-Time Modified");
                    UserSetUp.Reset();
                    UserSetUp.setrange("User ID", ApprovalEntry."Approver ID");
                    if UserSetUp.findfirst() then begin
                        UserSetUp.CalcFields("User Signature");
                        ApprovarDestination2 := UserSetUp."Approval Title";


                    end
                end;

                ApprovalEntry.reset;
                ApprovalEntry.SetRange("Document No.", PaymentHeader."No.");
                ApprovalEntry.SetFilter("Sequence No.", '=%1', 3);
                if ApprovalEntry.FindFirst() then begin
                    Approver3 := ApprovalEntry."Approver ID";
                    ApprovalDate3 := (ApprovalEntry."Last Date-Time Modified");
                    UserSetUp.Reset();
                    UserSetUp.setrange("User ID", ApprovalEntry."Approver ID");
                    if UserSetUp.findfirst() then begin
                        UserSetUp.CalcFields("User Signature");
                        ApprovarDestination3 := UserSetUp."Approval Title";


                    end
                end;
                ApprovalEntry.reset;
                ApprovalEntry.SetRange("Document No.", PaymentHeader."No.");
                ApprovalEntry.SetFilter("Sequence No.", '=%1', 4);
                if ApprovalEntry.FindFirst() then begin
                    Approver4 := ApprovalEntry."Approver ID";
                    ApprovalDate4 := (ApprovalEntry."Last Date-Time Modified");
                    UserSetUp.Reset();
                    UserSetUp.setrange("User ID", ApprovalEntry."Approver ID");
                    if UserSetUp.findfirst() then begin
                        UserSetUp.CalcFields("User Signature");
                        ApprovarDestination4 := UserSetUp."Approval Title";


                    end
                end;*/
                ApprovalEntry1.Reset();
                ApprovalEntry1.SetRange("Document No.", PaymentHeader."No.");
                ApprovalEntry1.SetRange(Status, ApprovalEntry1.Status::Approved);
                ApprovalEntry1.SetRange("Sequence No.", 1);
                if ApprovalEntry1.FindFirst() then begin
                    ApprovalUserSetUp1.SetRange("User ID", ApprovalEntry1."Approver ID");
                    if ApprovalUserSetUp1.FindFirst() then;
                    ApprovalUserSetUp1.CalcFields("User Signature");
                    //get approval username and signature
                end;
                //approval entry 2nd approver
                ApprovalEntry2.Reset();
                ApprovalEntry2.SetRange("Document No.", PaymentHeader."No.");
                ApprovalEntry2.SetRange(Status, ApprovalEntry2.Status::Approved);
                ApprovalEntry2.SetRange("Sequence No.", 2);
                if ApprovalEntry2.FindFirst() then begin
                    ApprovalUserSetUp2.SetRange("User ID", ApprovalEntry2."Approver ID");
                    if ApprovalUserSetUp2.FindFirst() then;
                    ApprovalUserSetUp2.CalcFields("User Signature");
                    //get approval username and signature
                end;
                //approval entry 3rd approver
                ApprovalEntry3.Reset();
                ApprovalEntry3.SetRange("Document No.", PaymentHeader."No.");
                ApprovalEntry3.SetRange(Status, ApprovalEntry3.Status::Approved);
                ApprovalEntry3.SetRange("Sequence No.", 3);
                if ApprovalEntry3.FindFirst() then begin
                    ApprovalUserSetUp3.SetRange("User ID", ApprovalEntry3."Approver ID");
                    if ApprovalUserSetUp3.FindFirst() then;
                    ApprovalUserSetUp3.CalcFields("User Signature");
                    //get approval username and signature
                end;
                //approval entry 4th approver
                ApprovalEntry4.Reset();
                ApprovalEntry4.SetRange("Document No.", PaymentHeader."No.");
                ApprovalEntry4.SetRange(Status, ApprovalEntry4.Status::Approved);
                ApprovalEntry4.SetRange("Sequence No.", 4);
                if ApprovalEntry4.FindFirst() then begin
                    ApprovalUserSetUp4.SetRange("User ID", ApprovalEntry4."Approver ID");
                    if ApprovalUserSetUp4.FindFirst() then;
                    ApprovalUserSetUp4.CalcFields("User Signature");
                    //get approval username and signature
                end;
                ApprovalEntry5.Reset();
                ApprovalEntry5.SetRange("Document No.", PaymentHeader."No.");
                ApprovalEntry5.SetRange(Status, ApprovalEntry4.Status::Approved);
                ApprovalEntry5.SetRange("Sequence No.", 5);
                if ApprovalEntry5.FindFirst() then begin
                    ApprovalUserSetUp5.SetRange("User ID", ApprovalEntry5."Approver ID");
                    if ApprovalUserSetUp5.FindFirst() then;
                    ApprovalUserSetUp5.CalcFields("User Signature");
                    //get approval username and signature
                end;
                "<Payment Line>".reset;
                "<Payment Line>".SetRange(No, PaymentHeader."No.");
                if "<Payment Line>".find('-') then Begin
                    "<Payment Line>".CalcFields("Budgeted Amount");

                    //"<Payment Line>".CalcFields("Budget Balance");
                    BudgetBalance := "<Payment Line>"."Budget Balance" + "<Payment Line>"."Net Amount";


                End


            end;


            trigger OnPostDataItem()
            var

            begin
                IF CurrReport.PREVIEW = FALSE THEN BEGIN
                    "No. Printed" := "No. Printed" + 1;
                    MODIFY;
                END;
            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FIELDNO("No.");
                CompInfo.GET;
                CompInfo.CALCFIELDS(Picture);
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

    var
        userSet: Record "User Setup";
        BudgetBalance: decimal;
        tarrifs: Record "FIN-Tariff Codes";
        payeAcc: code[20];
        glName: text[250];
        glCode: code[20];
        gl: record "G/L Account";
        payeNm: text[250];
        renetionName: text[250];
        Renetiongl: code[20];
        Approver1: code[20];
        Approver2: code[20];
        approver3: code[20];
        approver4: code[20];
        ApprovarDestination3: text;
        ApprovarDestination4: text;
        ApprovarDestination2: text;
        ApproverDestination3: text;
        AppravalDate1: DateTime;
        ApprovalDate2: DateTime;
        approvalDate3: DateTime;
        approvalDate4: DateTime;

        Signature1: text[250];
        ApproverID_1: Text[20];
        ApproverDate_1: Date;
        ApprovalEntry1: Record "Approval Entry";
        ApprovalUserSetUp1: Record "User Setup";
        ApprovalEntry2: Record "Approval Entry";
        ApprovalUserSetUp2: Record "User Setup";
        ApprovalEntry3: Record "Approval Entry";
        ApprovalUserSetUp3: Record "User Setup";
        ApprovalEntry4: Record "Approval Entry";
        ApprovalUserSetUp4: Record "User Setup";
        ApprovalEntry5: Record "Approval Entry";
        ApprovalUserSetUp5: Record "User Setup";
        ApprovalEntry6: Record "Approval Entry";
        ApprovalUserSetUp6: Record "User Setup";
        ApprovalEntry7: Record "Approval Entry";
        ApprovalUserSetUp7: Record "User Setup";





        StrCopyText: Text[30];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        DimVal: Record "Dimension Value";
        DimValName: Text[100];
        TTotal: Decimal;
        CheckReport: Report "Check2";
        NumberText: array[2] of Text[1024];
        STotal: Decimal;
        InvoiceCurrCode: Code[10];
        Verificationofficer: Text;
        CurrCode: Code[10];
        GLSetup: Record 98;
        DOCNAME: Text[30];
        InvAmount: Decimal;
        CompInfo: Record "Company Information";
        VATCaptionLbl: Label 'VAT';
        PAYMENT_DETAILSCaptionLbl: Label 'PAYMENT DETAILS';
        AMOUNTCaptionLbl: Label 'AMOUNT';
        NET_AMOUNTCaptionLbl: Label 'NET AMOUNT';
        W_TAXCaptionLbl: Label 'W/TAX';
        Document_No___CaptionLbl: Label 'Document No. :';
        Currency_CaptionLbl: Label 'Currency:';
        Payment_To_CaptionLbl: Label 'Payment To:';
        Document_Date_CaptionLbl: Label 'Document Date:';
        Cheque_No__CaptionLbl: Label 'Cheque No.:';
        R_CENTERCaptionLbl: Label 'R.CENTER';
        PROJECTCaptionLbl: Label 'PROJECT';
        TotalCaptionLbl: Label 'Total';
        Printed_By_CaptionLbl: Label 'Printed By:';
        Amount_in_wordsCaptionLbl: Label 'Amount in words';
        EmptyStringCaptionLbl: Label '================================================================================================================================================================================================';
        RecipientCaptionLbl: Label 'Recipient';
        Signature_CaptionLbl: Label 'Signature:';
        Date_CaptionLbl: Label 'Date:';
        Name_CaptionLbl: Label 'Name:';
        EmptyStringCaption_Control1102755013Lbl: Label '================================================================================================================================================================================================';
        Amount_in_wordsCaption_Control1102755021Lbl: Label 'Amount in words';
        Printed_By_Caption_Control1102755026Lbl: Label 'Printed By:';
        TotalCaption_Control1102755033Lbl: Label 'Total';
        name: Label 'THE KENYATTA INTERNATIONAL CONFERENCE CENTRE';
        "name+": Label '(CORPORATION)';
        addr: Label 'Private Bag, Tel.+020 2046895 / 0722814900';
        email: Label 'MASENO,Kenya.Email info@kicc.co.ke,Website:www.kicc.co.ke';
        PIN: Label 'PIN:';
        VAT: Label 'VAT:';
        no: Label 'L.P.O/L.S.O';
        ret: Label 'Retention';
        appliedinv: Label 'Applied Invoice(s) Details';
        confir: Label 'I confirm accuracy and authenticity of the payment and that this expenditure has been entered in the votebook and is sufficiently covered.';
        next1: Label 'has been entered in the votebook and is sufficiently covered.';
        dat: Label 'DATE:.';
        PREPARE: Label 'PREPARE .';
        checked: Label 'CHECKED .';
        appr: Label 'APPROVED .';
        confirma: Label 'CONFIRMED .';
        internals: Label 'Internal Audit Manage';
        paymentapp: Label 'Payment Approved:';
        md: Label 'Managing Director:';
        Authorized: Label 'Authorized.';
        emptystr: Label '========================================================================================================================================';
        id: Label 'ID No:';
        accntnt: Label 'Accountant:';
        fincont: Label 'Financial Controller:';
        payTypes: Record "FIN-Receipts and Payment Types";
        vends: Record Vendor;
        pg: Page 5600;

        CompInf: Record "Company Information";
        NumberTextOne: Text;
        NumberTextTwo: Text;
        DimValues: Record "Dimension Value";
        CompName: Text[100];
        TypeOfDoc: Text[100];
        BankName: Text[100];
        Banks: Record "Bank Account";
        BankNo: Code[50];
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        CurrencyCodeText: Code[10];
        Users: Record User;
        UserName: Text[130];
        VendorLedgEntry: Record "Vendor Ledger Entry";
        Desc: Text[70];
        GLEntry: Record "G/L Entry";
        Text000: Label 'Preview is not allowed.';
        TXT002: Label '%1, %2 %3';
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
                //
                //AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + ' KOBO');
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