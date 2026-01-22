#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 61251 "HRM-Medical Scheme Members"
{
    DrillDownPageID = "Medical Scheme Members";
    LookupPageID = "Medical Scheme Members";

    fields
    {
        field(1; "Scheme No"; Code[10])
        {
            TableRelation = "HRM-Medical Schemes"."Scheme No";

            trigger OnValidate()
            begin

                Medscheme.Reset;
                Medscheme.SetRange(Medscheme."Scheme No", "Scheme No");
                if Medscheme.Find('-') then begin
                    "Out-Patient Limit" := Medscheme."Out-patient limit";
                    "Scheme Name" := Medscheme."Scheme Name";
                    "In-patient Limit" := Medscheme."In-patient limit";
                    "Balance In- Patient" := "In-patient Limit" - "Cumm.Amount Spent";
                    "Balance Out- Patient" := "Out-Patient Limit" - "Cumm.Amount Spent Out";
                end;
            end;
        }
        field(2; "Employee No"; Code[10])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.", "Employee No");
                if Emp.Find('-') then begin
                    "First Name" := Emp."First Name" + ' ' + Emp."Middle Name";
                    "Last Name" := Emp."Last Name";
                    Designation := Emp."Job Title";
                    Department := Emp."Department Code";
                    "Scheme Join Date" := Emp."Confirmation Date";

                    //"In-patient Limit":=Medscheme."In-patient limit";
                end;
            end;
        }
        field(3; "First Name"; Text[30])
        {
        }
        field(4; "Last Name"; Text[30])
        {
        }
        field(5; Designation; Text[50])
        {
        }
        field(6; Department; Text[100])
        {
        }
        field(7; "Scheme Join Date"; Date)
        {
        }
        field(8; "Scheme Anniversary"; Date)
        {
        }
        field(9; "Cumm.Amount Spent"; Decimal)
        {
            CalcFormula = sum("HRM-Medical Claims"."Scheme Amount Charged" where("Member No" = field("Employee No"),
                                                                                  "Claim Type" = const(Inpatient),
                                                                                  Posted = const(true)));
            FieldClass = FlowField;
        }
        field(10; "Out-Patient Limit"; Decimal)
        {
        }
        field(11; "In-patient Limit"; Decimal)
        {
        }
        field(12; "Maximum Cover"; Decimal)
        {
        }
        field(13; "Cumm.Amount Spent Out"; Decimal)
        {
            CalcFormula = sum("HRM-Medical Claims"."Scheme Amount Charged" where("Member No" = field("Employee No"),
                                                                                  "Claim Type" = const(Outpatient),
                                                                                  posted = const(true)));
            FieldClass = FlowField;
        }
        field(14; "Balance Out- Patient"; Decimal)
        {
        }
        field(15; "Balance In- Patient"; Decimal)
        {
        }
        field(16; "Maximum No of dependants"; Decimal)
        {
        }
        field(17; "No of Depnedants"; Integer)
        {
            CalcFormula = count("HRM-Medical Dependants" where("Pricipal Member no" = field("Employee No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                if "No of Depnedants" > "Maximum No of dependants" then begin
                    Error('No. of dependants cannot exceedd the required number');
                end;
            end;
        }
        field(18; "Scheme Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Scheme No", "Employee No")
        {
            Clustered = true;
        }
        key(Key2; "Employee No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Medscheme: Record "HRM-Medical Schemes";
        Emp: Record "HRM-Employee C";
        mcontent: label 'You cannot delete a member with transactions';
}

