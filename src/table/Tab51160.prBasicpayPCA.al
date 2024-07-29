table 51160 "prBasic pay PCA"
{
    DrillDownPageID = "prPCA list";
    LookupPageID = "prPCA list";

    fields
    {
        field(1; "Employee Code"; Code[50])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                objEmp.RESET;
                objEmp.SETRANGE(objEmp."No.", "Employee Code");
                IF objEmp.FIND('-') THEN BEGIN
                    "Employee Name" := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                    IF objEmp.Status <> objEmp.Status::Active THEN ERROR('This employee is not an ACTIVE employee contact HR');


                    objSalCard.RESET;
                    objSalCard.SETRANGE(objSalCard."Employee Code", objEmp."No.");
                    IF objSalCard.FIND('-') THEN BEGIN
                        "Basic Pay" := objSalCard."Basic Pay";
                        "Pays NSSF" := objSalCard."Pays NSSF";
                        "Pays NHIF" := objSalCard."Pays NHIF";
                        "Pays PAYE" := objSalCard."Pays PAYE";



                        //----Insert from employee transactions----------------------------------------------
                        objPayrollPeriod.RESET;
                        objPayrollPeriod.SETRANGE(objPayrollPeriod.Closed, FALSE);
                        IF objPayrollPeriod.FIND('-') THEN BEGIN
                            empTransPCA.RESET;
                            empTransPCA.SETRANGE(empTransPCA."Change Advice Serial No.", "Change Advice Serial No.");
                            IF empTransPCA.FIND('-') THEN empTransPCA.DELETEALL;

                            empTrans.RESET;
                            empTrans.SETRANGE(empTrans."Employee Code", objEmp."No.");
                            empTrans.SETRANGE(empTrans."Payroll Period", objPayrollPeriod."Date Opened");
                            IF empTrans.FIND('-') THEN
                                REPEAT
                                    empTransPCA.INIT;
                                    empTransPCA."Change Advice Serial No." := "Change Advice Serial No.";
                                    empTransPCA."Employee Code" := empTrans."Employee Code";
                                    empTransPCA."Transaction Code" := empTrans."Transaction Code";
                                    empTransPCA."Payroll Period" := empTrans."Payroll Period";
                                    empTransPCA."Transaction Name" := empTrans."Transaction Name";
                                    empTransPCA.Amount := empTrans.Amount;
                                    empTransPCA.Balance := empTrans.Balance;
                                    empTransPCA.INSERT;
                                UNTIL empTrans.NEXT = 0;

                        END;


                    END;
                END;

            end;
        }
        field(2; "Employee Name"; Text[100])
        {
        }
        field(3; "Basic Pay"; Decimal)
        {
        }
        field(4; Comments; Text[200])
        {
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Posted;
        }
        field(6; "Period Month"; Integer)
        {
        }
        field(7; "Period Year"; Integer)
        {
        }
        field(8; "Payroll Period"; Date)
        {
            TableRelation = "PRL-Payroll Periods"."Date Opened" WHERE(Closed = CONST(false));
        }
        field(9; "Change Advice Serial No."; Code[50])
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
        field(10; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(11; Effected; Boolean)
        {
        }
        field(20; "Currency Code"; Code[10])
        {
        }
        field(21; "User ID"; Code[50])
        {
        }
        field(22; "Pays NSSF"; Boolean)
        {
        }
        field(23; "Pays NHIF"; Boolean)
        {
        }
        field(24; "Pays PAYE"; Boolean)
        {
        }
        field(25; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(26; PAyrollCode; Code[50])
        {
            TableRelation = "PRL-Payroll Type";
        }
        field(27; "Region Code"; Code[50])
        {
            CalcFormula = Lookup("HRM-Employee C".Region WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(28; "Department Code"; Code[50])
        {
            CalcFormula = Lookup("HRM-Employee C"."Department Code" WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(29; "School Code"; Code[50])
        {
            //CalcFormula = Lookup("HRM-Employee C" WHERE ("No."=FIELD("Employee Code")));
            // FieldClass = FlowField;
        }
        field(30; "Section Code"; Code[50])
        {
            // CalcFormula = Lookup ("HRM-Employee C" WHERE ("No."=FIELD("Employee Code")));
            //FieldClass = FlowField;
        }
        field(31; Multipay; Boolean)
        {
        }
        field(32; "Transfer/Appointment No"; Code[50])
        {
        }
        field(33; "Region Name"; Text[250])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Region Code")));
            FieldClass = FlowField;
        }
        field(34; "Department Name"; Text[250])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Department Code")));
            FieldClass = FlowField;
        }
        field(35; "School Name"; Text[250])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("School Code")));
            FieldClass = FlowField;
        }
        field(36; "Section Name"; Text[250])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Section Code")));
            FieldClass = FlowField;
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

        Usetup.RESET;
        Usetup.SETRANGE(Usetup."User ID", USERID);
        IF Usetup.FIND('-') THEN BEGIN
            // PAyrollCode := Usetup."Payroll Code";
        END ELSE
            //ERROR('Please contact your admin to be setup to raise PCAs');

        fnCheckEmployeeStatus;
    end;

    var
        HrSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit 396;
        objEmp: Record "HRM-Employee C";
        objSalCard: Record "PRL-Salary Card";
        empTrans: Record "PRL-Period Transactions";
        empTransPCA: Record "PRL-Period Transactions";
        objPayrollPeriod: Record "PRL-Payroll Periods";
        Usetup: Record 91;

    procedure fnCheckEmployeeStatus()
    var
        objEmp: Record "HRM-Employee C";
    begin
        objEmp.RESET;
        objEmp.SETRANGE(objEmp."No.", "Employee Code");
        objEmp.SETFILTER(objEmp.Status, '<>%1', objEmp.Status::Active);
        IF objEmp.FIND('-') THEN BEGIN
            ERROR('You cannot raise a PCA for someone who is not Active');
            "Employee Code" := '';
            MODIFY;
        END;
    end;
}

