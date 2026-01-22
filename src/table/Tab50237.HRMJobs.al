table 50237 "HRM-Jobs"
{
    DrillDownPageID = "HRM-Jobs List";
    LookupPageID = "HRM-Jobs List";

    fields
    {
        field(1; "Job ID"; Code[50])
        {



        }

        field(2; "Job Title"; Text[50])
        {
            Editable = true;
        }
        field(13; "Job Description"; Text[100])
        {

        }
        field(3; "No of Posts"; Integer)
        {

            trigger OnValidate()
            begin
                if "No of Posts" <> xRec."No of Posts" then
                    "Vacant Positions" := "No of Posts" - "Occupied Positions";
            end;
        }
        field(4; "Position Reporting to"; Code[20])
        {
            TableRelation = "HRM-Jobs"."Job ID" WHERE(Status = CONST(Approved));
        }
        field(5; "Occupied Positions"; Integer)
        {
            CalcFormula = Count("HRM-Employee C" WHERE("Job Title" = FIELD("Job ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Vacant Positions"; Integer)
        {
            Editable = false;

            trigger OnValidate()
            begin
                //"Vacant Positions" := "No of Posts" - "Occupied Positions";
            end;
        }
        field(7; "Score code"; Code[20])
        {
        }
        field(8; "Directorate Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = filter('region|regions'));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Directorate Code");
                if Dimn.Find('-') then begin
                    "Directorate Name" := Dimn.Name;
                end;
            end;
        }
        field(9; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = filter('DEPARTMENT|DEPARTMENTS'));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Department Code");
                if Dimn.Find('-') then begin
                    "Department Name" := Dimn.Name;
                end;
            end;
        }
        field(11; "Division Code"; Code[20])
        {
            TableRelation = "Dimension Value".code where("Dimension Code" = filter('division|divisions'));
            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Division Code");
                if Dimn.Find('-') then begin
                    "Division Name" := Dimn.Name;
                end;
            end;
        }
        field(12; "Division Name"; Code[30])
        {

        }
        field(17; "Total Score"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(19; "Main Objective"; Text[250])
        {
        }
        field(21; "Key Position"; Boolean)
        {
        }
        field(22; Category; Code[20])
        {
        }
        field(23; Grade; Code[20])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST(Grade));
        }
        field(24; "Employee Requisitions"; Integer)
        {
            CalcFormula = Count("HRM-Employee Requisitions" WHERE("Job ID" = FIELD("Job ID")));
            FieldClass = FlowField;
        }
        field(27; UserID; Code[50])
        {
        }
        field(28; "Supervisor/Manager"; Code[10])
        {
            TableRelation = "HRM-Employee C"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                HREmp.Get("Supervisor/Manager");
                "Supervisor Name" := HREmp.FullName;
            end;
        }
        field(29; "Supervisor Name"; Text[30])
        {
            Editable = false;
        }
        field(30; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(31; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(32; "Date Created"; Date)
        {
        }
        field(33; "No. of Requirements"; Integer)
        {
            CalcFormula = Count("HRM-Job Requirements" WHERE("Job Id" = FIELD("Job ID")));
            FieldClass = FlowField;
        }
        field(34; "No. of Responsibilities"; Integer)
        {
            CalcFormula = Count("HRM-Job Responsiblities (B)" WHERE("Job ID" = FIELD("Job ID")));
            FieldClass = FlowField;
        }
        field(35; "Reason for Job creation"; Text[200])
        {
        }
        field(36; "Memo Ref No."; Code[100])
        {
        }
        field(37; "Memo Approval Date"; Date)
        {
        }
        field(38; "Station Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, "Station Code");
                if Dimn.Find('-') then begin
                    "Station Name" := Dimn.Name;
                end;
            end;
        }
        field(50000; "Station Name"; Text[100])
        {
            Editable = false;
        }
        field(50001; "Directorate Name"; Text[100])
        {
            Editable = false;
        }
        field(50002; "Department Name"; Text[100])
        {
            Editable = false;
        }
        field(50003; "Employment Category"; Code[20])
        {
            TableRelation = "HRM-Employee Categories".Code;
        }
        field(50004; "Employment Grade"; Code[20])
        {
            TableRelation = "HRM-Job_Salary grade/steps"."Salary Grade code" WHERE("Employee Category" = FIELD("Employment Category"));

            trigger OnValidate()
            begin
                Grade := "Employment Grade";
            end;
        }
        field(50005; "Job Reference Number"; Text[50])
        {

        }
        field(50006; "Division"; Option)
        {
            OptionMembers = Academic,Administrative;
        }
        field(10; "No series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Job Type"; Option)
        {
            OptionMembers = " ",Teaching,"Non Teaaching";
        }
        //Job category
        field(50008; "Job Category"; enum "Job Category")
        {

        }
        field(50009; "Specialization"; Code[20])
        {
            //TableRelation = "HRM-Lookup Values";
        }
    }

    keys
    {
        key(Key1; "Job ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Job Title")
        {
        }
    }

    trigger OnDelete()
    begin

        CALCFIELDS("Occupied Positions");
        IF "Occupied Positions" > 0 THEN
            ERROR('Cannot delete job if it has occupants');


    end;

    trigger OnInsert()
    begin
        requisitionno := '';
        if hrmsetup.Get then begin
            if hrmsetup."Job ID" <> '' then begin
                Nosetup.Reset;
                Nosetup.SetRange(Nosetup."Series Code", hrmsetup."Fuel Register");
                if Nosetup.Find('-') then requisitionno := Nosetup."Last No. Used";
            end;
        end;
        if "Job ID" = '' then begin
            hrmsetup.Get;
            hrmsetup.TestField(hrmsetup."Job ID");
            NoSeriesMgt.InitSeries(hrmsetup."Job ID", xRec."No Series", 0D, "Job ID", "No Series");
            //"Requisition No":=requisitionno;
        end;

        if xRec."Job ID" <> '' then "Job ID" := xRec."Job ID";
        UserID := UserID;
        "Date Created" := Today;
    end;


    trigger OnModify()
    begin
        /* CALCFIELDS("Occupied Positions");
         IF "Occupied Positions">0 THEN
         ERROR('Cannot modify job if it has occupants');
        */

    end;

    var
        Nosetup: Record "No. Series Line";
        requisitionno: code[20];
        NoOfPosts: Decimal;
        HREmp: Record "HRM-Employee C";
        Dimn: Record "Dimension Value";
        Hrmsetup: Record "HRM-Setup";
        NoSeriesMgt: codeunit 396;
}

