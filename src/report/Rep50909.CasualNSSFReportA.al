report 50909 "Casual - NSSF Report (A)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Casual - NSSF Report (A).rdl';

    dataset
    {
        dataitem(DataItem1000000009; "HRM-Employee C")
        {
            DataItemTableView = WHERE("Employee Category" = FILTER('CASUALS' | 'CASUAL'));
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
            column(CompPin; CompanyInformation."Company P.I.N")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompRegNo; CompanyInformation."Registration No.")
            {
            }
            column(PerName; PRLPayrollPeriods."Period Name" + ' (' + FORMAT(NoOfInstalments) + ')')
            {
            }
            column(pfNo; "No.")
            {
            }
            column(EmpPin; "PIN Number")
            {
            }
            column(EmpId; "ID Number")
            {
            }
            column(FName; "Last Name")
            {
            }
            column(MName; "Middle Name")
            {
            }
            column(LName; "First Name")
            {
            }
            column(EmployeeAmount; PRLPeriodTransactions.Amount)
            {
            }
            column(EmployerAmount; PRLEmployerDeductions.Amount)
            {
            }
            column(NHIFNo; "NHIF No.")
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
            column(region; Region)
            {
            }
            column(seq; seq)
            {
            }
            column(NssFNo; "NSSF No.")
            {
            }
            column(CurrGross; CurrGross)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(SaccoSh);
                CLEAR(SaccoLoanRep);
                CLEAR(LoanInt);
                CLEAR(XmasSav);
                CLEAR(PapoUpesi);
                CLEAR(CurrGross);
                CLEAR(NSSFAmount);
                //Shares
                PRLPeriodTransactions.RESET;
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code", "No.");
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code", 'DEFCON');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Group Text", 'TAXATION');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period", datefilter);
                PRLPeriodTransactions.SETRANGE("Current Instalment", NoOfInstalments);
                IF PRLPeriodTransactions.FIND('-') THEN BEGIN
                    NSSFAmount := PRLPeriodTransactions.Amount;
                END;

                //Gross
                PRLPeriodTransactions.RESET;
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code", "No.");
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code", 'GPAY');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period", datefilter);
                PRLPeriodTransactions.SETRANGE("Current Instalment", NoOfInstalments);
                IF PRLPeriodTransactions.FIND('-') THEN BEGIN
                    CurrGross := PRLPeriodTransactions.Amount;
                END;
                /*
                //Loan Interest
                PRLPeriodTransactions.RESET;
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code","HRM-Employee (D)"."No.");
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code",'INT001');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period",datefilter);
                IF PRLPeriodTransactions.FIND('-') THEN BEGIN
                LoanInt:=PRLPeriodTransactions.Amount;
                  END;
                
                //Xmas Savings
                PRLPeriodTransactions.RESET;
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code","HRM-Employee (D)"."No.");
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code",'XMA001');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period",datefilter);
                IF PRLPeriodTransactions.FIND('-') THEN BEGIN
                XmasSav:=PRLPeriodTransactions.Amount;
                  END;
                
                //Papo & Upesi
                PRLPeriodTransactions.RESET;
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Employee Code","HRM-Employee (D)"."No.");
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Transaction Code",'PAP001');
                PRLPeriodTransactions.SETRANGE(PRLPeriodTransactions."Payroll Period",datefilter);
                IF PRLPeriodTransactions.FIND('-') THEN BEGIN
                PapoUpesi:=PRLPeriodTransactions.Amount;
                  END;
                
                */

                Gtoto := NSSFAmount;//+PRLEmployerDeductions.Amount;
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
                field(NoOfInstalments; NoOfInstalments)
                {
                    Caption = 'instalment';
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
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        //objPeriod.SETFILTER("Payroll Code",'%1|%2','CASUAL','CASUALS');
        IF objPeriod.FIND('-') THEN BEGIN
            datefilter := objPeriod."Date Openned";
            NoOfInstalments := objPeriod."Current Instalment";
            PeriodName := objPeriod."Period Name";
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
    end;

    var
        NoOfInstalments: Integer;
        datefilter: Date;
        PRLPayrollPeriods: Record "PRL-Casual Payroll Periods";
        CompanyInformation: Record 79;
        PRLPeriodTransactions: Record "PRL-Casual Period Transactions";
        PRLEmployerDeductions: Record "PRL-Casual Employer Deductions";
        Gtoto: Decimal;
        PRLTransactionCodes: Record "PRL-Transaction Codes";
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
        NSSFAmount: Decimal;
        CurrGross: Decimal;
        objPeriod: Record "PRL-Casual Payroll Periods";
        PeriodName: Code[20];
}

