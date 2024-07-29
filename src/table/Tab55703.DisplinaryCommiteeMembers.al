table 55703 "Displinary Commitee Members"
{
    LookupPageId = "Displinary Commitee Members";
    DrillDownPageId = "Displinary Commitee Members";
    fields
    {
        field(1; "Case No."; Code[30])
        {

        }
        field(2; "Committee Type"; code[100])
        {

        }
        field(3; "Employee No."; code[30])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            var
                empl: Record "HRM-Employee C";
            begin
                empl.Reset();
                empl.SetRange("No.", Rec."Employee No.");
                if empl.Find('-') then begin
                    Rec."Employee Name" := empl."First Name" + ' ' + empl."Middle Name" + ' ' + empl."Last Name";
                    Rec."Job Title" := empl."Job Title";
                end;
            end;
        }
        field(4; "Employee Name"; text[100])
        {

        }
        field(5; "Job Title"; Text[100])
        {

        }
        field(6; Attended; Boolean)
        {

        }
        field(7; "Remarks"; text[200])
        {

        }


    }
    keys
    {
        key(Key1; "Case No.", "Committee Type", "Employee No.")
        {

        }
    }
}