report 52100 "Casual-Housing Levy"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CasualHousingLevy.rdl';

    dataset
    {
        dataitem(DataItem6207; "HRM-Employee C")
        {
            DataItemTableView = WHERE("Employee Category" = FILTER('CASUAL' | 'CASUALS'));
            RequestFilterFields = "No.";
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
            column(Companyinfo_Picture; Companyinfo.Picture)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Address; Address)
            {
            }
            column(Tel; Tel)
            {
            }
            column(CompPINNo; CompPINNo)
            {
            }
            column(PeriodName_Control1102756007; PeriodName)
            {
            }
            column(HousingLevyAmount; HousingLevyAmount)
            {
            }
            column(IDNumber; IDNumber)
            {
            }
            column(KRAPin; KRAPin)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(Employee_Code; "No.")
            {
            }
            column(GrossAmt; GrossAmt)
            {
            }
            column(TotHousingLevyAmount; TotHousingLevyAmount)
            {
            }
            column(HOUSING_LEVY_FUNDCaption; HOUSING_LEVY_FUNDCaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(PERIOD_Caption_Control1102755032; PERIOD_Caption_Control1102755032Lbl)
            {
            }
            column(ADDRESS_Caption; ADDRESS_CaptionLbl)
            {
            }
            column(EMPLOYER_Caption; EMPLOYER_CaptionLbl)
            {
            }
            column(EMPLOYER_PIN_NO_Caption; EMPLOYER_PIN_NO_CaptionLbl)
            {
            }
            column(TEL_NO_Caption; TEL_NO_CaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(ID_Number_Caption; ID_Number_CaptionLbl)
            {
            }
            column(KRA_PIN_Caption; KRA_PIN_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Gross_Pay_Caption; Gross_Pay_CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Total_Housing_Levy_Caption; Total_Housing_Levy_CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(HousingLevyAmount);
                CLEAR(GrossAmt);
                objEmp.RESET;
                objEmp.SETRANGE(objEmp."No.", "No.");
                IF objEmp.FIND('-') THEN;
                EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                KRAPin := objEmp."PIN Number";
                IDNumber := objEmp."ID Number";

                // Get Housing Levy Amount (Transaction Code 996)
                PeriodTrans.RESET;
                PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SETRANGE("Current Instalment", objPeriod."Current Instalment");
                PeriodTrans.SETRANGE(PeriodTrans."Transaction Code", '996');
                PeriodTrans.SETCURRENTKEY(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                HousingLevyAmount := 0;

                IF PeriodTrans.FIND('-') THEN BEGIN
                    IF PeriodTrans.Amount = 0 THEN CurrReport.SKIP;
                    HousingLevyAmount := PeriodTrans.Amount;
                    TotHousingLevyAmount := TotHousingLevyAmount + PeriodTrans.Amount;
                END;

                // Get Gross Pay Amount
                PeriodTrans.RESET;
                PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SETRANGE("Current Instalment", objPeriod."Current Instalment");
                PeriodTrans.SETRANGE(PeriodTrans."Transaction Code", 'GPAY');

                IF PeriodTrans.FIND('-') THEN BEGIN
                    GrossAmt := PeriodTrans.Amount;
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF CompInfoSetup.GET() THEN
                    CompPINNo := CompInfoSetup."Company P.I.N";
                Address := CompInfoSetup.Address;
                Tel := CompInfoSetup."Phone No.";
                CLEAR(TotHousingLevyAmount);
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
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        //objPeriod.SETFILTER("Payroll Code",'%1|%2','CASUAL','CASUALS');
        IF objPeriod.FIND('-') THEN BEGIN
            PeriodFilter := objPeriod."Date Openned";
            PeriodName := objPeriod."Period Name" + ' (' + FORMAT(objPeriod."Current Instalment") + FORMAT(objPeriod."Period Instalment Prefix") + 'Payment';
        END;
    end;

    trigger OnPreReport()
    begin
        //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        IF PeriodFilter = 0D THEN ERROR('You must specify the period filter');

        SelectedPeriod := PeriodFilter;


        IF Companyinfo.GET() THEN
            Companyinfo.CALCFIELDS(Companyinfo.Picture);
        CLEAR(HousingLevyAmount);
        //CLEAR(TotHousingLevyAmount);
    end;

    var
        PeriodTrans: Record "PRL-Casual Period Transactions";
        HousingLevyAmount: Decimal;
        TotHousingLevyAmount: Decimal;
        EmployeeName: Text[150];
        IDNumber: Text[30];
        KRAPin: Code[20];
        objPeriod: Record "PRL-Casual Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Date;
        objEmp: Record "HRM-Employee C";
        CompInfoSetup: Record "HRM-Control-Information";
        CompPINNo: Code[20];
        Address: Text[90];
        Tel: Text[30];
        GrossAmt: Decimal;
        Companyinfo: Record "HRM-Control-Information";
        HOUSING_LEVY_FUNDCaptionLbl: Label 'HOUSING LEVY FUND';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        PERIOD_Caption_Control1102755032Lbl: Label 'PERIOD:';
        ADDRESS_CaptionLbl: Label 'ADDRESS:';
        EMPLOYER_CaptionLbl: Label 'EMPLOYER:';
        EMPLOYER_PIN_NO_CaptionLbl: Label 'EMPLOYER PIN NO:';
        TEL_NO_CaptionLbl: Label 'TEL NO:';
        AmountCaptionLbl: Label 'Amount';
        ID_Number_CaptionLbl: Label 'ID Number:';
        KRA_PIN_CaptionLbl: Label 'KRA PIN:';
        Employee_NameCaptionLbl: Label 'Employee Name';
        No_CaptionLbl: Label 'No:';
        Gross_Pay_CaptionLbl: Label 'Gross Pay';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized by……………………………………………………..              Date……………………………………………';
        Total_Housing_Levy_CaptionLbl: Label 'Total Housing Levy:';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved by……………………………………………………..                Date……………………………………………';
}