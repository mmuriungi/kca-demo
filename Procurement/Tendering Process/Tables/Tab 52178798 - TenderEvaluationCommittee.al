table 52178798 "Tender Evaluation Committee"
{
    fields
    {
        field(1; "Tender No."; Code[50])
        {

        }
        field(2; "Employee no"; Code[30])
        {
            TableRelation = "HRM-Employee C"."No.";
            trigger OnValidate()
            var
                empl: Record "HRM-Employee C";
            begin
                empl.Reset();
                empl.SetRange("No.", "Employee no");
                if empl.Find('-') then begin
                    "Employee name" := empl."First Name" + ' ' + empl."Middle Name" + ' ' + empl."Last Name";
                    "Job Title" := empl."Job Title";


                end;
            end;
        }
        field(3; "Employee name"; Text[150])
        {

        }
        field(4; "Job Title"; Text[100])
        {

        }
        field(5; "Employee Cost Center"; Code[50])
        {

        }
        field(6; "Employee Region"; Code[50])
        {

        }
        field(7; "User Name"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(8; "Is Active"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Active Session" WHERE("User ID" = FIELD("User Name")));
            Editable = false;
        }

    }
    keys
    {
        key(key1; "Tender No.", "Employee no")
        {

        }
    }
}