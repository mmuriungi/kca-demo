table 50083 "HR Asset Transfer Lines"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Asset No."; Code[20])
        {
            TableRelation = "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                IF fasset.GET("Asset No.") THEN BEGIN
                    //    "Asset Bar Code":=fasset."Bar Code";
                    "Asset Description" := fasset.Description;
                    "FA Location" := fasset."FA Location Code";
                    "Responsible Employee Code" := fasset."Responsible Employee";
                    IF HRTAB.GET("Responsible Employee Code") THEN "Employee Name" := HRTAB."No." + ' ' + HRTAB."Job Title";
                    "Asset Serial No" := fasset."Serial No.";
                    "Global Dimension 1 Code" := fasset."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := fasset."Global Dimension 2 Code";
                END;
            end;
        }
        field(3; "Asset Bar Code"; Code[50])
        {
        }
        field(4; "Asset Description"; Text[200])
        {
        }
        field(5; "FA Location"; Code[80])
        {
            TableRelation = "Fixed Asset"."Location Code";
        }
        field(6; "Responsible Employee Code"; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(7; "Asset Serial No"; Text[50])
        {
        }
        field(8; "Employee Name"; Text[50])
        {
        }
        field(9; "Reason for Transfer"; Text[50])
        {
        }
        field(10; "New Responsible Employee Code"; Code[20])
        {

            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin

                HRTAB.RESET;
                IF HRTAB.GET("New Responsible Employee Code") THEN BEGIN
                    "New Employee Name" := HRTAB.Names + ' ' + HRTAB."Job Title";
                END ELSE BEGIN
                    "New Employee Name" := '';
                END;
            end;
        }
        field(11; "New Employee Name"; Text[100])
        {
        }
        field(12; "Shortcut Dimension 3 Code"; Code[50])
        {
            Caption = 'Current Project Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            var
                Dimn: Record 349;
            begin
                Dimn.SETRANGE(Dimn.Code, "Shortcut Dimension 3 Code");
                IF Dimn.FIND('-') THEN BEGIN
                    "Dimension 1 Name" := Dimn.Name;
                END;
            end;
        }
        field(13; "New Shortcut Dimension 3 Code"; Code[50])
        {
            Caption = 'New Project Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            var
                Dimn: Record 349;
            begin
                Dimn.SETRANGE(Dimn.Code, "Shortcut Dimension 3 Code");
                IF Dimn.FIND('-') THEN BEGIN
                    "New  Dimension 1 Name" := Dimn.Name;
                END;
            end;
        }
        field(14; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,1,2';
            Caption = 'Current Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                Dimn: Record 349;
            begin
                Dimn.SETRANGE(Dimn.Code, "Global Dimension 2 Code");
                IF Dimn.FIND('-') THEN BEGIN
                    "Dimension 2 Name" := Dimn.Name;
                END;
            end;
        }
        field(15; "New Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,1,2';
            Caption = 'New Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                Dimn: Record 349;
            begin
                Dimn.SETRANGE(Dimn.Code, "New Global Dimension 2 Code");
                IF Dimn.FIND('-') THEN BEGIN
                    "New  Dimension 2 Name" := Dimn.Name;
                END;
            end;
        }
        field(16; "Global Dimension 1 Code"; Code[50])
        {
            Caption = 'Current Station Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                Dimn: Record 349;
            begin
                Dimn.SETRANGE(Dimn.Code, "Global Dimension 1 Code");
                IF Dimn.FIND('-') THEN BEGIN
                    "Dimension 3 Name" := Dimn.Name;
                END;
            end;
        }
        field(17; "New Global Dimension 1 Code"; Code[50])
        {
            Caption = 'New Station Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                Dimn: Record 349;
            begin
                Dimn.SETRANGE(Dimn.Code, "New Global Dimension 1 Code");
                IF Dimn.FIND('-') THEN BEGIN
                    "New  Dimension 3 Name" := Dimn.Name;
                END;
            end;
        }
        field(18; "Dimension 1 Name"; Text[100])
        {
            Caption = 'Current Project Name';
        }
        field(19; "New  Dimension 1 Name"; Text[100])
        {
            Caption = 'New Project Name';
        }
        field(20; "Dimension 2 Name"; Text[100])
        {
            Caption = 'Current Department Name';
        }
        field(21; "New  Dimension 2 Name"; Text[100])
        {
            Caption = 'New Department Name';
        }
        field(22; "Dimension 3 Name"; Text[100])
        {
            Caption = 'Current Station Name';
        }
        field(23; "New  Dimension 3 Name"; Text[100])
        {
            Caption = 'New Station Name';
        }
        field(24; "Is Asset Expected Back?"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(25; "Duration of Transfer"; Text[20])
        {
        }
        field(26; "New Asset Location"; Text[50])
        {
            TableRelation = "FA Location";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        fasset: Record "Fixed Asset";
        HRTAB: Record "HRM-Employee C";
        PrjctCde: Record "Dimension Value";
        Dimvalu: Integer;
}

