table 51287 "PRl 13thSlip DaysComp"
{
    Caption = 'PRl 13thSlip DaysComp';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';

            trigger OnValidate()
            var
                HRMEmployee: Record "HRM-Employee (D)";
            begin
                if Rec."Employee Code" <> '' then begin
                    HRMEmployee.Reset();
                    HRMEmployee.SetRange("No.", Rec."Employee Code");
                    if HRMEmployee.FindFirst() then begin
                        Rec."F. Name" := HRMEmployee."First Name" + ' ' + HRMEmployee."Middle Name" + ' ' + HRMEmployee."Last Name";
                    end;
                end;
            end;
        }
        field(2; "F. Name"; Text[50])
        {
            Caption = 'F. Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("HRM-Employee (D)"."First Name" where("No." = field("Employee Code")));
        }
        field(3; "Payroll Period"; Date)
        {
            Caption = 'Payroll Period';
            // TableRelation = "PRL-13thSlip Payroll Periods"."Date Openned";

            trigger OnValidate()
            begin
                if "Payroll Period" <> 0D then begin
                    "Period Month" := Date2DMY("Payroll Period", 2);
                    "Period Year" := Date2DMY("Payroll Period", 3);
                end;
            end;
        }
        field(4; "Days Worked"; Decimal)
        {
            Caption = 'Days Worked';

            trigger OnValidate()
            begin
                // The original C/AL code was commented out, so I've left it out here
            end;
        }
        field(5; "Computed Days"; Integer)
        {
            Caption = 'Computed Days';
        }
        field(6; "Period Month"; Integer)
        {
            Caption = 'Period Month';
        }
        field(7; "Period Year"; Integer)
        {
            Caption = 'Period Year';
        }
        field(8; "Current Instalment"; Integer)
        {
            Caption = 'Current Instalment';
        }
        field(9; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
        }
        field(10; "M. Name"; Text[50])
        {
            Caption = 'M. Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("HRM-Employee (D)"."Middle Name" where("No." = field("Employee Code")));
        }
        field(11; "L. Name"; Text[50])
        {
            Caption = 'L. Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("HRM-Employee (D)"."Last Name" where("No." = field("Employee Code")));
        }
    }

    keys
    {
        key(PK; "Employee Code", "Payroll Period", "Current Instalment")
        {
            Clustered = true;
        }
    }

    var
        HRMEmployee: Record "HRM-Employee (D)";
        //StaffAttendanceLedger: Record 99210;
        Dates: Record Date;
}