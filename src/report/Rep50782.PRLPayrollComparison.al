report 50782 "PRL Payroll Comparison"
{
   DefaultLayout = RDLC;
    RDLCLayout = './Layout/PR Payroll Summary - Variance Copy.rdl';

    dataset
    {
        dataitem("PRL-Transaction Codes"; "PRL-Transaction Codes")
        {
            column(TransactionCode_PRTransactionCodes; "PRL-Transaction Codes"."Transaction Code")
            {
            }
            column(TransactionName_PRTransactionCodes; "PRL-Transaction Codes"."Transaction Name")
            {
            }
            column(TransactionType_PRTransactionCodes; "PRL-Transaction Codes"."Transaction Type")
            {
            }
            column(Amount; Amount)
            {
            }
            column(PeriodFilter; PeriodFilter)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoCity; CompInfo.City)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoEMail; CompInfo."E-Mail")
            {
            }
            column(CompInfoHomePage; CompInfo."Home Page")
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrNoNhif; CurrNoNhif)
            {

            }
            column(PrevNoNhif; PrevNoNhif)
            {

            }
            column(NhifNoVariance; CurrNoNhif - PrevNoNhif)
            {

            }
            column(CurrNHIF; CurrNHIF)
            {

            }

            column(PrevNHIF; PrevNHIF)
            {

            }
            column(NhifVariance; CurrNHIF - PrevNHIF)
            {

            }
            column(CurrNoNSSF; CurrNoNSSF)
            {

            }
            column(CurrNoNSSFVariance; CurrNoNSSF - PrevNoNSSF)
            {

            }
            column(CurrNoNSSFVariance1; CurrNoNSSF1 - PrevNoNSSF1)
            {

            }
            column(CurrNoNSSFVariance2; CurrNoNSSF2 - PrevNoNSSF2)
            {

            }
            column(CurrNSSFVariance; CurrNSSF - PrevNssf)
            {

            }
            column(CurrNSSFVariance1; CurrNSSF1 - PrevNSSF1)
            {

            }
            column(CurrNSSFVariance2; CurrNSSF2 - PrevNSSF2)
            {

            }
            column(CurrNSSF; CurrNSSF)
            {

            }
            column(CurrNoNSSF1; CurrNoNSSF1)
            {

            }
            column(CurrNSSF1; CurrNSSF1)
            {

            }
            column(CurrNoNSSF2; CurrNoNSSF2)
            {

            }
            column(CurrNSSF2; CurrNSSF2)
            {

            }
            column(PrevNoNssf; PrevNoNssf)
            {

            }
            column(PrevNssf; PrevNssf)
            {

            }
            column(PrevNoNssf1; PrevNoNssf1)
            {

            }
            column(PrevNssf1; PrevNssf1)
            {

            }
            column(PrevNoNssf2; PrevNoNssf2)
            {

            }
            column(PrevNssf2; PrevNssf2)
            {

            }
            column(AppliedFilters; AppliedFilters)
            {
            }
            column(Variant_PeriodFilter; Variant_PeriodFilter)
            {
            }
            column(Variant_PeriodAmount; Variant_PeriodAmount)
            {
            }
            column(Variance_Amount; Variance_Amount)
            {
            }
            column(Cur_No_Assigned; Cur_No_Assigned)
            {
            }
            column(Var_No_Assigned; Var_No_Assigned)
            {
            }
            column(VarC_No_Assigned; VarC_No_Assigned)
            {
            }
            column(Cur_PNAME; Cur_PNAME)
            {
            }
            column(Var_PNAME; Var_PNAME)
            {
            }
            column(Num_I; Num_I)
            {
            }
            column(Num_D; Num_D)
            {
            }

            column(Variance_AmountPercentage; Variance_AmountPercentage)
            {
            }
            column(Cur_No_Assignedpension; Cur_No_Assignedpension)
            {

            }
            column(Prev_No_Assignedpension; Prev_No_Assignedpension)
            {

            }
            column(PensioNoVariance; Cur_No_Assignedpension - Prev_No_Assignedpension)
            {

            }
            column(PensioAmtVariance; pensionemmployercur - pensionemmployerprev)
            {

            }
            column(pensionemmployercur; pensionemmployercur)
            {

            }
            column(pensionemmployerprev; pensionemmployerprev)
            {

            }
            column(Pensionemployerlabel; 'PENSION(EMPLOYER)')
            {

            }
            column(NSSFemployerlabel; 'NSSF(EMPLOYER)')
            {

            }
            column(Cur_No_AssignedNsff; Cur_No_AssignedNsff)
            {

            }
            column(CurNoAssignedNsffVariance; Cur_No_AssignedNsff - Prev_No_AssignedNSSF)
            {

            }
            column(CurNoAssignedNsffVariance1; Cur_No_AssignedNsff1 - Prev_No_AssignedNSSF1)
            {

            }
            column(CurNoAssignedNsffVariance2; Cur_No_AssignedNsff2 - Prev_No_AssignedNSSF2)
            {

            }
            column(Cur_No_AssignedNsff1; Cur_No_AssignedNsff1)
            {

            }
            column(Cur_No_AssignedNsff2; Cur_No_AssignedNsff2)
            {

            }
            column(Prev_No_AssignedNSSF; Prev_No_AssignedNSSF)
            {

            }
            column(Prev_No_AssignedNSSF1; Prev_No_AssignedNSSF1)
            {

            }
            column(Prev_No_AssignedNSSF2; Prev_No_AssignedNSSF2)
            {

            }
            column(NSSFemmployercur; NSSFemmployercur)
            {

            }
            column(NSSFemmployercurVariance; NSSFemmployercur - NSSFemmployerprev)
            {

            }
            column(NSSFemmployercurVariance1; NSSFemmployercur1 - NSSFemmployerprev1)
            {

            }
            column(NSSFemmployercurVariance2; NSSFemmployercur2 - NSSFemmployerprev2)
            {

            }
            column(NSSFemmployercur1; NSSFemmployercur1)
            {

            }
            column(NSSFemmployercur2; NSSFemmployercur2)
            {

            }
            column(NSSFemmployerprev; NSSFemmployerprev)
            {

            }
            column(NSSFemmployerprev1; NSSFemmployerprev1)
            {

            }
            column(NSSFemmployerprev2; NSSFemmployerprev2)
            {

            }
            column(CurrNoPAYE; CurrNoPAYE)
            {

            }
            column(PrevNoPAYE; PrevNoPAYE)
            {

            }
            column(TotalAmatEmplVariance; (pensionemmployercur + NSSFemmployercur + NSSFemmployercur1 + NSSFemmployercur2 + CurrGratuity2 + CurrHlevy2) - (pensionemmployerPrev + NSSFemmployerprev + NSSFemmployerPrev1 + NSSFemmployerPrev2 + PrevGratuity2 + PrevHlevy2))//NSSFemmployercurVariance + NSSFemmployercurVariance1 + NSSFemmployercurVariance2 + PensioAmtVariance)
            {

            }
            column(TotalSatVarianceAmt; (CurrPAYE + CurrNHIF + CurrNSSF + CurrNSSF1 + CurrNSSF2) - (PrevPAYE + PrevNHIF + PrevNssf + PrevNssf1 + PrevNssf2))
            {

            }
            column(TotalCurrEmployerAmt; pensionemmployercur + NSSFemmployercur + NSSFemmployercur1 + NSSFemmployercur2 + CurrGratuity + CurrHlevy)
            {

            }
            column(TotalPrevEmployerAmt; pensionemmployerPrev + NSSFemmployerprev + NSSFemmployerPrev1 + NSSFemmployerPrev2 + PrevGratuity + PrevHlevy)
            {

            }
            column(TotalStatuCurr; CurrPAYE + CurrNHIF + CurrNSSF + CurrNSSF1 + CurrNSSF2)
            {

            }
            column(TotalStatuPrev; PrevPAYE + PrevNHIF + PrevNssf + PrevNssf1 + PrevNssf2)
            {

            }
            column(PAYENoVariance; CurrNoPAYE - PrevNoPAYE)
            {

            }
            column(PAYEAmtVariance; CurrPAYE - PrevPAYE)
            {

            }
            column(CurrPAYE; CurrPAYE)
            {

            }
            column(PrevPAYE; PrevPAYE)
            {

            }
            column(CurrBasicNoSalary; CurrBasicNoSalary)
            {

            }
            column(CurrBasicSalary; CurrBasicSalary)
            {

            }
            column(PrevBasicNoSalary; PrevBasicNoSalary)
            {

            }
            column(PrevBasicSalary; PrevBasicSalary)
            {

            }
            column(BasicSalNoVariance; CurrBasicNoSalary - PrevBasicNoSalary)
            {

            }
            column(BasicSalAmtVariance; CurrBasicSalary - PrevBasicSalary)
            {

            }

            column(CurrNpayNo; CurrNpayNo)
            {

            }
            column(CurrNpay; CurrNpay)
            {

            }
            column(PrevNpayNo; PrevNpayNo)
            {

            }
            column(PrevNpay; PrevNpay)
            {

            }
            column(CurrHlevyNo; CurrHlevyNo)
            {

            }
            column(CurrHlevy; CurrHlevy)
            {

            }
            column(PrevHlevyNo; PrevHlevyNo)
            {

            }
            column(PrevHlevy; PrevHlevy)
            {

            }
            column(CurrGratuityNo; CurrGratuityNo)
            {

            }
            column(CurrGratuity; CurrGratuity)
            {

            }
            column(PrevGratuityNo; PrevGratuityNo)
            {

            }

            column(CurrGratuity2; CurrGratuity - PrevGratuity)
            {

            }
            column(CurrHlevy2; CurrHlevy - PrevHlevy)
            {

            }
            column(CurrNoGratuity1; CurrGratuityNo - PrevGratuityNo)

            {

            }
            column(CurrHlevyNo1; CurrHlevyNo - PrevHlevyNo)
            {

            }

            column(PrevGratuity; PrevGratuity)
            {

            }
            column(NpayNoVariance; CurrNpayNo - PrevNpayNo)
            {

            }
            column(NpayAmtvariance; CurrNpay - PrevNpay)
            {

            }
            column(Currgrosspay; Currgrosspay)
            {

            }
            column(PrevGrosspay; PrevGrosspay)
            {

            }
            column(TotalCurrcodeAmount; TotalCurrcodeAmount)
            {

            }
            column(TotalPrevcodeAmount; TotalPrevcodeAmount)
            {

            }
            column(TotalEmployeeAmount; TotalEmployeeAmount)
            {

            }

            trigger OnAfterGetRecord()
            begin

                Transcodes.Reset();
                //  Transcodes.SetRange("Transaction Code", PRPeriodTrans."Transaction Code");
                if Transcodes.get() then begin
                    PRPeriodTrans.Reset();
                    PRPeriodTrans.SetRange("Transaction Code", Transcodes."Transaction Code");
                    // PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                    PRPeriodTrans.SetRange("Payroll Period", PeriodFilter);
                    if PRPeriodTrans.Find('-') then begin
                        PRPeriodTrans.CalcSums(Amount);
                        TotalCurrcodeAmount := PRPeriodTrans.Amount;
                    end;
                end;
                PRPeriodTrans.Reset();
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange("Payroll Period", Variant_PeriodFilter);
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(Amount);
                    TotalPrevcodeAmount := PRPeriodTrans.Amount;
                end;
                // Currgrosspay:=CalcSums()

                //Initialize {

                Amount := 0;
                Variant_PeriodAmount := 0;
                // TotalEmployeeAmount := 0;
                Variance_Amount := 0;
                Variance_AmountPercentage := 0;

                CurPeriod_Zero := false;
                VarPeriod_Zero := false;
                NSSFemmployercur := 0;
                NSSFemmployercur1 := 0;
                NSSFemmployerprev := 0;
                NSSFemmployerprev1 := 0;
                PrevNHIF := 0;
                CurrNHIF := 0;
                CurrNSSF := 0;
                CurrNSSF1 := 0;
                CurrNSSF2 := 0;
                PrevNssf := 0;
                PrevNssf1 := 0;
                PrevNssf2 := 0;
                NSSFemmployercur2 := 0;
                NSSFemmployerprev2 := 0;
                pensionemmployercur := 0;
                pensionemmployerprev := 0;
                CurrPAYE := 0;
                PrevPAYE := 0;
                CurrBasicSalary := 0;

                BasicSalNoVariance := 0;
                PrevBasicSalary := 0;
                CurrNpay := 0;
                PrevNpay := 0;

                CurrNpay := 0;
                PrevNpay := 0;

                NpayAmtvariance := 0;
                NpayNoVariance := 0;
                CurrBasicNoSalary := 0;
                PrevBasicNoSalary := 0;
                Cur_No_Assigned := 0;
                Cur_No_AssignedNsff := 0;
                Cur_No_Assignedpension := 0;
                Var_No_Assigned := 0;
                VarC_No_Assigned := 0;
                NSSFemmployercur2 := 0;
                NSSFemmployerprev2 := 0;
                //Selected Period
                fn_SR_PeriodTrans;
                if PRPeriodTrans.Find('-') then begin
                    Cur_No_Assigned := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    Amount := PRPeriodTrans.Amount;
                end;

                //Variant Period
                fn_SR_Variant_PeriodTrans;
                if PRPeriodTrans.Find('-') then begin
                    Var_No_Assigned := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    Variant_PeriodAmount := PRPeriodTrans.Amount;
                end;

                //Variance
                Variance_Amount := Amount - Variant_PeriodAmount;
                VarC_No_Assigned := Cur_No_Assigned - Var_No_Assigned;

                //Output Bool
                if Amount = 0 then CurPeriod_Zero := true;
                if Variant_PeriodAmount = 0 then VarPeriod_Zero := true;
                if VarPeriod_Zero and CurPeriod_Zero then CurrReport.Skip;


                //Variance Percentage
                if Variant_PeriodAmount <> 0 then Variance_AmountPercentage := (Variance_Amount / Variant_PeriodAmount) * 100;

                //Counter
                if "PRL-Transaction Codes"."Transaction Type" = "PRL-Transaction Codes"."Transaction Type"::Income then begin
                    Num_I += 1;
                    PRPeriodTrans.Reset;
                    PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                    PRPeriodTrans.SetRange(PRPeriodTrans."transaction Code", "PRL-Transaction Codes"."Transaction Code");
                    PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
                    IF PRPeriodTrans.Find('-') then begin
                        PRPeriodTrans.CalcSums(Amount);
                        TotalEmployeeAmount := PRPeriodTrans.Amount;
                    end;
                end;
                if "PRL-Transaction Codes"."Transaction Type" = "PRL-Transaction Codes"."Transaction Type"::Deduction then Num_D += 1;
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'BPAY');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    CurrBasicNoSalary := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    CurrBasicSalary := PRPeriodTrans.Amount;
                end;

                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'BPAY');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", Variant_PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    PrevBasicNoSalary := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    PrevBasicSalary := PRPeriodTrans.Amount;
                end;

                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NPAY');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    CurrNpayNo := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    CurrNpay := PRPeriodTrans.Amount;
                    if CurrNpay < 0 then CurrReport.Skip();
                end;
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'D-100');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", Variant_PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    PrevHlevyNo := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    PrevHlevy := PRPeriodTrans.Amount;
                end;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'D-100');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    CurrHlevyNo := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    CurrHlevy := PRPeriodTrans.Amount;
                    if CurrHlevy < 0 then CurrReport.Skip();
                end;
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'GRATUITY');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", Variant_PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    PrevGratuityNo := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    PrevGratuity := PRPeriodTrans.Amount;
                end;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'GRATUITY');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    CurrGratuityNo := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    CurrGratuity := PRPeriodTrans.Amount;
                    if CurrGratuity < 0 then CurrReport.Skip();
                end;
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NPAY');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", Variant_PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    PrevNpayNo := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    PrevNpay := PRPeriodTrans.Amount;
                end;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'PAYE');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    CurrNoPAYE := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    CurrPAYE := PRPeriodTrans.Amount;
                end;
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'PAYE');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", Variant_PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    PrevNoPAYE := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    PrevPAYE := PRPeriodTrans.Amount;
                end;
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NHIF');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    CurrNoNHIF := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    CurrNHIF := PRPeriodTrans.Amount;
                end;
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NHIF');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", Variant_PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    PrevNoNhif := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    PrevNHIF := PRPeriodTrans.Amount;
                end;
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NSSF');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    CurrNoNSSF := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    CurrNSSF := PRPeriodTrans.Amount;
                end;
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NSSF');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", Variant_PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    PrevNoNssf := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    PrevNssf := PRPeriodTrans.Amount;
                end;
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NSSFI');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    CurrNoNSSF1 := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    CurrNSSF1 := PRPeriodTrans.Amount;
                end;
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NSSFI');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", Variant_PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    PrevNoNSSF1 := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    PrevNssf1 := PRPeriodTrans.Amount;
                end;
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NSSFII');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    CurrNoNSSF2 := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    CurrNSSF2 := PRPeriodTrans.Amount;
                end;

                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NSSFII');
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", Variant_PeriodFilter);
                IF PRPeriodTrans.Find('-') then begin
                    PrevNoNssf2 := PRPeriodTrans.Count;
                    PRPeriodTrans.CalcSums(Amount);
                    PrevNssf2 := PRPeriodTrans.Amount;
                end;


                Employerdeductions.Reset();
                Employerdeductions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
                Employerdeductions.SetRange("Transaction Code", 'D-123');
                Employerdeductions.SetRange("Payroll Period", PeriodFilter);
                if Employerdeductions.Find('-') then begin
                    Cur_No_Assignedpension := Employerdeductions.Count;
                    Employerdeductions.CalcSums(Amount);
                    pensionemmployercur := Employerdeductions.Amount * 2;
                end;
                Employerdeductions.Reset();
                Employerdeductions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
                Employerdeductions.SetRange("Transaction Code", 'D-123');
                Employerdeductions.SetRange("Payroll Period", Variant_PeriodFilter);
                if Employerdeductions.Find('-') then begin
                    Prev_No_Assignedpension := Employerdeductions.Count;
                    Employerdeductions.CalcSums(Amount);
                    pensionemmployerprev := Employerdeductions.Amount * 2;
                end;

                Employerdeductions.Reset();
                Employerdeductions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
                Employerdeductions.SetRange("Transaction Code", 'NSSF');
                Employerdeductions.SetRange("Payroll Period", PeriodFilter);
                if Employerdeductions.Find('-') then begin
                    Cur_No_AssignedNsff := Employerdeductions.Count;
                    Employerdeductions.CalcSums(Amount);
                    NSSFemmployercur := Employerdeductions.Amount;
                end;
                Employerdeductions.Reset();
                Employerdeductions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
                Employerdeductions.SetRange("Transaction Code", 'NSSF');
                Employerdeductions.SetRange("Payroll Period", Variant_PeriodFilter);
                if Employerdeductions.Find('-') then begin
                    Prev_No_AssignedNSSF := Employerdeductions.Count;
                    Employerdeductions.CalcSums(Amount);
                    NSSFemmployerprev := Employerdeductions.Amount;
                end;
                Employerdeductions.Reset();
                Employerdeductions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
                Employerdeductions.SetRange("Transaction Code", 'NSSFI');
                Employerdeductions.SetRange("Payroll Period", PeriodFilter);
                if Employerdeductions.Find('-') then begin
                    Cur_No_AssignedNsff1 := Employerdeductions.Count;
                    Employerdeductions.CalcSums(Amount);
                    NSSFemmployercur1 := Employerdeductions.Amount;
                end;
                Employerdeductions.Reset();
                Employerdeductions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
                Employerdeductions.SetRange("Transaction Code", 'NSSFII');
                Employerdeductions.SetRange("Payroll Period", PeriodFilter);
                if Employerdeductions.Find('-') then begin
                    Cur_No_AssignedNsff2 := Employerdeductions.Count;
                    Employerdeductions.CalcSums(Amount);
                    NSSFemmployercur2 := Employerdeductions.Amount;
                end;
                Employerdeductions.Reset();
                Employerdeductions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
                Employerdeductions.SetRange("Transaction Code", 'NSSFI');
                Employerdeductions.SetRange("Payroll Period", Variant_PeriodFilter);
                if Employerdeductions.Find('-') then begin
                    Prev_No_AssignedNSSF1 := Employerdeductions.Count;
                    Employerdeductions.CalcSums(Amount);
                    NSSFemmployerprev1 := Employerdeductions.Amount;
                end;
                Employerdeductions.Reset();
                Employerdeductions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
                Employerdeductions.SetRange("Transaction Code", 'NSSFII');
                Employerdeductions.SetRange("Payroll Period", Variant_PeriodFilter);
                if Employerdeductions.Find('-') then begin
                    Prev_No_AssignedNSSF2 := Employerdeductions.Count;
                    Employerdeductions.CalcSums(Amount);
                    NSSFemmployerprev2 := Employerdeductions.Amount;
                end;

            end;

            trigger OnPreDataItem()
            begin
                //Skip this trans code
                SetFilter("PRL-Transaction Codes"."Transaction Code", '<>%1', 'E31');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PeriodFilter; PeriodFilter)
                    {
                        ApplicationArea = all;
                        Visible = true;
                        Caption = 'Current Period';
                        TableRelation = "PRL-Payroll Periods";
                    }
                    field(Variant_PeriodFilter; Variant_PeriodFilter)
                    {
                        ApplicationArea = all;
                        Visible = true;
                        Caption = ' Previous Period';
                        TableRelation = "PRL-Payroll Periods";
                    }
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
        PRLPayrollPeriods.Reset;
        PRLPayrollPeriods.SetRange(Closed, false);
        if PRLPayrollPeriods.Find('-') then begin
            PeriodFilter := PRLPayrollPeriods."Date Opened";
        end else
            Error('No Open period in the filters');

        PRLPayrollPeriodsCurr.Reset;
        PRLPayrollPeriodsCurr.SetRange("Date Opened", PeriodFilter);
        if PRLPayrollPeriodsCurr.Find('-') then begin
            CurrentMonth := PRLPayrollPeriodsCurr."Period Month";
            CurrentYear := PRLPayrollPeriodsCurr."Period Year";

            if CurrentMonth = 1 then begin
                PrevMonth := 12;
                PrevYear := CurrentYear - 1;
            end else begin
                PrevMonth := CurrentMonth - 1;
                PrevYear := CurrentYear;
            end;
        end;

        PRLPayrollPeriodsPrev.Reset;
        PRLPayrollPeriodsPrev.SetRange("Period Month", PrevMonth);
        PRLPayrollPeriodsPrev.SetRange("Period Year", PrevYear);
        if PRLPayrollPeriodsPrev.Find('-') then begin
            Variant_PeriodFilter := PRLPayrollPeriodsPrev."Date Opened";
        end;
    end;

    trigger OnPreReport()
    begin
        //HRCodeunit.fn_HRPRAccessList(USERID);

        if ((Variant_PeriodFilter = 0D) or (PeriodFilter = 0D)) then Error('Specify Periods');
        //Dann

        //Init
        Cur_PNAME := '';
        Var_PNAME := '';

        Num_I := 0;
        Num_D := 0;

        //Default Payroll Period
        if PeriodFilter = 0D then begin
            PRPayrollPeriods.Reset;
            PRPayrollPeriods.SetRange(PRPayrollPeriods.Closed, false);
            if PRPayrollPeriods.Find('-') then PeriodFilter := PRPayrollPeriods."Date Opened";
        end;

        //Variant Period Filter
        if Variant_PeriodFilter = 0D then begin
            Variant_PeriodFilter := CalcDate('-1M', PeriodFilter); //Prev Period
        end;

        //Use Period Name - Curr P
        PRPayrollPeriods.Reset;
        PRPayrollPeriods.SetRange(PRPayrollPeriods."Date Opened", PeriodFilter);
        if PRPayrollPeriods.Find('-') then Cur_PNAME := PRPayrollPeriods."Period Name";

        //Use Period Name - Var Period
        PRPayrollPeriods.Reset;
        PRPayrollPeriods.SetRange(PRPayrollPeriods."Date Opened", Variant_PeriodFilter);
        if PRPayrollPeriods.Find('-') then Var_PNAME := PRPayrollPeriods."Period Name";

        //Save Filters
        /* if DepartmentCode <> '' then txt_DirectorateFilter := 'Directorate Code: ' + DepartmentCode;

        AppliedFilters := 'APPLIED FILTER(s) =' + 'Payroll Period: ' + Format(Cur_PNAME)
                        + txt_DirectorateFilter
                        + "PRL-Transaction Codes".GetFilters; */

        //Company Info
        fnCompanyInfo;
        TotalStatuCurr := CurrPAYE + CurrNHIF + CurrNSSF + CurrNSSF1 + CurrNSSF2;


        TotalStatuPrev := PrevPAYE + PrevNHIF + PrevNssf + PrevNssf1 + PrevNssf2;


    end;

    var
        CurrNSSF: Decimal;
        PAYEAmtVariance: Decimal;
        NhifVariance: Decimal;
        TotalCurrEmployerAmt: Decimal;
        CurrBasicSalary: decimal;
        CurrBasicNoSalary: Integer;
        PrevBasicNoSalary: Integer;
        PrevBasicSalary: Decimal;
        TotalPrevEmployerAmt: decimal;
        CurrNSSFVariance: Decimal;
        CurrNSSFVariance1: Decimal;
        CurrNSSFVariance2: Decimal;
        PensioAmtVariance: Decimal;
        PrevNssf: Decimal;
        NSSFemmployercurVariance: decimal;
        NSSFemmployercurVariance1: decimal;
        NSSFemmployercurVariance2: decimal;

        CurrNSSF1: Decimal;
        PrevNssf1: Decimal;
        CurrNSSF2: Decimal;
        PrevNssf2: Decimal;
        CurrHlevy2: Decimal;
        PrevHlevy2: Decimal;
        CurrNoHlevy1: Integer;
        PrevNoHlevy1: Integer;
        CurrGratuity2: Decimal;
        PrevGratuity2: Decimal;
        CurrNoGratuity1: Integer;
        PrevNoGratuity1: Integer;

        CurrNoNSSF: Integer;
        PrevNoNSSF: Integer;
        CurrNoNSSF1: Integer;
        PrevNoNSSF1: Integer;
        CurrNoNSSF2: Integer;
        PrevNoNSSF2: Integer;
        PrevNoNhif: Integer;
        CurrNoNhif: Integer;
        PrevNHIF: Decimal;
        Currgrosspay: Decimal;
        PrevGrosspay: Decimal;
        CurrNHIF: Decimal;
        BasicSalNoVariance: decimal;
        BasicSalAmtvariance: Decimal;
        NpayNoVariance: Integer;
        NpayAmtvariance: Decimal;
        CurrNpay: decimal;
        CurrNpayNo: Integer;
        PrevNpayNo: Integer;
        PrevNpay: Decimal;
        CurrHlevy: decimal;
        CurrHlevyNo: Integer;
        PrevHlevyNo: Integer;
        PrevHlevy: Decimal;
        CurrGratuity: decimal;
        CurrGratuityNo: Integer;
        PrevGratuityNo: Integer;
        PrevGratuity: Decimal;
        Var_No_AssignedNSSF: Decimal;
        TotalEmployeeAmount: Decimal;
        TotalStatuCurr: Decimal;
        TotalStatuPrev: Decimal;
        CurrPAYE: Decimal;
        CurrNoPAYE: Integer;
        PrevNoPAYE: Integer;
        PrevPAYE: Decimal;
        Var_No_AssignedPension: decimal;
        Cur_No_AssignedNsff: Integer;
        Cur_No_AssignedNsff1: Integer;
        Prev_No_AssignedNSSF: Integer;
        Prev_No_AssignedNSSF1: Integer;
        Cur_No_AssignedNsff2: Integer;
        Prev_No_AssignedNSSF2: Integer;
        NSSFemmployercur: Decimal;
        NSSFemmployercur1: Decimal;
        NSSFemmployerprev: Decimal;
        NSSFemmployerprev1: Decimal;
        NSSFemmployercur2: Decimal;
        NSSFemmployerprev2: Decimal;

        Cur_No_Assignedpension: Integer;
        Prev_No_Assignedpension: Integer;
        pensionemmployercur: Decimal;
        pensionemmployerprev: Decimal;

        PRPeriodTrans: Record "PRL-Period Transactions";
        Employerdeductions: record "PRL-Period Transactions";
        PeriodFilter: Date;
        Amount: Decimal;
        CompInfo: Record "Company Information";
        PeriodName: Text[30];
        DepartmentCode: Code[10];
        PRPayrollPeriods: Record "PRL-Payroll Periods";
        AppliedFilters: Text;
        Variant_PeriodFilter: Date;
        Variant_PeriodAmount: Decimal;
        Variance_Amount: Decimal;
        Variance_AmountPercentage: Decimal;
        CurPeriod_Zero: Boolean;
        VarPeriod_Zero: Boolean;
        Cur_No_Assigned: Integer;
        Var_No_Assigned: Integer;
        VarC_No_Assigned: Integer;
        Num_I: Integer;
        Num_D: Integer;
        Cur_PNAME: Text;
        Var_PNAME: Text;
        txt_DirectorateFilter: Text;
        txt_VarPeriodFilter: Text;
        //HRCodeunit: Codeunit "HR CheckList";
        PRLVarianceTransCodeBuff: Record "PRL-Variance Trans. Code Buff";
        PRLVarianceTransCodeBuff2: Record "PRL-Variance Trans. Code Buff";
        PeriFilter: Date;
        PRLPayrollPeriods: Record "PRL-Payroll Periods";
        PRLPayrollPeriodsCurr: Record "PRL-Payroll Periods";
        PRLPayrollPeriodsPrev: Record "PRL-Payroll Periods";
        PRLPeriodTransactions: Record "PRL-Period Transactions";
        PRLPeriodTransactionsCurr: Record "PRL-Period Transactions";
        PRLPeriodTransactionsPrev: Record "PRL-Period Transactions";
        Transcodes: Record "PRL-Transaction Codes";
        HRMEmployeeD: Record "HRM-Employee C";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        PrevMonth: Integer;
        PrevYear: Integer;
        CurrentAmount: Integer;
        PrevAmounts: Integer;
        "Emp|No": Integer;
        EmpName: Integer;
        TotalCurrcodeAmount: Decimal;
        TotalPrevCodeAmount: Decimal;

    /// <summary>
    /// fnCompanyInfo.
    /// </summary>
    procedure fnCompanyInfo()
    begin
        CompInfo.Reset;
        if CompInfo.Get then
            CompInfo.CalcFields(CompInfo.Picture);
    end;

    local procedure fn_SR_PeriodTrans()
    begin
        PRPeriodTrans.Reset;
        PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month"
                                    , "Period Year", Membership, "Reference No");
        PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", "PRL-Transaction Codes"."Transaction Code");
        PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
        if DepartmentCode <> '' then begin
            // PRPeriodTrans.SETRANGE(PRPeriodTrans."Global Dimension 1 Code",DepartmentCode);
        end;
        Employerdeductions.Reset();
        Employerdeductions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
        Employerdeductions.SetRange("Payroll Period", PeriodFilter);
    end;

    local procedure fn_SR_Variant_PeriodTrans()
    begin
        PRPeriodTrans.Reset;
        PRPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month"
                                    , "Period Year", Membership, "Reference No");
        PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", "PRL-Transaction Codes"."Transaction Code");
        PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", Variant_PeriodFilter);
        if DepartmentCode <> '' then begin
            // PRPeriodTrans.SETRANGE(PRPeriodTrans."Global Dimension 1 Code",DepartmentCode);
        end;
        Employerdeductions.Reset();
        Employerdeductions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
        Employerdeductions.SetRange("Payroll Period", Variant_PeriodFilter);

    end;

    local procedure fn_SR_PeriodTrans2()
    begin

        Employerdeductions.Reset();
        Employerdeductions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
        Employerdeductions.SetRange("Transaction Code", Employerdeductions."Transaction Code");
        Employerdeductions.SetRange("Payroll Period", PeriodFilter);
    end;

    local procedure fn_SR_Variant_PeriodTrans2()
    begin

        Employerdeductions.Reset();
        Employerdeductions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
        Employerdeductions.SetRange("Transaction Code", Employerdeductions."Transaction Code");
        Employerdeductions.SetRange("Payroll Period", Variant_PeriodFilter);

    end;

}
