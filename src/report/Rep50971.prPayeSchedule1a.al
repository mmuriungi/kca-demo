report 50971 "prPaye Schedule 1a"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prPaye Schedule 1a.rdl';

    dataset
    {
        dataitem(DataItem6207; "PRL-Salary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code";
            column(USERID; USERID)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "Employee Code")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(PinNumber; PinNumber)
            {
            }
            column(PayeAmount; PayeAmount)
            {
            }
            column(TaxablePay; TaxablePay)
            {
            }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(TotPayeAmount; TotPayeAmount)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(P_A_Y_E_ScheduleCaption; P_A_Y_E_ScheduleCaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(PIN_Number_Caption; PIN_Number_CaptionLbl)
            {
            }
            column(Paye_Amount_Caption; Paye_Amount_CaptionLbl)
            {
            }
            column(Taxable_Pay_Caption; Taxable_Pay_CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(PensionRelief; PensionRelief)
            {
            }
            column(InsuranceRelief; InsuranceRelief)
            {
            }
            column(TotalPension; TotPensionRelief)
            {
            }
            column(TotalInsurance; TotInsuranceRelief)
            {
            }
            column(Grosspay; GrossPay)
            {
            }
            column(Pensionself; PensionSelf)
            {
            }
            column(Nssf; Nssf)
            {
            }
            column(Providentself; ProvidentSelf)
            {
            }
            column(PersonalRelief; PersonalRelief)
            {
            }
            column(TotalPersonal; TotPersonalRelief)
            {
            }
            column(payspaye; "Pays PAYE")
            {
            }
            column(PayeXPAmount; PayeXPAmount)
            {
            }
            column(TotalPAYE; PayeXPAmount + PayeAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin

                objEmp.RESET;
                objEmp.SETRANGE(objEmp."No.", "Employee Code");
                IF objEmp.FIND('-') THEN
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                PinNumber := objEmp."PIN Number";

                GrossPay := 0;
                PensionRelief := 0;
                InsuranceRelief := 0;
                TaxablePay := 0;
                PayeAmount := 0;
                ProvidentSelf := 0;
                Nssf := 0;
                PersonalRelief := 0;
                PensionSelf := 0;
                PayeXPAmount := 0;

                PeriodTrans.RESET;
                PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                //PeriodTrans.SETFILTER(PeriodTrans."Group Order",'=6|=7'); //Taxable Pay
                //PeriodTrans.SETFILTER(PeriodTrans."Sub Group Order",'=5|=3'); //Paye Amount
                IF PeriodTrans.FIND('-') THEN
                    REPEAT
                        //TXBP Taxable Pay -  BY DENNIS PSNR 690

                        IF (PeriodTrans."Transaction Code" = 'GPAY') THEN BEGIN
                            GrossPay := PeriodTrans.Amount;
                        END;

                        IF (PeriodTrans."Transaction Code" = '592') THEN BEGIN
                            ProvidentSelf := PeriodTrans.Amount;
                        END;

                        IF ((PeriodTrans."Transaction Code" = 'D-420') OR
                          (PeriodTrans."Transaction Code" = 'D-486') OR
                          (PeriodTrans."Transaction Code" = 'D-906') OR
                          (PeriodTrans."Transaction Code" = 'D-909') OR
                          (PeriodTrans."Transaction Code" = 'D-916') OR
                          (PeriodTrans."Transaction Code" = 'D-946') OR
                          (PeriodTrans."Transaction Code" = 'D-982')) THEN BEGIN
                            PensionSelf := PeriodTrans.Amount;
                        END;

                        IF (PeriodTrans."Transaction Code" = 'PSNR') THEN BEGIN
                            PersonalRelief := PeriodTrans.Amount;
                        END;

                        IF (PeriodTrans."Transaction Code" = 'NSSF') THEN BEGIN
                            Nssf := PeriodTrans.Amount;
                        END;

                        IF (PeriodTrans."Transaction Code" = 'TXBP') THEN BEGIN
                            TaxablePay := PeriodTrans.Amount;
                        END;
                        IF (PeriodTrans."Transaction Code" = 'NHIFINSR') THEN BEGIN
                            InsuranceRelief := PeriodTrans.Amount;
                        END;
                        IF (PeriodTrans."Transaction Code" = 'PNSR') THEN BEGIN
                            PensionRelief := PeriodTrans.Amount;
                        END;


                        //GrpOrder 7, SubGrpOrder 3 = Taxable Pay
                        //IF (PeriodTrans."Group Order"=7) AND (PeriodTrans."Sub Group Order"=3) THEN
                        IF (PeriodTrans."Transaction Code" = 'PAYE') THEN BEGIN
                            PayeAmount := PeriodTrans.Amount;
                        END;
                        IF (PeriodTrans."Transaction Code" = 'TXEP') THEN BEGIN
                            PayeXPAmount := PeriodTrans.Amount;
                        END;
                    UNTIL PeriodTrans.NEXT = 0;

                IF PayeAmount <= 0 THEN
                    CurrReport.SKIP;
                TotTaxablePay := TotTaxablePay + TaxablePay;
                TotPayeAmount := TotPayeAmount + PayeAmount;
                TotPensionRelief := TotPensionRelief + PensionRelief;
                TotPersonalRelief := TotPersonalRelief + PersonalRelief;
                TotInsuranceRelief := TotInsuranceRelief + InsuranceRelief;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Payroll Period", '=%1', SelectedPeriod);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(periodfilter; PeriodFilter)
                {
                    Caption = 'Period Filter';
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
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
        IF objPeriod.FIND('-') THEN;
        PeriodFilter := objPeriod."Date Opened";
    end;

    trigger OnPreReport()
    begin
        //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        IF PeriodFilter = 0D THEN ERROR('You must specify the period filter');

        SelectedPeriod := PeriodFilter;
        objPeriod.RESET;
        IF objPeriod.GET(SelectedPeriod) THEN PeriodName := objPeriod."Period Name";


        IF companyinfo.GET() THEN
            companyinfo.CALCFIELDS(companyinfo.Picture);
    end;

    var
        PeriodTrans: Record "PRL-Period Transactions";
        PayeAmount: Decimal;
        TotPayeAmount: Decimal;
        TaxablePay: Decimal;
        TotTaxablePay: Decimal;
        EmployeeName: Text[150];
        PinNumber: Text[30];
        objPeriod: Record "PRL-Payroll Periods";
        objEmp: Record "HRM-Employee C";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Date;
        companyinfo: Record 79;
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        P_A_Y_E_ScheduleCaptionLbl: Label 'P.A.Y.E Schedule';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        No_CaptionLbl: Label 'No:';
        Employee_NameCaptionLbl: Label 'Employee Name';
        PIN_Number_CaptionLbl: Label 'PIN Number:';
        Paye_Amount_CaptionLbl: Label 'Paye Amount:';
        Taxable_Pay_CaptionLbl: Label 'Taxable Pay:';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked by…………………………………………………..                   Date……………………………………………';
        Totals_CaptionLbl: Label 'Totals:';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved by……………………………………………………..                Date……………………………………………';
        GrossPay: Decimal;
        PensionRelief: Decimal;
        InsuranceRelief: Decimal;
        TotPensionRelief: Decimal;
        TotInsuranceRelief: Decimal;
        PensionSelf: Decimal;
        ProvidentSelf: Decimal;
        Nssf: Decimal;
        PersonalRelief: Decimal;
        TotPersonalRelief: Decimal;
        PayeXPAmount: Decimal;
}

