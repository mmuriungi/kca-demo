table 51161 "prEmployee Trans PCA"
{

    fields
    {
        field(1; "Employee Code"; Code[30])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(2; "Transaction Code"; Code[30])
        {
            TableRelation = "PRL-Transaction Codes"."Transaction Code";

            trigger OnValidate()
            begin
                objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod.Closed, FALSE);
                IF objPeriod.FIND('-') THEN BEGIN
                    CurrentYr := objPeriod."Period Year";
                END;


                IF Transcode.GET("Transaction Code") THEN BEGIN
                    IF Transcode."Transaction Code" = 'LEAVE' THEN BEGIN
                        EmployeeTrans.RESET;
                        EmployeeTrans.SETRANGE(EmployeeTrans."Employee Code", "Employee Code");
                        EmployeeTrans.SETRANGE(EmployeeTrans."Transaction Code", "Transaction Code");
                        IF EmployeeTrans.FIND('-') THEN BEGIN
                            REPEAT
                                IF EmployeeTrans."Period Year" = CurrentYr THEN BEGIN
                                    MonthName := FORMAT(EmployeeTrans."Payroll Period", 0, '<Month Text>');
                                    //ERROR(MonthName);
                                    ERROR('Employee has already been paid leave allowance in the period of %1.- %2', EmployeeTrans."Payroll Period",
                                           EmployeeTrans."Employee Code");
                                END;
                            UNTIL EmployeeTrans.NEXT = 0;
                        END;
                    END;
                END;

                IF "Transaction Code" = 'D0047' THEN BEGIN
                    IF PCACard.GET("Change Advice Serial No.") THEN BEGIN
                        Amount := PCACard."Basic Pay" * 0.05;
                        Balance := PCACard."Basic Pay" * 0.05;
                    END;
                END;
            end;
        }
        field(3; "Transaction Name"; Text[100])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Balance; Decimal)
        {
        }
        field(6; "Period Month"; Integer)
        {
        }
        field(7; "Period Year"; Integer)
        {
        }
        field(8; "Payroll Period"; Date)
        {
            TableRelation = "PRL-Payroll Periods"."Date Opened";
        }
        field(9; Comments; Text[250])
        {
        }
        field(10; "Change Advice Serial No."; Code[50])
        {
            TableRelation = "prBasic pay PCA"."Change Advice Serial No.";
        }
        field(11; "Employer Amount"; Decimal)
        {
        }
        field(12; "Start Date"; Date)
        {
        }
        field(13; "End Date"; Date)
        {
        }
        field(39003900; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(39003901; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(39003902; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(39003903; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
    }

    keys
    {
        key(Key1; "Change Advice Serial No.", "Employee Code", "Transaction Code", "Payroll Period")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Transcode: Record "PRL-Transaction Codes";
        EmployeeTrans: Record "PRL-Period Transactions";
        MonthName: Text[100];
        SalCard: Record "PRL-Salary Card";
        // SalaryNotches: Record "70135113";
        CurrentYr: Integer;
        objPeriod: Record "PRL-Payroll Periods";
        PCACard: Record "prBasic pay PCA";
}

