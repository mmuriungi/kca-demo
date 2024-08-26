report 50118 "PRL-Payslips V 1.1.1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PRL-Payslips V 1.1.1.rdl';

    dataset
    {
        dataitem("HRM-Employee C"; "HRM-Employee C")
        {
            PrintOnlyIfDetail = true;

            RequestFilterFields = "No.";
            column(CompName; compInfo.Name)
            {
            }
            column(CompPic; compInfo.Picture)
            {
            }
            column(Address; compInfo.Address)
            {
            }
            column(City; compInfo.City)
            {
            }
            column(Website; compInfo."Home Page")
            {
            }
            column(EmpNo; "HRM-Employee C"."No.")
            {
            }
            column(Names; "HRM-Employee C"."Last Name" + ' ' + "HRM-Employee C"."Middle Name" + ' ' + "HRM-Employee C"."First Name")
            {
            }
            column(DOJ; "HRM-Employee C"."Date Of Join")
            {
            }
            column(UserId; "Userid")
            {
            }
            column(IDnNHIF; strID + strNhifNo)
            {
            }
            column(PinNo; "HRM-Employee C"."PIN Number")
            {
            }
            column(Retirement_date; "Retirement date")
            {

            }
            column(PerName; PerName)
            {
            }
            column(PeriodFilter; Periods)
            {
            }
            column(LegnthOfService; LegnthOfService)
            {
            }
            column(PayslipMessage; PRLPayrollPeriods."Payslip Message")
            {
            }
            column(ClosureSectionRemark; ' ')
            {
            }
            column(BankName; PRLBankStructure."Bank Name")
            {
            }
            column(BankBranch; PRLBankStructure."Branch Name")
            {

            }
            column(NSSF; "HRM-Employee C"."NSSF No.")
            {

            }
            column(NHIF; "HRM-Employee C"."NHIF No.")
            {

            }
            column(AccNo; "HRM-Employee C"."Bank Account Number")
            {
            }
            dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                RequestFilterFields = "Payroll Period";

                column(GroupText; "PRL-Period Transactions"."Group Text")
                {
                }
                column(DeptAndLeaveBal; dept)
                {
                }
                column(TransCode; "PRL-Period Transactions"."Transaction Code")
                {
                }
                column(GText; "PRL-Period Transactions"."Group Text")
                {
                }
                column(TransName; "PRL-Period Transactions"."Transaction Name")
                {
                }
                column(TransAmount; "PRL-Period Transactions".Amount)
                {
                }
                column(TransBalance; "PRL-Period Transactions".Balance)
                {
                }
                column(PeriodName; PeriodName)
                {
                }
                column(GO; "PRL-Period Transactions"."Group Order")
                {
                }
                column(strBank; 'Paid to: ' + strBank)
                {
                }
                column(strBranch; 'Branch: ' + strBranch)
                {
                }
                column(strAccountNo; 'A/C No.: ' + strAccountNo)
                {
                }
                column(EmpPin; strPin)
                {
                }
                column(strNssfNo; strNssfNo)
                {
                }

                //     trigger OnAfterGetRecord()
                //     begin
                //         //"PRL-Period Transactions".SETCURRENTKEY("PRL-Period Transactions"."Group Order");
                //         if "PRL-Period Transactions"."Group Text" = 'GROSS PAY' then CurrReport.Skip;
                //         if "PRL-Period Transactions"."Group Text" = 'STATUTORIES' then "PRL-Period Transactions"."Group Text" := 'DEDUCTIONS';
                //     end;

                //     trigger OnPreDataItem()
                //     begin

                //         "PRL-Period Transactions".SetFilter("PRL-Period Transactions"."Payroll Period", '=%1', PRLPayrollPeriods."Date Opened");
                //         //"PRL-Period Transactions".SETCURRENTKEY("PRL-Period Transactions"."Group Order");
                //     end;
            }

            // trigger OnAfterGetRecord()
            // begin
            //     Clear(LegnthOfService);
            //     if "HRM-Employee C"."Date Of Join" <> 0D then
            //         LegnthOfService := HRDates.DetermineAge_Years("HRM-Employee C"."Date Of Join", Periods);

            //     PRLBankStructure.Reset;
            //     PRLBankStructure.SetRange(PRLBankStructure."Bank Code", "HRM-Employee C"."Main Bank", PRLBankStructure."Branch Name");
            //     if PRLBankStructure.Find('-') then begin
            //     end;

            //     if "HRM-Employee C"."Bank Account Number" = '' then "HRM-Employee C"."Bank Account Number" := 'No Banking Data';
            //      strBankno := objEmp."Main Bank";
            //         strBranchno := objEmp."Branch Bank";
            //         bankStruct.SetRange(bankStruct."Bank Code", strBankno);
            //         bankStruct.SetRange(bankStruct."Branch Code", strBranchno);
            //         if bankStruct.Find('-') then begin
            //             strAccountNo := objEmp."Bank Account Number";
            //             strBank := bankStruct."Bank Name";
            //             strBranch := bankStruct."Branch Name";
            //         end;
            // end;
            trigger OnAfterGetRecord()
            begin
                emp1.Reset;
                emp1.SetRange("No.", "PRL-Period Transactions"."Employee Code");
                if emp1.Find('-') then;

                strNssfNo := '. ';
                strNhifNo := '. ';
                strBank := '. ';
                strBranch := '. ';
                strAccountNo := '. ';
                strPin := '. ';
                strAge := '.';
                Clear(strID);
                Clear(strJobG);
                Clear(strReg);
                Clear(strPF);

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "No.");
                if objEmp.Find('-') then begin
                    if objEmp."Department Code" <> '' then begin
                        Dimm.Reset;
                        Dimm.SetRange(Dimm."Dimension Code", 'DEPARTMENT');
                        Dimm.SetRange(Dimm.Code, objEmp."Department Code");
                        if Dimm.Find('-') then begin
                            if Dimm.Name <> '' then
                                dept := 'Dept.:   ' + Dimm.Name;
                        end;
                    end;
                    objEmp.CalcFields(objEmp."Department NameS");
                    //dept:=objEmp."Department NameS";
                    strEmpName := objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                    strPF := objEmp."No.";
                    strReg := objEmp.Region;
                    strJobG := objEmp."Grade Level";
                    if objEmp."ID Number" <> '' then
                        strID := 'ID: ' + objEmp."ID Number";
                    if objEmp."PAYE Number" <> '' then
                        strPin := objEmp."PAYE Number";
                    if objEmp."Date Of Join" <> 0D then
                        dtDOE := objEmp."Date Of Join";
                    //STATUS := Format(objEmp.Status);
                    "Served Notice Period" := objEmp."Served Notice Period";
                    if objEmp."Date Of Leaving" = 0D then
                        dtOfLeaving := DMY2Date(31, 12, 9999)
                    else
                        dtOfLeaving := objEmp."Date Of Leaving";
                    if objEmp."NSSF No." <> '' then
                        strNssfNo := 'N.S.S.F: ' + objEmp."NSSF No.";
                    if objEmp."NHIF No." <> '' then
                        strNhifNo := '  N.H.I.F: ' + objEmp."NHIF No.";
                    if objEmp."PIN Number" <> '' then
                        strPin := 'PIN: ' + objEmp."PIN Number";
                    if ((objEmp."Date Of Birth" <> 0D) and (objPeriod."Date Opened" <> 0D)) then
                        strAge := HrDate.DetermineAge_Years(objEmp."Date Of Birth", objPeriod."Date Opened");


                    //Get the staff banks in the payslip - Dennis ***************************************************
                    strBankno := objEmp."Main Bank";
                    strBranchno := objEmp."Branch Bank";
                    bankStruct.SetRange(bankStruct."Bank Code", strBankno);
                    bankStruct.SetRange(bankStruct."Branch Code", strBranchno);
                    if bankStruct.Find('-') then begin
                        strAccountNo := objEmp."Bank Account Number";
                        strBank := bankStruct."Bank Name";
                        strBranch := bankStruct."Branch Name";
                    end;
                    //*************************************************************************************************

                end;


                HRMEmployeeC.Reset;
                HRMEmployeeC.SetRange("No.", "PRL-Period Transactions"."Employee Code");
                if HRMEmployeeC.Find('-') then begin
                    HRMEmployeeC.CalcFields("Leave Balance");
                end;
            end;

            trigger OnPreDataItem()
            begin
                if "PRL-Period Transactions".GetFilter("PRL-Period Transactions"."Payroll Period") = '' then Error('You must specify the period filter');
                Clear(PeriodFilter);
                if Evaluate(PeriodFilter, ("PRL-Period Transactions".GetFilter("PRL-Period Transactions"."Payroll Period"))) then;
                objPeriod.Reset;
                objPeriod.SetRange(objPeriod."Date Opened", PeriodFilter);
                if objPeriod.Find('-') then;
                SelectedPeriod := PeriodFilter;
                objPeriod.Reset;
                if objPeriod.Get(PeriodFilter) then PeriodName := objPeriod."Period Name";
                Clear(PayslipMessage);
                PayslipMessage := objPeriod."Payslip Message";
                strNssfNo := '.';
                strNhifNo := '.';
                strBank := '.';
                strBranch := '.';
                strAccountNo := '.';
            end;
        }
    }

    requestpage
    {

        layout
        {
            // area(content)
            // {
            //     field(PerNamePeriods; Periods)
            //     {
            //         ApplicationArea = all;
            //         Caption = 'Payroll Period';

            //         TableRelation = "PRL-Payroll Periods"."Date Opened";


            //     }
            // }
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
        compInfo.reset();
        if compInfo.Find('-') then begin
        end;

        PRLPayrollPeriods.Reset;
        PRLPayrollPeriods.SetRange(Closed, false);
        PRLPayrollPeriods.SetFilter("Payroll Code", 'PAYROLL');
        if PRLPayrollPeriods.Find('-') then Periods := PRLPayrollPeriods."Date Opened";
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
        if Periods = 0D then Error('Specify the date filter!');
        PRLPayrollPeriods.Reset;
        PRLPayrollPeriods.SetRange("Date Opened", Periods);
        if PRLPayrollPeriods.Find('-') then begin
            PerName := PRLPayrollPeriods."Period Name";
        end;
    end;

    var
        strAge: Text[100];
        emp1: Record "HRM-Employee C";
        HRDates: Codeunit "HR Dates";
        PerName: Code[50];
        PRLPayrollPeriods: Record "PRL-Payroll Periods";
        Periods: Date;
        LegnthOfService: Code[50];
        compInfo: Record "Company Information";
        PRLBankStructure: Record "PRL-Bank Structure";
        dept: Text[100];
        strID: Text[100];
        strNhifNo: Text[30];
        PeriodName: Text[30];
        strBank: Text[100];
        strBranch: Text[100];
        strAccountNo: Text[100];
        strPin: Text[30];
        strNssfNo: Text[30];


        PeriodFilter: Date;
        compn: Code[150];
        groupFilter: Code[20];

        Addr: array[2, 12] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        intInfo: Integer;
        i: Integer;
        PeriodTrans: Record "PRL-Period Transactions";
        intRow: Integer;
        Index: Integer;
        objEmp: Record "HRM-Employee C";
        strEmpName: Text[250];

        Trans: array[2, 80] of Text[250];
        TransAmt: array[2, 80] of Text[250];
        TransBal: array[2, 80] of Text[250];
        strGrpText: Text[100];

        strMessage: Text[100];

        strPF: Text[100];
        strJobG: Text[100];
        strReg: Text[100];

        SelectedPeriod: Date;
        objPeriod: Record "PRL-Payroll Periods";
        dtDOE: Date;
        strEmpCode: Text[30];
        STATUS: Text[30];
        ControlInfo: Record "HRM-Control-Information";
        dtOfLeaving: Date;
        "Served Notice Period": Boolean;

        bankStruct: Record "PRL-Bank Structure";
        emploadva: Record "PRL-Period Transactions";
        strBankno: Text[30];
        strBranchno: Text[30];
        CompanyInfo: Record "Company Information";
        objOcx: Codeunit prPayrollProcessing;
        Dimm: Record "Dimension Value";
        HrDate: Codeunit "HR Dates";
        PayslipMessage: Text[100];
        HRMEmployeeC: Record "HRM-Employee C";
}


