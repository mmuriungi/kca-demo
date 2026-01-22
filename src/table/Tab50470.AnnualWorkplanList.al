/// <summary>
/// Table Annual Workplan List (ID 50038).
/// </summary>
table 50470 "Annual Workplan List"
{
    Caption = 'Annual Workplan List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Financial Period"; Code[30])
        {
            Editable = false;
            Caption = 'Financial Period';
            DataClassification = ToBeClassified;
        }
        field(2; "Key Result Area"; Text[500])
        {
            Caption = 'Key Result Area';
            DataClassification = ToBeClassified;
        }
        field(3; "Strategic Objective"; Text[500])
        {
            Caption = 'Strategic Objective';
            DataClassification = ToBeClassified;
        }
        field(4; "Projected Output"; Text[500])
        {
            Caption = 'Projected Output';
            DataClassification = ToBeClassified;
        }
        field(5; Activities; Text[500])
        {
            Caption = 'Activities';
            DataClassification = ToBeClassified;
        }
        field(6; "Approved Budget Gok"; Decimal)
        {
            Caption = 'Approved Budget Gok';
            DataClassification = ToBeClassified;
        }
        field(7; "Approved Budget Donor"; Decimal)
        {
            Caption = 'Approved Budget Donor';
            DataClassification = ToBeClassified;
        }
        field(8; "Target in FY "; Code[50])
        {
            Caption = 'Target in FY ';
            DataClassification = ToBeClassified;
        }
        field(9; "Means of Verification"; Text[250])
        {
            Caption = 'Means of Verification';
            DataClassification = ToBeClassified;
        }
        field(10; January; Boolean)
        {
            Caption = 'January';
            DataClassification = ToBeClassified;

        }
        field(11; February; Boolean)
        {
            Caption = 'February';

            DataClassification = ToBeClassified;
        }
        field(12; March; Boolean)
        {
            Caption = 'March';
            DataClassification = ToBeClassified;
        }
        field(13; April; Boolean)
        {
            Caption = 'April';
            DataClassification = ToBeClassified;
        }
        field(14; May; Boolean)
        {
            Caption = 'May';
            DataClassification = ToBeClassified;
        }
        field(15; June; Boolean)
        {
            Caption = 'June';
            DataClassification = ToBeClassified;
        }
        field(16; July; Boolean)
        {
            Caption = 'July';
            DataClassification = ToBeClassified;
        }
        field(17; August; Boolean)
        {
            Caption = 'August';
            DataClassification = ToBeClassified;
        }
        field(18; September; Boolean)
        {
            Caption = 'September';
            DataClassification = ToBeClassified;
        }
        field(19; October; Boolean)
        {
            Caption = 'October';
            DataClassification = ToBeClassified;
        }
        field(20; November; Boolean)
        {
            Caption = 'November';
            DataClassification = ToBeClassified;
        }
        field(21; December; Boolean)
        {
            Caption = 'December';
            DataClassification = ToBeClassified;
        }
        field(22; Responsibility; Text[500])
        {
            Caption = 'Responsibility';
            DataClassification = ToBeClassified;
        }
        field(23; "S/N"; Integer)
        {
            Caption = 'S/N';
            DataClassification = ToBeClassified;

            AutoIncrement = true;

        }



        field(28; Timelines; Option)
        {
            OptionMembers = " ",Q1,Q2,Q3,Q4,Continous,Monthly;
        }
        field(29; Transferred; boolean)
        {
            Editable = true;

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

    }
    keys
    {
        key(key1; "Financial Period", "S/N")
        {

        }

    }
    fieldgroups
    {
        fieldgroup(dropdown; "Financial Period", "Key Result Area", "Strategic Objective")
        {

        }
    }

    /// <summary>
    /// ValidateToTimeline.
    /// /// /// </summary>
    procedure ValidateToTimeline()
    begin
        Wpheader.Reset();
        Wpheader.SetRange("Financial Period", Wpheader."Financial Period");
        if Wpheader.Find('-') then begin
            Wplist.Reset();
            wplist.SetRange("Financial Period", Wpheader."Financial Period");
            if Wplist.Find('-') then begin
                if January = true then begin
                    Timelines := Timelines::Q3
                end else
                    if February = true then begin
                        Timelines := Timelines::Q3
                    end else
                        if March = true then begin
                            Timelines := Timelines::Q3
                        end else
                            if April = true then begin
                                Timelines := Timelines::Q4
                            end else
                                if May = true then begin
                                    Timelines := Timelines::Q4
                                end else
                                    if june = true then begin
                                        Timelines := Timelines::Q4
                                    end else
                                        if July = true then begin
                                            Timelines := Timelines::Q1
                                        end else
                                            if August = true then begin
                                                Timelines := Timelines::Q1
                                            end else
                                                if September = true then begin
                                                    Timelines := Timelines::Q1
                                                end else
                                                    if October = true then begin
                                                        Timelines := Timelines::Q2
                                                    end else
                                                        if November then begin
                                                            Timelines := Timelines::Q2
                                                        end else
                                                            if December then begin
                                                                Timelines := Timelines::Q2
                                                            end else
                                                                if (july = true) and (August = true) and (September = true) and (October = true) and (November = true) and (December = true) and (January = true) and (February = true) and (March = true) and (April = true) and (may = true) and (june = true) then begin Timelines := Timelines::Monthly; end;
            end;
        end;


    end;

    var
        Dimension: record "Dimension Value";
        Wplist: Record "Annual Workplan List";
        Wpheader: record "Annual Workplan Header";
        Appraisal: record Appraisal;
}
