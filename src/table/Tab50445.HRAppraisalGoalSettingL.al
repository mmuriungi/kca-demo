table  50445 "HR Appraisal Goal Setting L"
{

    fields
    {
        field(1; "Appraisal No"; Code[30])
        {
            TableRelation = "HR Appraisal indicators"."Entry No";

            trigger OnValidate()
            begin
                HRAppraisalGoalSettingH.GET("Appraisal No");
                //"Employee No":=HRAppraisalGoalSettingH."Employee No";
                HRAppraisalGoalSettingH.TESTFIELD(HRAppraisalGoalSettingH."Appraisal Year");
                "Appraisal Period" := HRAppraisalGoalSettingH."Appraisal Year";
                //"Appraisal Stage":=HRAppraisalGoalSettingH.Test1;
                "Appraisal Type" := HRAppraisalGoalSettingH."Performance Indicator";
                //Sent:=HRAppraisalGoalSettingH.Test;
            end;
        }
        field(3; "Appraisal Period"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Lookup Values"."Code" WHERE(Type = FILTER("Appraisal Period"));
        }
        field(7; "Agreement With Rating"; Option)
        {
            OptionMembers = Entirely,Mostly,"To some extent","Not at all";
        }
        field(8; "Planned Targets/Objectives"; Text[250])
        {
        }
        field(10; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee C"."No.";
        }
        field(11; "Criteria/Target Date"; Text[250])
        {
        }
        field(12; "Target Points (Total=100)"; Decimal)
        {
        }
        field(13; Score; Decimal)
        {
            FieldClass = Normal;
            MaxValue = 5;
            MinValue = 0;
        }
        field(14; "Appraisal Rating"; Code[40])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = FILTER(Grade));
        }
        field(15; Scored; Decimal)
        {
        }
        field(16; "Total score"; Decimal)
        {
        }
        field(17; "Appraisal Stage"; Option)
        {
            OptionMembers = "Target Setting",FirstQuarter,SecondQuarter,ThirdQuarter,EndYearEvaluation;
        }
        field(18; Sent; Option)
        {
            OptionMembers = "At Appraisee","At Supervisor";
        }
        field(19; "No Series"; Integer)
        {
            AutoIncrement = true;
        }
        field(20; "Appraisal Type"; Code[50])
        {
        }
        field(21; "Appraiser Rating"; Integer)
        {
        }
        field(22; "Appraisee Rating"; Integer)
        {
        }
        field(23; "Agreed Rating"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "No Series", "Appraisal No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //HRAppraisalGoalSettingH.SETRANGE(HRAppraisalGoalSettingH."Appraisal No","Appraisal No");
        //IF HRAppraisalGoalSettingH.Sent=1 THEN
        //ERROR(Mcontent);
        IF Sent <> Sent::"At Appraisee" THEN
            ERROR(Mcontent);
    end;

    trigger OnInsert()
    begin
        HRAppraisalGoalSettingH.GET("Appraisal No");
        // "Employee No":=HRAppraisalGoalSettingH."Employee No";
        HRAppraisalGoalSettingH.TESTFIELD(HRAppraisalGoalSettingH."Appraisal Year");
        "Appraisal Period" := HRAppraisalGoalSettingH."Appraisal Year";
        // "Appraisal Stage":=HRAppraisalGoalSettingH.Test1;
        "Appraisal Type" := HRAppraisalGoalSettingH."Performance Indicator";
        //Sent:=HRAppraisalGoalSettingH.Test;

        //HRAppraisalGoalSettingH.RESET;
        //HRAppraisalGoalSettingH.SETRANGE(HRAppraisalGoalSettingH."Entry No","Appraisal No");
        IF HRAppraisalGoalSettingH.FIND('-') THEN BEGIN
            //IF HRAppraisalGoalSettingH.Test<>HRAppraisalGoalSettingH.Test::"0" THEN
            ERROR(Mcontent2);
        END;
    end;

    trigger OnModify()
    begin
        //IF Sent<> Sent::Appraisee THEN
        //ERROR(Mcontent);

        HRAppraisalGoalSettingH.RESET;
        //HRAppraisalGoalSettingH.SETRANGE(HRAppraisalGoalSettingH."Entry No","Appraisal No");
        IF HRAppraisalGoalSettingH.FIND('-') THEN BEGIN
            //IF HRAppraisalGoalSettingH.Test<>HRAppraisalGoalSettingH.Test::"0" THEN
            ERROR(Mcontent);
        END;
    end;

    var
        Employee: Record "HRM-Employee C";
        HRAppraisalGoalSettingH: Record "HR Appraisal indicators";
        Mcontent: Label 'The Objective cannot be modified while being reviewed by the Supervisor';
        Mcontent2: Label 'You cannot insert a new target when the appraisal is being reviewed by the supervisor';
}

