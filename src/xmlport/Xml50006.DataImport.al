xmlport 50006 "Data Import"

{
    Caption = 'Data Import';
    Direction = Both;
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF16;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            tableelement(Scard; "HRM-Employee C")
            {

                fieldelement(SalaryGrade; Scard."Salary Grade")
                {
                }
                fieldelement(SalaryNotchStep; Scard."Salary Notch/Step")
                {
                }
                fieldelement(PayrollType; Scard."Payroll Type")
                {
                }
                fieldelement(EmployeeClassification; Scard."Employee Classification")
                {
                }
                fieldelement(DepartmentName; Scard."Department Name")
                {
                }
                fieldelement(PrevNetPay; Scard."Prev. Net Pay")
                {
                }
                fieldelement(CurrNetPay; Scard."Curr. Net Pay")
                {
                }
                fieldelement(GrossNetPayVariation; Scard."Gross Net Pay Variation")
                {
                }
                fieldelement(Grade; Scard.Grade)
                {
                }
                fieldelement(PhysicalDisability; Scard."Physical Disability")
                {
                }
                fieldelement(SalaryCategory; Scard."Salary Category")
                {
                }
                fieldelement(CurrentBasic; Scard."Current Basic")
                {
                }
                fieldelement(EmployeeType; Scard."Employee Type")
                {
                }
                fieldelement(BasicSalary; Scard."Basic Salary")
                {
                }
                fieldelement(EmployeeCategory; Scard."Employee Category")
                {
                }
                fieldelement(BankName; Scard."Bank Name")
                {
                }
                fieldelement(BranchName; Scard."Branch Name")
                {
                }
            }
        }
    }
}