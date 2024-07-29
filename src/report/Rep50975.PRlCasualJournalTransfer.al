report 50975 "PRl-Casual Journal Transfer"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(EmpDaysWorked; "PRL Employee Days Worked")
        {

            trigger OnAfterGetRecord()
            begin
                //For use when posting Pension and NSSF
                objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod."Date Openned", SelectedPeriod);
                IF objPeriod.FIND('-') THEN BEGIN
                    //Get the staff details (header)
                    objEmp.SETRANGE(objEmp."No.", "Employee Code");
                    IF objEmp.FIND('-') THEN BEGIN
                        strEmpName := '[' + "Employee Code" + '] ' + objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                        GlobalDim1 := objEmp."Department Code";
                    END;

                    LineNumber := LineNumber + 10;


                    PeriodTrans.RESET;
                    PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "Employee Code");
                    PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                    IF PeriodTrans.FIND('-') THEN BEGIN
                        REPEAT

                            IF PeriodTrans."Journal Account Code" <> '' THEN BEGIN

                                /* SaccoTransactionType:=SaccoTransactionType::" ";

                                IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::loan THEN
                                   SaccoTransactionType:=SaccoTransactionType::Repayment;

                                IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::"loan Interest" THEN
                                   SaccoTransactionType:=SaccoTransactionType::"Interest Paid";

                                IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::Welfare THEN
                                   SaccoTransactionType:=SaccoTransactionType::"Welfare Contribution";

                                IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::shares THEN
                                   SaccoTransactionType:=SaccoTransactionType::"Deposit Contribution";
                                */


                                // Insert into Journal Details

                                PayrollJournalDetails.RESET;
                                PayrollJournalDetails.SETRANGE(PayrollJournalDetails."Employee Code", PeriodTrans."Employee Code");
                                PayrollJournalDetails.SETRANGE(PayrollJournalDetails."Transaction Code", PeriodTrans."Transaction Code");
                                PayrollJournalDetails.SETRANGE(PayrollJournalDetails."Period Month", PeriodTrans."Period Month");
                                PayrollJournalDetails.SETRANGE(PayrollJournalDetails."Period Year", PeriodTrans."Period Year");
                                IF PayrollJournalDetails.FIND('-') THEN BEGIN
                                    PayrollJournalDetails."G/L Account" := PeriodTrans."Journal Account Code";
                                    PayrollJournalDetails."Posting Description" := COPYSTR(objPeriod."Period Name" + ' - ' + PeriodTrans."Transaction Name", 1, 50);
                                    PayrollJournalDetails.Amount := PeriodTrans.Amount;
                                    PayrollJournalDetails."Post as" := PeriodTrans."Post As";
                                    PayrollJournalDetails."coop parameters" := PeriodTrans."coop parameters";
                                    PayrollJournalDetails."Journal Account Type" := PeriodTrans."Journal Account Type";
                                    PayrollJournalDetails.MODIFY;
                                END ELSE BEGIN
                                    PayrollJournalDetails.INIT;
                                    PayrollJournalDetails."Employee Code" := PeriodTrans."Employee Code";
                                    PayrollJournalDetails."Transaction Code" := PeriodTrans."Transaction Code";
                                    PayrollJournalDetails."Period Month" := PeriodTrans."Period Month";
                                    PayrollJournalDetails."Period Year" := PeriodTrans."Period Year";
                                    PayrollJournalDetails."Transaction Name" := PeriodTrans."Transaction Name";
                                    PayrollJournalDetails."G/L Account" := PeriodTrans."Journal Account Code";
                                    PayrollJournalDetails."Posting Description" := COPYSTR(objPeriod."Period Name" + ' - ' + PeriodTrans."Transaction Name", 1, 50);
                                    PayrollJournalDetails.Amount := PeriodTrans.Amount;
                                    PayrollJournalDetails."Post as" := PeriodTrans."Post As";
                                    PayrollJournalDetails."coop parameters" := PeriodTrans."coop parameters";
                                    PayrollJournalDetails."Journal Account Type" := PeriodTrans."Journal Account Type";
                                    PayrollJournalDetails.INSERT;
                                END;// Does not exist, Insert

                                // Insert into Journal Summary
                                PayrollJournalSummary.RESET;
                                PayrollJournalSummary.SETRANGE(PayrollJournalSummary."Transaction Code", PeriodTrans."Transaction Code");
                                PayrollJournalSummary.SETRANGE(PayrollJournalSummary."Period Month", PeriodTrans."Period Month");
                                PayrollJournalSummary.SETRANGE(PayrollJournalSummary."Period YearS", PeriodTrans."Period Year");
                                IF PayrollJournalSummary.FIND('-') THEN BEGIN
                                    PayrollJournalSummary."G/L Account" := PeriodTrans."Journal Account Code";
                                    PayrollJournalSummary."Transaction Name" := PeriodTrans."Transaction Name";
                                    PayrollJournalSummary."Posting Description" := COPYSTR(objPeriod."Period Name" + ' - ' + PeriodTrans."Transaction Name", 1, 50);
                                    PayrollJournalSummary."Post as" := PeriodTrans."Post As";
                                    PayrollJournalSummary."coop parameters" := PeriodTrans."coop parameters";
                                    PayrollJournalSummary."Journal Account Type" := PeriodTrans."Journal Account Type";
                                    PayrollJournalSummary.MODIFY;
                                END ELSE BEGIN
                                    PayrollJournalSummary.INIT;
                                    PayrollJournalSummary."Transaction Code" := PeriodTrans."Transaction Code";
                                    PayrollJournalSummary."Transaction Name" := PeriodTrans."Transaction Name";
                                    PayrollJournalSummary."G/L Account" := PeriodTrans."Journal Account Code";
                                    PayrollJournalSummary."Period Month" := PeriodTrans."Period Month";
                                    PayrollJournalSummary."Period YearS" := PeriodTrans."Period Year";
                                    PayrollJournalSummary."Posting Description" := COPYSTR(objPeriod."Period Name" + ' - ' + PeriodTrans."Transaction Name", 1, 50);
                                    PayrollJournalSummary."Post as" := PeriodTrans."Post As";
                                    PayrollJournalSummary."coop parameters" := PeriodTrans."coop parameters";
                                    PayrollJournalSummary."Journal Account Type" := PeriodTrans."Journal Account Type";
                                    PayrollJournalSummary.INSERT;
                                END;

                                /*

                                    //Pension
                                    IF PeriodTrans."coop parameters"=PeriodTrans."coop parameters"::Pension THEN BEGIN
                                      //Get from Employer Deduction
                                      EmployerDed.RESET;
                                      EmployerDed.SETRANGE(EmployerDed."Employee Code",PeriodTrans."Employee Code");
                                      EmployerDed.SETRANGE(EmployerDed."Transaction Code",PeriodTrans."Transaction Code");
                                      EmployerDed.SETRANGE(EmployerDed."Payroll Period",PeriodTrans."Payroll Period");
                                      IF EmployerDed.FIND('-') THEN BEGIN
                                      //Credit Payables
                                          CreateJnlEntry(0,PostingGroup."Pension Employee Acc",
                                          GlobalDim1,'',PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",0,
                                          EmployerDed.Amount,PeriodTrans."Post As",'',SaccoTransactionType,PostingGroup."Pension Payable Acc");

                                      //Debit Staff Expense
                                          CreateJnlEntry(0,PostingGroup."Pension Employer Acc",
                                          GlobalDim1,'',PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",EmployerDed.Amount,0,1,'',
                                          SaccoTransactionType,PostingGroup."Pension Payable Acc");

                                      END;
                                    END;

                                    //NSSF
                                    IF PeriodTrans."coop parameters"=PeriodTrans."coop parameters"::NSSF THEN BEGIN
                                       //Credit Payables
                                      //Credit Payables

                                          CreateJnlEntry(0,PostingGroup."NSSF Employee Account",
                                          GlobalDim1,'',PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",0,PeriodTrans.Amount,
                                          PeriodTrans."Post As",'',SaccoTransactionType,PostingGroup."NSSF Payable Acc");

                                      //Debit Staff Expense

                                          CreateJnlEntry(0,PostingGroup."NSSF Employer Account",
                                          GlobalDim1,'',PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",PeriodTrans.Amount,0,1,'',
                                          SaccoTransactionType,PostingGroup."NSSF Payable Acc");


                                    END;*/


                            END;
                        UNTIL PeriodTrans.NEXT = 0;
                    END;
                END;

            end;

            trigger OnPostDataItem()
            var
                PensionAmountToPost: Decimal;
                NssfAmountToPost: Decimal;
            begin
                objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod."Date Openned", SelectedPeriod);
                IF objPeriod.FIND('-') THEN BEGIN
                    PayrollJournalSummary.RESET;
                    PayrollJournalSummary.SETRANGE(PayrollJournalSummary."Period Month", objPeriod."Period Month");
                    PayrollJournalSummary.SETRANGE(PayrollJournalSummary."Period YearS", objPeriod."Period Year");
                    IF PayrollJournalSummary.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            PayrollJournalSummary.CALCFIELDS(PayrollJournalSummary.Amount);

                            AmountToDebit := 0;
                            AmountToCredit := 0;
                            IF PayrollJournalSummary."Post as" = PayrollJournalSummary."Post as"::Debit THEN
                                AmountToDebit := PayrollJournalSummary.Amount;

                            IF PayrollJournalSummary."Post as" = PayrollJournalSummary."Post as"::Credit THEN
                                AmountToCredit := PayrollJournalSummary.Amount;

                            IF PayrollJournalSummary."Journal Account Type" = 1 THEN
                                IntegerPostAs := 0;
                            IF PayrollJournalSummary."Journal Account Type" = 2 THEN
                                IntegerPostAs := 1;

                            IF NOT (PayrollJournalSummary."coop parameters" = PayrollJournalSummary."coop parameters"::Pension) THEN BEGIN
                                IF NOT (PayrollJournalSummary."coop parameters" = PayrollJournalSummary."coop parameters"::NSSF) THEN BEGIN
                                    // Neither NSSF Nor Pension
                                    CreateJnlEntry(IntegerPostAs, PayrollJournalSummary."G/L Account",
                                    GlobalDim1, '', PayrollJournalSummary."Posting Description", AmountToDebit, AmountToCredit,
                                    PayrollJournalSummary."Post as", PayrollJournalSummary."Transaction Code", 0, PostingGroup."Net Salary Payable");
                                END ELSE BEGIN
                                    // NSSF i.e. has employer Factor for NSSF
                                    CLEAR(NssfAmountToPost);
                                    EmployerDed.RESET;
                                    // EmployerDed.SETRANGE(EmployerDed."Employee Code",PeriodTrans."Employee Code");
                                    EmployerDed.SETRANGE(EmployerDed."Transaction Code", PayrollJournalSummary."Transaction Code");
                                    EmployerDed.SETRANGE(EmployerDed."Payroll Period", objPeriod."Date Openned");
                                    IF EmployerDed.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            NssfAmountToPost := NssfAmountToPost + EmployerDed.Amount;
                                        END;
                                        UNTIL EmployerDed.NEXT = 0;

                                        //Credit Payables
                                        CreateJnlEntry(0, PostingGroup."NSSF Employer Account",
                                        GlobalDim1, '', 'Employer-' + PayrollJournalSummary."Posting Description", 0,
                                        NssfAmountToPost, PayrollJournalSummary."Post as", PayrollJournalSummary."Transaction Code", 0, PostingGroup."NSSF Payable Acc");

                                        //Debit Staff Expense
                                        CreateJnlEntry(0, PostingGroup."NSSF Employer Account",
                                        GlobalDim1, '', 'Employer-' + PayrollJournalSummary."Posting Description", NssfAmountToPost, 0, 1, '',
                                        0, PostingGroup."NSSF Payable Acc");
                                    END;
                                END;

                            END ELSE BEGIN
                                // Pension i.e. has employer Factor
                                CLEAR(PensionAmountToPost);
                                EmployerDed.RESET;
                                // EmployerDed.SETRANGE(EmployerDed."Employee Code",PeriodTrans."Employee Code");
                                EmployerDed.SETRANGE(EmployerDed."Transaction Code", PayrollJournalSummary."Transaction Code");
                                EmployerDed.SETRANGE(EmployerDed."Payroll Period", objPeriod."Date Openned");
                                IF EmployerDed.FIND('-') THEN BEGIN
                                    REPEAT
                                    BEGIN
                                        PensionAmountToPost := PensionAmountToPost + EmployerDed.Amount;
                                    END;
                                    UNTIL EmployerDed.NEXT = 0;

                                    //Credit Payables
                                    CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
                                    GlobalDim1, '', 'Employer-' + PayrollJournalSummary."Posting Description", 0,
                                    PensionAmountToPost, PayrollJournalSummary."Post as", PayrollJournalSummary."Transaction Code", 0, PostingGroup."Pension Payable Acc");

                                    //Debit Staff Expense
                                    CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
                                    GlobalDim1, '', 'Employer-' + PayrollJournalSummary."Posting Description", PensionAmountToPost, 0, 1, '',
                                    0, PostingGroup."Pension Payable Acc");
                                END;
                            END;
                        END;
                        UNTIL PayrollJournalSummary.NEXT = 0;
                    END;
                END;


                MESSAGE('Journals Created Successfully');
            end;

            trigger OnPreDataItem()
            begin
                PostingGroup.GET('PAYROLL');
                PostingGroup.TESTFIELD("NSSF Employer Account");
                PostingGroup.TESTFIELD("NSSF Employee Account");
                PostingGroup.TESTFIELD("Pension Employer Acc");
                PostingGroup.TESTFIELD("Pension Employee Acc");
                LineNumber := 10000;

                //Create batch*****************************************************************************
                GenJnlBatch.RESET;
                GenJnlBatch.SETRANGE(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SETRANGE(GenJnlBatch.Name, 'CASUALSAL');
                IF GenJnlBatch.FIND('-') = FALSE THEN BEGIN
                    GenJnlBatch.INIT;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'CASUALSAL';
                    GenJnlBatch.INSERT;
                END;
                // End Create Batch

                // Clear the journal Lines
                GeneraljnlLine.SETRANGE(GeneraljnlLine."Journal Batch Name", 'CASUALSAL');
                IF GeneraljnlLine.FIND('-') THEN
                    GeneraljnlLine.DELETEALL;

                "Slip/Receipt No" := UPPERCASE(objPeriod."Period Name");

                //"PRL-Salary Card".SETRANGE("PRL-Salary Card"."Payroll Period",SelectedPeriod);

                PayrollJournalDetails.RESET;
                IF PayrollJournalDetails.FIND('-') THEN BEGIN
                    PayrollJournalDetails.DELETEALL
                END;

                PayrollJournalSummary.RESET;
                IF PayrollJournalSummary.FIND('-') THEN BEGIN
                    PayrollJournalSummary.DELETEALL
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(PeriodFilter; PeriodFilter)
                {
                    Caption = 'Period Filter';
                    TableRelation = "PRL-Casual Payroll Periods";
                }
            }
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
        //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        IF PeriodFilter = 0D THEN ERROR('You must specify the period filter');

        SelectedPeriod := PeriodFilter;
        objPeriod.RESET;
        objPeriod.SETRANGE("Date Openned", SelectedPeriod);
        IF objPeriod.FIND('-') THEN PeriodName := objPeriod."Period Name";

        PostingDate := CALCDATE('1M-1D', SelectedPeriod);
    end;

    var
        PeriodTrans: Record "PRL-Casual Period Transactions";
        objEmp: Record "HRM-Employee C";
        PeriodName: Text[30];
        PeriodFilter: Date;
        SelectedPeriod: Date;
        objPeriod: Record "PRL-Casual Payroll Periods";
        ControlInfo: Record "HRM-Control-Information";
        strEmpName: Text[150];
        GeneraljnlLine: Record 81;
        GenJnlBatch: Record 232;
        "Slip/Receipt No": Code[50];
        LineNumber: Integer;
        "Salary Card": Record "PRL Employee Days Worked";
        TaxableAmount: Decimal;
        PostingGroup: Record "PRL-Employee Posting Group";
        GlobalDim1: Code[10];
        GlobalDim2: Code[10];
        TransCode: Record "PRL-Transaction Codes";
        PostingDate: Date;
        AmountToDebit: Decimal;
        AmountToCredit: Decimal;
        IntegerPostAs: Integer;
        SaccoTransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2";
        EmployerDed: Record "PRL-Casual Employer Deductions";
        PeriodFilter2: Code[20];
        PayrollJournalDetails: Record "CasualPayroll Journal Details";
        PayrollJournalSummary: Record "Casual Payroll Journal Sum.";

    procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2"; BalAccountNo: Code[20])
    begin

        LineNumber := LineNumber + 100;
        GeneraljnlLine.INIT;
        GeneraljnlLine."Journal Template Name" := 'GENERAL';
        GeneraljnlLine."Journal Batch Name" := 'CASUALSAL';
        GeneraljnlLine."Line No." := LineNumber;
        GeneraljnlLine."Document No." := "Slip/Receipt No";
        //GeneraljnlLine."Loan No":=LoanNo;
        //GeneraljnlLine."Transaction Type":=TransType;
        GeneraljnlLine."Posting Date" := PostingDate;
        GeneraljnlLine."Account Type" := AccountType;
        GeneraljnlLine."Account No." := AccountNo;
        GeneraljnlLine.VALIDATE(GeneraljnlLine."Account No.");
        GeneraljnlLine.Description := Description;
        IF PostAs = PostAs::Debit THEN BEGIN
            GeneraljnlLine."Debit Amount" := DebitAmount;
            GeneraljnlLine.VALIDATE("Debit Amount");
        END ELSE BEGIN
            GeneraljnlLine."Credit Amount" := CreditAmount;
            GeneraljnlLine.VALIDATE("Credit Amount");
        END;
        GeneraljnlLine."Bal. Account No." := BalAccountNo;
        GeneraljnlLine."Gen. Bus. Posting Group" := '';
        GeneraljnlLine."Gen. Prod. Posting Group" := '';
        GeneraljnlLine."Shortcut Dimension 1 Code" := 'Main';
        GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 1 Code");
        // GeneraljnlLine."Shortcut Dimension 2 Code":=GlobalDime2;
        // GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 2 Code");
        IF GeneraljnlLine.Amount <> 0 THEN
            GeneraljnlLine.INSERT;
    end;
}

