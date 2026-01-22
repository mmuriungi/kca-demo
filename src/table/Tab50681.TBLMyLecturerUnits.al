table 50681 TBLMyLecturerUnits
{
    Caption = 'TBLMyLecturerUnits';
    DataClassification = ToBeClassified;
    LookupPageId = TBLMyLecturerUnits;
    DrillDownPageId = TBLMyLecturerUnits;

    fields
    {
        field(1; UserCode; Code[20])
        {
            Caption = 'UserCode';
            DataClassification = ToBeClassified;
        }
        field(2; StaffNo; Code[20])
        {
            Caption = 'StaffNo';
            DataClassification = ToBeClassified;
        }
        field(3; "Semester"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(4; ProgrammeCode; Code[20])
        {
            Caption = 'ProgrammeCode';
            DataClassification = ToBeClassified;
        }
        field(5; UnitCode; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Unit Name"; Text[150])
        {
            Caption = 'Unit Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("ACA-Units/Subjects".Desription where("code" = field(UnitCode)
, "Programme Code" = field(ProgrammeCode)));
        }

        field(7; "Program Name"; Text[200])
        {
            Caption = 'Program Name';
            FieldClass = FlowField;
            CalcFormula = lookup("ACA-Programme".Description where("Code" = field(ProgrammeCode)));
            Editable = false;

        }
    }
    keys
    {
        key(PK; UserCode, StaffNo, ProgrammeCode, "Semester", UnitCode)
        {
            Clustered = true;
        }
    }
}
