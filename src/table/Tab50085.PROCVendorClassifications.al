table 50085 "PROC-Vendor Classifications"
{
    LookupPageId = "PROC-Vendor Classifications";
    DrillDownPageId = "PROC-Vendor Classifications";
    fields
    {
        field(1; "Code"; Code[20])
        {
            TableRelation = "PROC-Vendor Categories";

            trigger OnValidate()
            var
                vc: Record "PROC-Vendor Categories";
            begin
                vc.Reset();
                vc.SetRange("Code", Rec."Code");
                if vc.Find('-') then
                    Description := Vc.Description;

            end;
        }
        field(2; "Vendor"; code[20])
        {
            TableRelation = Vendor;
        }
        field(3; "Description"; Text[100])
        {

        }
        field(4; "PreQualification Code"; code[50])
        {
            TableRelation = "PROC-Vendor Prequalifications";
            trigger OnValidate()
            var
                preq: Record "PROC-Vendor Prequalifications";
            begin
                preq.Reset();
                preq.SetRange("Prequalification Code", "PreQualification Code");
                if preq.Find('-') then
                    "Prequalification Description" := preq.Description;
            end;
        }
        field(5; "Prequalification Description"; text[100])
        {

        }

    }

    keys
    {
        key(pk; "Code", Vendor, "PreQualification Code")
        {

        }
    }
}