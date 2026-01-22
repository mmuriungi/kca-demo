table 50447 "Appraisal Card"
{

    fields
    {
        field(1; "Appraisal Code"; Code[50])
        {
        }
        field(2; "Staff No"; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                HrEmp.SETRANGE(HrEmp."No.", "Staff No");
                //IF HrEmp.FIND('-') THEN
                "Staff Name" := HrEmp."First Name" + '  ' + HrEmp."Middle Name" + '  ' + HrEmp."Last Name";
                "Current Department" := HrEmp."Department Name";
                "Job Title" := HrEmp."Job Title";
                "Position Held Since" := HrEmp."Date Of Join";
            end;
        }
        field(3; "Appraisal Type"; Code[10])
        {
            TableRelation = "HRM-Lookup Values"."Code" WHERE(Type = CONST("Appraisal Type"));
        }
        field(4; "Appraisal Period"; Code[10])
        {
            TableRelation = "HRM-Lookup Values"."Code" WHERE(Type = CONST("Appraisal Period"));
        }
        field(8; Status; Option)
        {
            OptionMembers = Appraisee,Moderation,Concurrence,Supervisor,"Closed/HR","JSAC/SSASC",DDHR,"Full Board";
        }
        field(9; Supervisor; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                HrEmp.SETRANGE(HrEmp."No.", Supervisor);
                //IF HrEmp.FIND('-') THEN BEGIN
                "Supervisor Name" := HrEmp."First Name" + '  ' + HrEmp."Middle Name" + '  ' + HrEmp."Last Name";
                "Supervisor ID" := HrEmp."User ID";
                //END;
            end;
        }
        field(10; "Explored By Appraisee"; Boolean)
        {
        }
        field(11; "Explored By Supervisor"; Boolean)
        {
        }
        field(12; "Staff Name"; Text[100])
        {
        }
        field(13; "Email Address"; Text[100])
        {
        }
        field(14; "Current Division"; Text[50])
        {
        }
        field(15; "Current Department"; Text[50])
        {
        }
        field(16; Grade; Code[10])
        {
        }
        field(17; "Office Location"; Text[20])
        {
        }
        field(18; "Alternate Supervisor"; Code[10])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(19; "Supervisor Name"; Text[100])
        {
        }
        field(20; "Job Title"; Text[80])
        {
        }
        field(21; "Position Held Since"; Date)
        {
        }
        field(22; "Supervisor Email"; Text[50])
        {
        }
        field(23; "Alternate Supervisor Name"; Text[5])
        {
        }
        field(24; "Alternate Supervisor Email"; Text[30])
        {
        }
        field(25; "GrandObjective score"; Decimal)
        {
        }
        field(26; "GrandInterPersonal score"; Decimal)
        {
        }
        field(27; GrandTotal; Decimal)
        {
        }
        field(28; "Date Appraisee Concurred"; Date)
        {
        }
        field(29; "Date Moderator Concurred"; Date)
        {
        }
        field(30; "Appraisee Concurred"; Boolean)
        {
        }
        field(31; "Moderator Concurred"; Boolean)
        {
        }
        field(32; "Designation at First Appoint"; Text[100])
        {
        }
        field(33; "Date of Last promotion"; Date)
        {
        }
        field(34; "Work Rewarding"; Option)
        {
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(35; Text1; Text[200])
        {
        }
        field(36; Text2; Text[200])
        {
        }
        field(37; Text3; Text[200])
        {
        }
        field(38; Text4; Text[200])
        {
        }
        field(39; Text5; Text[200])
        {
        }
        field(40; Text6; Text[200])
        {
        }
        field(41; Text7; Text[200])
        {
        }
        field(42; Text8; Text[200])
        {
        }
        field(43; Text9; Text[200])
        {
        }
        field(44; Text10; Text[200])
        {
        }
        field(45; Text11; Text[200])
        {
        }
        field(46; "Supervisor ID"; Code[50])
        {
        }
        field(47; "No.of Children"; Decimal)
        {
        }
        field(48; Text12; Text[250])
        {
        }
        field(49; "Date Of Birth"; Date)
        {
        }
        field(50; "No. Series"; Code[20])
        {
        }
        field(51; "Comments by HR"; Text[200])
        {
        }
        field(52; "Approval by VC/DVC"; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Appraisal Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        IF "Appraisal Code" = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Appraisal Nos");
            NoSeriesMgt.InitSeries(HRSetup."Appraisal Nos", xRec."No. Series", 0D, "Appraisal Code", "No. Series");
        END;
    end;

    var
        HrEmp: Record "HRM-Employee C";
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
}

