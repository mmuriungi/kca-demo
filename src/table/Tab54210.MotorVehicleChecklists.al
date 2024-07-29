table 54210 "Motor Vehicle Checklists"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Vehicle Reg No."; Code[20])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";

            trigger OnValidate()
            begin
                CompanyVehicles.RESET;
                CompanyVehicles.SETRANGE(CompanyVehicles."Registration No.", "Vehicle Reg No.");
                IF CompanyVehicles.FIND('-') THEN
                    "Vehicle Name" := CompanyVehicles.Description;
            end;
        }
        field(3; Date; Date)
        {
        }
        field(4; "Type Of Vehicle"; Text[100])
        {
        }
        field(6; Item; Text[100])
        {
        }
        field(7; Contition; Option)
        {
            OptionCaption = ' ,Good ,Bad';
            OptionMembers = " ","Good ",Bad;
        }
        field(8; Remarks; Text[100])
        {
        }
        field(9; "Mileage Reading"; Integer)
        {
        }
        field(10; "Name Of Receiving Driver"; Text[20])
        {
        }
        field(11; "Name Of Handing Over Driver"; Text[50])
        {
        }
        field(12; "Admin officer"; Text[50])
        {
        }
        field(13; "Vehicle Name"; Text[50])
        {
        }
        field(105; "No. Series"; Code[20])
        {
        }
        field(5002; Departments; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Departments';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
                //MODIFY;
            end;
        }
        field(5005; Directorate; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(5006; Station; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50001; "Raised By"; Code[50])
        {
            Editable = false;
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

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            FASetup.GET;
            FASetup.TESTFIELD("Motor Vehicle Maintenance Nos.");
            NoSeriesMgt.InitSeries(FASetup."Motor Vehicle Maintenance Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;

        "Raised By" := USERID;
    end;

    var
        FA: Record 5600;
        FASetup: Record "FLT-Fleet Mgt Setup";
        NoSeriesMgt: Codeunit 396;
        CompanyVehicles: Record "FLT-Vehicle Header";
}

