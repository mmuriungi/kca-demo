table 50141 "Internal Audit Champions"
{

    fields
    {
        field(1; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Risk Champion,Incident,Audit,Risk Owner,Risk Manager';
            OptionMembers = " ","Risk Champion",Incident,Audit,"Risk Owner","Risk Manager";
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where("Employment Type" = filter(Contract | Permanent));

            trigger OnValidate()
            begin

                IF Employee.GET("Employee No.") THEN BEGIN
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "E-Mail" := Employee."Company E-Mail";
                    "Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    if Employee."User ID" <> '' then
                        "User ID" := Employee."User ID"
                    else begin
                        //Get UserName
                        UserSetup.RESET;
                        UserSetup.SETRANGE("Employee No.", Employee."No.");
                        IF UserSetup.FINDFIRST THEN
                            "User ID" := UserSetup."User ID";
                    end;
                END;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false), "Dimension Value Type" = filter(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(6; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(7; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(8; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Escalator ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where("Employment Type" = filter(Contract | Permanent));

            trigger OnValidate()
            begin
                Employee.Reset();
                Employee.SetRange(Employee."No.", "Escalator ID");
                IF Employee.FindFirst() THEN BEGIN
                    "Risk Owner Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Risk Owner E-Mail" := Employee."Company E-Mail";
                END;
            end;

        }
        field(10; "Station Code"; Code[90])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Stations SetUp";
            trigger OnValidate()
            var
                ObjStation: Record "Stations SetUp";
            begin
                if ObjStation.Get("Station Code") then begin
                    "Station Name" := ObjStation.Description;
                end;
            end;
        }

        field(11; "Station Name"; Code[190])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Risk Owner Name"; Text[190])
        {
            Caption = 'Risk Owner Name';
            DataClassification = ToBeClassified;
        }
        field(13; "Risk Owner E-Mail"; Text[100])
        {
            Caption = 'Risk Owner E-Mail';
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; Type, "Employee No.", "Escalator ID", "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(grp; "Employee No.", "Employee Name", "Station Name")
        {

        }
    }

    var
        Employee: Record Employee;
        DimMgt: Codeunit DimensionManagement;
        UserSetup: Record "User Setup";

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

