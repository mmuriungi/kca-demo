/// <summary>
/// Table Appraisal (ID 50041).
/// </summary>
table 50478 Appraisal
{
    Caption = 'Appraisal';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Appraisal No"; code[30])
        {
            //Editable = false;
            DataClassification = ToBeClassified;

        }

        field(2; "Employee Code"; Code[50])
        {
            Caption = 'Employee Code';

            DataClassification = ToBeClassified;

            TableRelation = "HRM-Employee C"."No." where(Status = filter(Active));
            trigger OnValidate()
            begin
                Employee.Reset();
                Employee.SetRange("No.", rec."Employee Code");
                if employee.Find('-') then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Job Title" := Employee."Job Title";
                    "Global Dimension 2 Code" := Employee."Department Code";
                    "Shortcut Dimension 3 Code" := employee."Faculty Code";
                    "Global Dimension 1 Code" := Employee.Campus;
                    Designation := Employee."Job Title";
                    "Job Grade" := Employee."Salary Grade";
                    "Terms of Service" := Employee."Employee Category";

                end;
            end;


        }

        field(4; "Self Assement"; code[50])
        {
            Caption = 'Self Assement';
            TableRelation = "Response Scales".Code;
            DataClassification = ToBeClassified;
        }
        field(5; "Supervisors Comment"; Text[500])
        {
            Caption = 'Supervisors Comment';
            DataClassification = ToBeClassified;
        }
        field(6; "Response Scale"; code[50])
        {
            Caption = 'Response Scale';
            TableRelation = "Response Scales".Code;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                response.Reset();
                response.SetRange(Code, rec."Response Scale");
                if response.Find('-') then begin
                    Rating := response.Rating;
                end;


            end;
        }
        field(7; Rating; Integer)
        {
            Caption = 'Rating';
            DataClassification = ToBeClassified;
        }
        field(8; "Perfomance Gap"; Code[100])
        {
            Caption = 'Perfomance Gap';
            DataClassification = ToBeClassified;
        }
        field(9; "Required Training"; Text[500])
        {
            Caption = 'Required Training';
            DataClassification = ToBeClassified;
        }
        field(10; Timeline; Code[100])
        {
            Caption = 'Timeline';
            DataClassification = ToBeClassified;
        }
        field(11; "Employee Name"; text[150])
        {

        }


        field(14; "Job Title"; text[150])
        {

        }
        field(15; Designation; text[100])
        {

        }
        field(16; "Head of Department"; code[100])
        {
            TableRelation = "HRM-Employee C"."No." where(Status = filter(Active));

        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));


        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
        }
        field(18; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));
        }
        field(28; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));
        }
        field(19; "Terms of Service"; code[100])
        {

        }
        field(20; "Supervisor Name"; text[100])
        {

        }
        field(21; "Supervisor Designation"; Text[100])
        {

        }
        field(22; "Job Grade"; code[20])
        {

        }
        field(23; "Created By"; code[50])
        {

        }
        field(24; "Supervisor No"; code[30])
        {
            TableRelation = "HRM-Employee C"."No." where(Status = filter(Active));
            trigger OnValidate()
            begin
                if "Supervisor No" = "Employee Code" then Error('You cannot supervise yourself');
                begin
                    Employee.Reset();
                    Employee.SetRange("No.", rec."Supervisor No");
                    if employee.Find('-') then begin
                        "Supervisor Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                        "Supervisor Designation" := Employee."Job Title";
                    end;
                end;
            end;

        }
        field(25; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(26; Period; Code[20])
        {
            Caption = 'Period';
            TableRelation = "Appraisal Periods".Period where(closed = const(false));
            // TableRelation = "Annual Workplan Header"."Financial Period" where(Closed = filter(false));
            DataClassification = ToBeClassified;
        }

        field(27; "No. Series"; code[20])
        {
            TableRelation = "No. Series";
            Editable = false;

        }


        field(29; "Line No"; Integer)
        {

        }


    }

    keys
    {
        key(key1; "Appraisal No", Period, "Employee Code", "Line No")
        {
            Clustered = true;
        }




    }
    fieldgroups
    {
        fieldgroup(dropdown; "Employee Code")
        {

        }
    }
    trigger OnInsert()
    begin

        if "Appraisal No" = '' then begin
            Appsetup.Reset();
            if Appsetup.FindLast() then
                // Appsetup.Get;
                Appsetup.TestField(Appsetup."Appraisal No");
            NoSeriesMgt.InitSeries(Appsetup."Appraisal No", xRec."No. Series", 0D, Rec."Appraisal No", Rec."No. Series");
            // rec.Insert()
        end;
        "Created By" := UserId;
        Status := Status::Open;
    end;

    trigger OnModify()
    begin

    end;

    /// <summary>
    /// TargetsReview.
    /// </summary>
    procedure GenerateTargets()
    begin
        Wpheader.Reset();
        Wpheader.SetRange("Financial Period", Appraisal.Period);
        Wpheader.SetRange(Closed, false);
        if Wpheader.Find('-') then begin
            Wplist.Reset();
            Wplist.SetRange("Financial Period", Wpheader."Financial Period");
            /// Wplist.SetRange("Directorate Code", Appraisal."Directorate Code");
            // Wplist.SetRange("Department Code", Appraisal."Department code");
            Message('Hi');
            if Wplist.Find('-') then begin
                Wplist."Financial Period" := Targets.Period;
                repeat
                    Targets.Init();

                    Targets."Global Dimension 2 Code" := Wplist."Global Dimension 2 Code";
                    Targets."No." := Targets."No." + 1;
                    Targets.KRA := Wplist."Key Result Area";
                    Targets."Strategic Objectives" := Wplist."Strategic Objective";
                    Targets.Activity := Wplist.Activities;
                    Targets."Target Score" := Appsetup."Max Score";
                    Message('HI 3');
                    Targets.Insert(true);
                until Wplist.Next() = 0;
                Message('Targets obtained successfully');
            end;



        end;



    end;

    var
        Employee: record "HRM-Employee C";
        fieldeditable: Boolean;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Dimension: record "Dimension Value";
        Usersetup: record "User Setup";
        Appsetup: record "Appraisal Setups";
        Targets: record "Targets kra kpi";
        Wpheader: record "Annual Workplan Header";
        Wplist: record "Annual Workplan List";
        Perfomancerev: record "Perfomance Review";
        Appraisal: Record Appraisal;
        response: record "Response Scales";

}
