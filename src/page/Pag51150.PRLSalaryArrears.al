page 51150 "PRL-Salary Arrears"
{
    PageType = List;
    SourceTable = "PRL-Salary Arrears";

    layout
    {
        area(content)
        {
            group("Basic Pay Arrears")
            {
                Caption = 'Basic Pay Arrears';
                field("Employee Code"; Rec."Employee Code")
                {
                    Enabled = true;

                    trigger OnValidate()
                    begin
                        //Get the employee name
                        strEmpName := '';
                        objEmp.Reset;
                        objEmp.SetRange(objEmp."No.", Rec."Employee Code");
                        if objEmp.Find('-') then
                            strEmpName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                    end;
                }
                field(strEmpName; strEmpName)
                {
                    Caption = 'Name';
                    Editable = false;
                    Enabled = true;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    Editable = false;
                }
                field("Period Month"; Rec."Period Month")
                {
                    Editable = false;
                }
                field("Period Year"; Rec."Period Year")
                {
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Current Basic"; Rec."Current Basic")
                {
                }
                field("Salary Arrears"; Rec."Salary Arrears")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("PAYE Arrears"; Rec."PAYE Arrears")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        strEmpCode := Rec."Employee Code";
        strTransCode := Rec."Transaction Code";
        //Get the employee name
        strEmpName := '';
        objEmp.Reset;
        objEmp.SetRange(objEmp."No.", Rec."Employee Code");
        if objEmp.Find('-') then
            strEmpName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";



        //Get the open/current period
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then
            PeriodMonth := PayPeriod."Period Month";
        PeriodYear := PayPeriod."Period Year";
        Rec."Period Month" := PeriodMonth;
        Rec."Period Year" := PeriodYear;

        //Get the Salary Arrears code
        TransCode.SetRange(TransCode."Special Transactions", 6);
        if TransCode.Find('-') then
            strTransCode := TransCode."Transaction Code";
        Rec."Transaction Code" := strTransCode;

        //Get the staff current salary
        if SalCard.Get(Rec."Employee Code") then begin
            Rec."Current Basic" := SalCard."Basic Pay";
        end;
    end;

    var
        objOcx: Codeunit prPayrollProcessing;
        SalCard: Record "PRL-Salary Card";
        PayPeriod: Record "PRL-Payroll Periods";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        TransCode: Record "PRL-Transaction Codes";
        strTransCode: Text[30];
        strEmpCode: Text[30];
        SalArr: Record "PRL-Salary Arrears";
        strEmpName: Text[50];
        objEmp: Record "HRM-Employee C";
}

