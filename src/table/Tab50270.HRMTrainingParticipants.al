table 50270 "HRM-Training Participants"
{
    DrillDownPageID = "HRM-Training Partcipants";
    LookupPageID = "HRM-Training Partcipants";

    fields
    {
        field(1; "Training Code"; Code[30])
        {

            trigger OnValidate()
            begin
                /*IF Training."Training category"<> Training."Training category"::Group THEN
                ERROR(mcontent);
                */

            end;
        }
        field(2; "Employee Code"; Code[30])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                if Hr.Get("Employee Code") then
                    "Employee name" := Hr."First Name" + ' ' + Hr."Middle Name" + ' ' + Hr."Last Name";
            end;
        }
        field(3; "Employee name"; Text[60])
        {
        }
        field(4; Objectives; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Training Code", "Employee Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Training.Reset;
        Training.SetRange(Training."Application No", "Training Code");
        if Training.Find('-') then begin
            if Training."Training Category" <> Training."Training Category"::Group then
                Error(mcontent);
        end;
    end;

    var
        Hr: Record "HRM-Employee C";
        Training: Record "HRM-Training Applications";
        mcontent: Label 'You cannot assign participants where training category is ''Individual''';
}

