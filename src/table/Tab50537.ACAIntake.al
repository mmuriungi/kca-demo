table 50537 "ACA-Intake"
{
    LookupPageID = "ACA-Intake List";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; Current; Boolean)
        {
        }
        field(4; "Reporting Date"; Date)
        {
        }
        field(5; "Reporting End Date"; Date)
        {
        }
        field(8; lost; Code[20])
        {
        }
        field(9; "Faculty"; text[100])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = filter('FACULTY|SCHOOL'));
        }
    }

    keys
    {
        key(Key1; "Code", Faculty)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // CReg.RESET;
        // CReg.SETRANGE(CReg.Semester, Code);
        // IF CReg.FIND('-') THEN ERROR('Please note that you can not edit used Intake');
    end;

    trigger OnRename()
    begin
        // IF xRec.Code <> Code THEN BEGIN
        //     CReg.RESET;
        //     CReg.SETRANGE(CReg.Semester, xRec.Code);
        //     IF CReg.FIND('-') THEN ERROR('Please note that you can not edit used Intake');
        // END;
    end;

    var
        CReg: Record "ACA-Course Registration";
}

