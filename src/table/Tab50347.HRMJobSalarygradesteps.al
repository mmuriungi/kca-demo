table 50347 "HRM-Job_Salary grade/steps"
{
    DrillDownPageID = "HRM-Job_Salary Grade/Steps";
    LookupPageID = "HRM-Job_Salary Grade/Steps";

    fields
    {
        field(2; "Employee Category"; Code[30])
        {
            TableRelation = "HRM-Employee Categories".Code;
        }
        field(3; "Salary Grade code"; Code[30])
        {
            TableRelation = "HRM-Salary Grades"."Salary Grade";
        }
        field(4; "Grade Level"; Integer)
        {
        }
        field(5; "House Allowance"; Decimal)
        {
        }
        field(6; "Leave Allowance"; Decimal)
        {
        }
        field(7; "Medical Ceilling"; Decimal)
        {
        }
        field(8; "Annual Leave Days"; Decimal)
        {
        }
        field(9; "Grade Description"; Text[100])
        {
            CalcFormula = Lookup("HRM-Salary Grades".Description WHERE("Salary Grade" = FIELD("Salary Grade code")));
            FieldClass = FlowField;
        }
        field(10; "Weekly Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Commuter Allowance"; Decimal)
        {

        }
        field(12; "Book Allowance"; Decimal)
        {

        }
        field(13; "Inpatient Medical Ceiling"; Decimal)
        {
           
        }
         field(14; "Outpatient Medical Ceiling"; Decimal)
        {
           
        }
         field(15; "Optical Medical Ceiling"; Decimal)
        {
           
        }
    }

    keys
    {
        key(Key1; "Employee Category", "Salary Grade code")
        {
        }
        key(Key2; "Grade Level")
        {
        }
    }

    fieldgroups
    {
    }
}

