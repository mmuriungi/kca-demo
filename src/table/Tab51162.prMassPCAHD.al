table 51162 prMassPCAHD
{
    DrillDownPageID = "prPCA list";
    ;
    LookupPageID = "prPCA list";

    fields
    {
        field(1; "Change Advice Serial No."; Code[50])
        {

            trigger OnValidate()
            begin
                IF "Change Advice Serial No." <> xRec."Change Advice Serial No." THEN BEGIN
                    HrSetup.GET;
                    NoSeriesMgt.TestManual(HrSetup."Pay-change No.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Posted;
        }
        field(3; "Period Month"; Integer)
        {
        }
        field(4; "Period Year"; Integer)
        {
        }
        field(5; "Payroll Period"; Date)
        {
            TableRelation = "PRL-Payroll Periods"."Date Opened" WHERE(Closed = CONST(false));
        }
        field(6; Comments; Text[200])
        {
        }
        field(7; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(8; Effected; Boolean)
        {
        }
        field(9; "User ID"; Code[50])
        {
        }
        field(10; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(11; PAyrollCode; Code[50])
        {
            TableRelation = "PRL-Payroll Type"."Payroll Code";
        }
        field(12; "Transaction Code"; Code[30])
        {
            TableRelation = "PRL-Transaction Codes"."Transaction Code";

            trigger OnValidate()
            begin
                IF objTransCodes.GET("Transaction Code") THEN
                    "Transaction Name" := objTransCodes."Transaction Name";
                // "Payroll Period":=SelectedPeriod;
                //  "Period Month":=PeriodMonth;
                //  "Period Year":=PeriodYear;
                //   IF objTransCodes."Special Transactions"=8 THEN blnIsLoan:=TRUE;
            end;
        }
        field(13; "Transaction Name"; Text[100])
        {
        }
        field(14; "Other Allowances"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Allowance Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Change Advice Serial No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Change Advice Serial No." = '' THEN BEGIN
            HrSetup.GET;
            HrSetup.TESTFIELD("Pay-change No.");
            NoSeriesMgt.InitSeries(HrSetup."Pay-change No.", xRec."No. Series", 0D, "Change Advice Serial No.", "No. Series");
        END;
        "User ID" := USERID;

        // "Transaction Code" := 'E0025';

        VALIDATE("Transaction Code");

        objPayrollPeriod.RESET;
        objPayrollPeriod.SETRANGE(objPayrollPeriod.Closed, FALSE);
        IF objPayrollPeriod.FIND('-') THEN BEGIN
            "Period Month" := objPayrollPeriod."Period Month";
            "Period Year" := objPayrollPeriod."Period Year";
            "Payroll Period" := objPayrollPeriod."Date Opened";
        END;
    end;

    var
        HrSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit 396;
        objEmp: Record "HRM-Employee C";
        objSalCard: Record "PRL-Salary Card";
        empTrans: Record "PRL-Period Transactions";
        empTransPCA: Record "PRL-Employee Transactions";
        objPayrollPeriod: Record "PRL-Payroll Periods";
        Usetup: Record 91;
        objTransCodes: Record "PRL-Transaction Codes";

    procedure fnCheckEmployeeStatus()
    var
        objEmp: Record "HRM-Employee C";
    begin
        objEmp.RESET;
        //objEmp.SETRANGE(objEmp."No.","Employee Code");
        objEmp.SETFILTER(objEmp.Status, '<>%1', objEmp.Status::Active);
        IF objEmp.FIND('-') THEN BEGIN
            ERROR('You cannot raise a PCA for someone who is not Active');
            // "Employee Code" := '';
            MODIFY;
        END;


    end;
}

