report 50911 "PRL-Casual PAYE Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PRLCasualPAYEReport.rdl';

    dataset
    {
        dataitem("HRM-Employee C"; "HRM-Employee C")
        {
            DataItemTableView = WHERE("Employee Category" = FILTER('CASUAL' | 'CASUALS'));
            column(GCode; '')
            {
            }
            column(GName; '')
            {
            }
            column(TransCode; 'PAYE')
            {
            }
            column(TransaName; 'PAYE')
            {
            }
            column(groupFilter; groupFilter)
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompPhone1; CompanyInformation."Phone No.")
            {
            }
            column(CompPhone2; CompanyInformation."Phone No. 2")
            {
            }
            column(CompEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompPage; CompanyInformation."Home Page")
            {
            }
            column(CompPin; CompanyInformation."VAT Registration No.")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompRegNo; CompanyInformation."VAT Registration No.")
            {
            }
            column(PerName; PRLPayrollPeriods."Period Name" + ' (CASUALS)')
            {
            }
            column(pfNo; "HRM-Employee C"."No.")
            {
            }
            column(EmpPin; "HRM-Employee C"."PIN Number")
            {
            }
            column(EmpId; "HRM-Employee C"."ID Number")
            {
            }
            column(FName; "HRM-Employee C"."Last Name")
            {
            }
            column(MName; "HRM-Employee C"."Middle Name")
            {
            }
            column(LName; "HRM-Employee C"."First Name")
            {
            }
            column(EmployeeAmount; PRLPeriodTransactions.Amount)
            {
            }
            column(EmployerAmount; PRLEmployerDeductions.Amount)
            {
            }
            column(NHIFNo; "HRM-Employee C"."NHIF No.")
            {
            }
            column(Gtot; Gtoto)
            {
            }
            column(SaccoSh; SaccoSh)
            {
            }
            column(SaccoLoanRep; SaccoLoanRep)
            {
            }
            column(LoanInt; LoanInt)
            {
            }
            column(XmasSav; XmasSav)
            {
            }
            column(PapoUpesi; PapoUpesi)
            {
            }
            column(region; "HRM-Employee C".Region)
            {
            }
            column(seq; seq)
            {
            }
            column(GrossAmount; GrossAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(SaccoSh);
                CLEAR(SaccoLoanRep);
                CLEAR(LoanInt);
                CLEAR(XmasSav);
                CLEAR(PapoUpesi);
                CLEAR(TransAmount);
                CLEAR(GrossAmount);
                //Shares
                PRLPeriodTransactions.RESET;
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code", "HRM-Employee C"."No.");
                PRLPeriodTransactions.SETFILTER(PRLPeriodTransactions."Transaction Code", 'PAYE|GPAY');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period", datefilter);
                IF PRLPeriodTransactions.FIND('-') THEN BEGIN
                    REPEAT
                        IF PRLPeriodTransactions."Transaction Code" = 'PAYE' THEN
                            TransAmount := PRLPeriodTransactions.Amount
                        ELSE
                            GrossAmount := PRLPeriodTransactions.Amount;
                    UNTIL PRLPeriodTransactions.NEXT = 0;
                END;
                /*
              //Loan Repayment
              PRLPeriodTransactions.RESET;
              PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code","HRM-Employee C"."No.");
              PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code",'LBD002');
              PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period",datefilter);
              IF PRLPeriodTransactions.FIND('-') THEN BEGIN
              SaccoLoanRep:=PRLPeriodTransactions.Amount;
                END;

              //Loan Interest
              PRLPeriodTransactions.RESET;
              PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code","HRM-Employee C"."No.");
              PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code",'INT001');
              PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period",datefilter);
              IF PRLPeriodTransactions.FIND('-') THEN BEGIN
              LoanInt:=PRLPeriodTransactions.Amount;
                END;

              //Xmas Savings
              PRLPeriodTransactions.RESET;
              PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code","HRM-Employee C"."No.");
              PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code",'XMA001');
              PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period",datefilter);
              IF PRLPeriodTransactions.FIND('-') THEN BEGIN
              XmasSav:=PRLPeriodTransactions.Amount;
                END;

              //Papo & Upesi
              PRLPeriodTransactions.RESET;
              PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code","HRM-Employee C"."No.");
              PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code",'PAP001');
              PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period",datefilter);
              IF PRLPeriodTransactions.FIND('-') THEN BEGIN
              PapoUpesi:=PRLPeriodTransactions.Amount;
                END;

              */

                Gtoto := TransAmount;//+PRLEmployerDeductions.Amount;
                IF Gtoto = 0 THEN CurrReport.SKIP ELSE seq := seq + 1;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DateFil; datefilter)
                {
                    Caption = 'Date Filter';
                    TableRelation = "PRL-Casual Payroll Periods"."Date Openned";
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
        PRLPayrollPeriods.RESET;
        PRLPayrollPeriods.SETRANGE(PRLPayrollPeriods.Closed, FALSE);
        IF PRLPayrollPeriods.FIND('-') THEN BEGIN
            datefilter := PRLPayrollPeriods."Date Openned";
        END;

        IF CompanyInformation.GET() THEN
            CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        CLEAR(Gtoto);
        CLEAR("Tot-SaccoSh");
        CLEAR("Tot-SaccoLoanRep");
        CLEAR("Tot-LoanInt");
        CLEAR("Tot-XmasSav");
        CLEAR("Tot-PapoUpesi");
        CLEAR(seq);
    end;

    trigger OnPreReport()
    begin
        IF datefilter = 0D THEN ERROR('Specify the Period Date');
        //"PRL-Period Transactions".SETFILTER("PRL-Period Transactions"."Payroll Period",'=%1',datefilter)
        PRLPayrollPeriods.RESET;
        PRLPayrollPeriods.SETRANGE(PRLPayrollPeriods."Date Openned", datefilter);
        IF PRLPayrollPeriods.FIND('-') THEN BEGIN
            // datefilter:=PRLPayrollPeriods."Date Openned";
        END;
    end;

    var
        datefilter: Date;
        PRLPayrollPeriods: Record "PRL-CASUAL PAYROLL PERIODS";
        CompanyInformation: Record 79;
        PRLPeriodTransactions: Record "PRL-CASUAL PERIOD TRANSACTIONS";
        PRLEmployerDeductions: Record "PRL-CASUAL EMPLOYER DEDUCTIONS";
        Gtoto: Decimal;
        PRLTransactionCodes: Record "PRL-TRANSACTION CODES";
        SaccoSh: Decimal;
        SaccoLoanRep: Decimal;
        LoanInt: Decimal;
        XmasSav: Decimal;
        PapoUpesi: Decimal;
        "Tot-SaccoSh": Decimal;
        "Tot-SaccoLoanRep": Decimal;
        "Tot-LoanInt": Decimal;
        "Tot-XmasSav": Decimal;
        "Tot-PapoUpesi": Decimal;
        HelbAm: Decimal;
        seq: Integer;
        TransAmount: Decimal;
        "PRL-Transaction Codes": Record "PRL-TRANSACTION CODES";
        groupFilter: Code[20];
        GrossAmount: Decimal;
}

