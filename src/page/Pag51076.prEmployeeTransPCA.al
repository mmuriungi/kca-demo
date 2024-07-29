page 51076 "prEmployee Trans PCA"
{
    PageType = ListPart;
    SourceTable = "prEmployee Trans PCA";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        objPCAheader.RESET;
                        objPCAheader.SETRANGE(objPCAheader."Change Advice Serial No.", Rec."Change Advice Serial No.");
                        IF objPCAheader.FIND('-') THEN BEGIN
                            SelectedPeriod := objPCAheader."Payroll Period";
                            Rec."Period Month" := objPCAheader."Period Month";
                            Rec."Period Year" := objPCAheader."Period Year";
                        END;

                        blnIsLoan := FALSE;
                        IF objTransCodes.GET(Rec."Transaction Code") THEN
                            Rec."Transaction Name" := objTransCodes."Transaction Name";
                        Rec."Payroll Period" := SelectedPeriod;
                        IF objTransCodes."Special Transactions" = 8 THEN blnIsLoan := TRUE;

                        IF objTransCodes."Is Formula" = TRUE THEN BEGIN
                            empCode := Rec."Employee Code";
                            // CLEAR(objOcx);
                            // curTransAmount:=objOcx.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,objTransCodes.Formula);
                            // Amount:=curTransAmount;
                        END;

                        //*************ENTER IF EMPLOYER DEDUCTION IS SET UP
                        curTransAmount := 0;

                        IF objTransCodes."Include Employer Deduction" = TRUE THEN BEGIN
                            // curTransAmount:=objOcx.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,objTransCodes."Is Formula for employer");
                            // "Employer Amount":=curTransAmount;
                        END;
                    end;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field("Employer Amount"; Rec."Employer Amount")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        objTransCodes: Record "PRL-Transaction Codes";
        SelectedPeriod: Date;
        objPeriod: Record "PRL-Payroll Periods";
        PeriodName: Text[30];
        PeriodTrans: Record "PRL-Period Transactions";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        blnIsLoan: Boolean;
        objEmpTrans: Record "PRL-Employee Transactions";
        transType: Text[30];
        //objOcx: Codeunit "70134708";
        strExtractedFrml: Text[30];
        curTransAmount: Decimal;
        empCode: Text[30];
        Employee: Record "HRM-Employee C";
        EmpTrans: Record "PRL-Period Transactions";
        //VitalSetUp: Record "70134972";
        SalaryCard: Record "PRL-Salary Card";
        TotalEarnings: Decimal;
        ArreasAmount: Decimal;
        ArrearsDays: Integer;
        NoOfMonthDays: Integer;
        i: Integer;
        RemainingDays: Integer;
        TDate: Date;
        objPCAheader: Record "prBasic pay PCA";
}

