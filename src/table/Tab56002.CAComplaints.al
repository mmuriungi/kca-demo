table 56002 "CA-Complaints"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;

        }
        field(2; Code; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(3; "Complaint Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Cost Center Code"; Code[100])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, "Cost Center Code");
                IF DimVal.FIND('-') THEN
                    "Department Name" := DimVal.Name
            end;
        }
        field(5; "Department Name"; Text[250])
        {
        }

        field(6; "Region Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, "Region Code");
                IF DimVal.FIND('-') THEN
                    "Region Name" := DimVal.Name
            end;

        }
        field(7; "Region Name"; Text[250])
        {
            // CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Region Code")));
            // FieldClass = FlowField;
        }
        field(8; "Complain Type"; Option)
        {
            OptionCaption = 'External,Internal';
            OptionMembers = External,"Internal";
        }
        field(9; "Staff No"; Code[30])
        {
            Caption = 'Staff No';
            TableRelation = "HRM-Employee (D)";
        }
        field(10; "Status"; Option)
        {
            OptionMembers = "","InCommittee","OutofCommittee";
        }
        field(14; "No. Series"; Code[30])
        {
            Description = 'Stores the number series in the database';
        }
    }

    keys
    {
        key(Key1; "No.", Code)
        {
            Clustered = true;
        }
    }


    var


    trigger OnInsert()
    begin
        IF Code = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Transport Req No");
            NoSeriesMgt.InitSeries(HRSetup."Transport Req No", xRec."No. Series", 0D, Code, "No. Series");
        END;


    end;

    var
        myInt: Integer;
        HRSetup: Record "FLT-Fleet Mgt Setup";
        NoSeriesMgt: Codeunit 396;


    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}