report 50025 "Detailed Trial Bal. (Monthly)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Finance/Reports/SSR/Detailed Trial Bal. (Monthly).rdl';

    dataset
    {
        dataitem(Gl; "G/L Account")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress1; CompanyInformation.Address)
            {
            }
            column(CompAddress2; CompanyInformation."Address 2")
            {
            }
            column(CompCity; CompanyInformation.City)
            {
            }
            column(CompPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompPhone2; CompanyInformation."Phone No. 2")
            {
            }
            column(CompMail; CompanyInformation."E-Mail")
            {
            }
            column(CompHomePage; CompanyInformation."Home Page")
            {
            }
            column(FilterPeriod_BankAccLedg; StrSubstNo(Text000, DateFilter_GLAccount))
            {
            }
            column(AccNo; "No.")
            {
            }
            column(AccName; Name)
            {
            }
            column(BeginingTotal; BeginingTotal)
            {
            }
            column(EndingTotal; EndingTotal)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            dataitem(DataItem1000000001; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("G/L Account No.", "Posting Date")
                                    ORDER(Ascending);
                RequestFilterFields = "G/L Account No.";
                column(PDate; "Posting Date")
                {
                }
                column(DocNo; "Document No.")
                {
                }
                column(Descr; Description)
                {
                }
                column(Payee; Payee)
                {

                }
                column(Customer_Name; "Customer Name")
                {

                }
                column(Remarks; Remarks)
                {

                }
                column(Amount; Amount)
                {
                }
                column(DebitAmount; "Debit Amount")
                {
                }
                column(CreditAmount; "Credit Amount")
                {
                }
                column(ExternalDocNo; "External Document No.")
                {
                }
                column(RunningTotal; RunningTotal)
                {
                }
                column(BeginBalance; BeginBalance)
                {
                }
                column(MonthDesc; MonthDesc)
                {
                }
                column(CountedMonths; CountedMonths)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    RunningTotal := RunningTotal + Amount;
                    CLEAR(MonthDesc);
                    CLEAR(CountedMonths);
                    IF DATE2DMY("Posting Date", 2) = 1 THEN BEGIN
                        MonthDesc := 'JANUARY';
                        CountedMonths := 7;
                    END;
                    IF DATE2DMY("Posting Date", 2) = 2 THEN BEGIN
                        MonthDesc := 'FEBRUARY';
                        CountedMonths := 8;
                    END;
                    IF DATE2DMY("Posting Date", 2) = 3 THEN BEGIN
                        MonthDesc := 'MARCH';
                        CountedMonths := 9;
                    END;
                    IF DATE2DMY("Posting Date", 2) = 4 THEN BEGIN
                        MonthDesc := 'APRIL';
                        CountedMonths := 10;
                    END;
                    IF DATE2DMY("Posting Date", 2) = 5 THEN BEGIN
                        MonthDesc := 'MAY';
                        CountedMonths := 11;
                    END;
                    IF DATE2DMY("Posting Date", 2) = 6 THEN BEGIN
                        MonthDesc := 'JUNE';
                        CountedMonths := 12;
                    END;
                    IF DATE2DMY("Posting Date", 2) = 7 THEN BEGIN
                        MonthDesc := 'JULY';
                        CountedMonths := 1;
                    END;
                    IF DATE2DMY("Posting Date", 2) = 8 THEN BEGIN
                        MonthDesc := 'AUGUST';
                        CountedMonths := 2;
                    END;
                    IF DATE2DMY("Posting Date", 2) = 9 THEN BEGIN
                        MonthDesc := 'SEPTEMBER';
                        CountedMonths := 3;
                    END;
                    IF DATE2DMY("Posting Date", 2) = 10 THEN BEGIN
                        MonthDesc := 'OCTOBER';
                        CountedMonths := 4;
                    END;
                    IF DATE2DMY("Posting Date", 2) = 11 THEN BEGIN
                        MonthDesc := 'NOVEMBER';
                        CountedMonths := 5;
                    END;
                    IF DATE2DMY("Posting Date", 2) = 12 THEN BEGIN
                        MonthDesc := 'DECEMBER';
                        CountedMonths := 6;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);

                end;
            }
            trigger OnPreDataItem()
            begin
                //      BeginingTotal := 0;
            end;

            trigger OnAfterGetRecord()

            begin
                CLEAR(BeginingTotal);
                CLEAR(EndingTotal);
                CLEAR(RunningTotal);

                GLAccount.RESET;
                GLAccount.SETFILTER("Date Filter", '..%1', CALCDATE('-1D', StartDate));
                GLAccount.SETRANGE("No.", Gl."No.");
                IF GLAccount.FIND('-') THEN BEGIN
                    IF GLAccount.CALCFIELDS(Balance) THEN BEGIN
                        BeginingTotal := GLAccount.Balance;
                    END;
                END;
                GLAccount.RESET;
                GLAccount.SETFILTER("Date Filter", '..%1', CALCDATE('-1D', StartDate));
                GLAccount.SETRANGE("No.", gl."No.");
                IF GLAccount.FIND('-') THEN BEGIN
                    IF GLAccount.CALCFIELDS(Balance) THEN BEGIN
                        // BeginingTotal += BeginingTotal + GLAccount.Balance;
                        RunningTotal := GLAccount.Balance;
                    END;
                END;

                GLAccount.RESET;
                GLAccount.SETFILTER("Date Filter", '..%1', CALCDATE('-1D', EndDate));
                GLAccount.SETRANGE("No.", gl."No.");
                IF GLAccount.FIND('-') THEN BEGIN
                    IF GLAccount.CALCFIELDS(Balance) THEN
                        EndingTotal := GLAccount.Balance;
                END;


                /* if DateFilter_GLAccount <> '' then
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields(Balance, "Balance at Date");
                        BeginingTotal := Balance;
                        StartBalanceToDate += StartBalance + "Balance at Date";
                        SetFilter("Date Filter", DateFilter_GLAccount);
                    end; */
            end;
        }


    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDates; StartDate)
                {
                    Caption = 'Start Date';
                }
                field(Enddates; EndDate)
                {
                    Caption = 'End Date';
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

    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
        END;
    end;

    trigger OnPreReport()

    begin
        GLAccFilter := GLAcc.GetFilters;
        DateFilter_GLAccount := GLAcc.GetFilter("Date Filter");
    end;

    var
        BeginingTotal: Decimal;
        Text000: Label 'Period: %1';
        GLAccFilter: Text;
        DateFilter_GLAccount: Text;
        EndingTotal: Decimal;
        GLAcc: Record "G/L Account";
        RunningTotal: Decimal;
        BeginBalance: Decimal;
        MonthDesc: Code[20];
        StartBalanceToDate: Decimal;
        StartBalance: Decimal;
        StartDate: Date;
        EndDate: Date;
        CompanyInformation: Record 79;
        CountedMonths: Integer;
        GLAccount: Record 15;

    local procedure CalcAmounts(StartDate: Date; DateTo: Date; var BeginBalance: Decimal; var DebitAmt: Decimal; var CreditAmt: Decimal; var TotalBalance: Decimal)
    var
        GLAccountCopy: Record "G/L Account";
    begin
        GLAccountCopy.Copy(GLAccount);

        GLAccountCopy.SetRange("Date Filter", 0D, StartDate - 1);
        GLAccountCopy.CalcFields(Balance);
        BeginBalance := GLAccountCopy.Balance;


    end;
}

