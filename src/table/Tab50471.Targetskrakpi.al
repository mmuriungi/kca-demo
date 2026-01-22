/// <summary>
/// Table Targets kra kpi (ID 50039).
/// </summary>
table 50471 "Targets kra kpi"
{
    LookupPageId = "Targets/Krs";
    Caption = 'Targets kra kpi';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Period; Code[20])
        {

            DataClassification = ToBeClassified;
        }
        field(2; KRA; Text[500])
        {

            DataClassification = ToBeClassified;



        }
        field(3; "Strategic Objectives"; Text[500])
        {
            Caption = 'Strategic Objectives';
            DataClassification = ToBeClassified;
        }
        field(4; Activity; Text[500])
        {
            Caption = 'Activity';
            DataClassification = ToBeClassified;
        }
        field(5; KPIs; Text[500])
        {

            DataClassification = ToBeClassified;
        }
        field(6; Timeline; Code[100])
        {
            Caption = 'Timeline';
            DataClassification = ToBeClassified;
        }
        field(7; "Target Score"; Integer)
        {
            Caption = 'Target Score';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                // if "Target Score" > 10 then Message('Input a value equal or less than 10');
            end;




        }
        field(8; "Achieved Outcome"; Integer)
        {
            Caption = 'Achieved Outcome';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Achieved Outcome" > "Target Score" then
                    Message('Achieved Outcome cannot be more that the target score');
                exit;
            end;
        }
        field(9; "Self Access"; Option)
        {
            Caption = 'Self Access';
            OptionMembers = " ",Always,Usually,Sometimes,Rarely,Never;
            DataClassification = ToBeClassified;
        }
        field(10; "Supervisor Access"; Option)
        {
            Caption = 'Supervisor Access';
            OptionMembers = " ",Always,Usually,Sometimes,Rarely,Never;
            DataClassification = ToBeClassified;
        }
        field(11; Rating; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(12; "Employee No"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Timelines; Option)
        {
            OptionMembers = " ",Q1,Q2,Q3,Q4,Continous,Monthly;
        }
        field(14; "Appraisal No"; code[20])
        {
            DataClassification = ToBeClassified;
        }



        field(24; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));


        }
        field(26; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
        }
        field(25; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,1,3';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));
        }
        field(27; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,1,4';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));
        }

        field(15; "No."; Integer)
        {


        }
        field(18; "Kra Sn"; Integer)
        {
            /* TableRelation = "Annual Workplan List"."S/N" where("Financial Period" = field(Period));
            trigger OnValidate()
            begin
                Wplist.Reset();
                Wplist.SetRange("S/N", REC."Kra Sn");
                if Wplist.FindSet(TRUE, true) then begin
                    KRA := Wplist."Key Result Area";
                    "Strategic Objectives" := Wplist."Strategic Objective";
                end;
            end; */
        }


    }
    keys
    {

        key(Pk; Period, KPIs, "Strategic Objectives", "Appraisal No", "Employee No", "Kra Sn")
        {

        }


    }
    fieldgroups
    {
        fieldgroup(dropdown; KPIs, "Strategic Objectives")
        {

        }
    }

    /// <summary>
    /// GenerateTargets.
    /// </summary>
    procedure GenerateTargets()
    begin

    end;

    var
        Employee: record "HRM-Employee C";
        Dimension: record "Dimension Value";
        Usersetup: record "User Setup";
        Appsetup: record "Appraisal Setups";
        Targets: record "Targets kra kpi";
        Wpheader: record "Annual Workplan Header";
        Wplist: record "Annual Workplan List";
        Perfomancerev: record "Perfomance Review";
}
