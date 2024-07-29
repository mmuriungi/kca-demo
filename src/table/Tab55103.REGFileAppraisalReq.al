table 55103 "REG-File Appraisal Req"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {

        }
        field(2; "Staff No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Full Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Region; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('REGIONS'));
            trigger OnValidate()
            var
                Dimval: Record "Dimension Value";
            begin
                if Dimval.Get(Region) then begin
                    "Region Name" := Dimval.Name;
                end;
            end;
        }

        field(5; "Region Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD(Region)));
        }
        field(6; Department; Code[100])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, "Department");
                IF DimVal.FIND('-') THEN
                    "Department Name" := DimVal.Name
            end;
        }

        field(7; "Department Name"; Text[250])
        {
        }
        field(8; "No Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "User Id"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Date Created"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Code, Region)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit 396;
    begin
        IF "Code" = '' THEN BEGIN
            NoSeriesMgt.InitSeries('FILEAPPRAISAL', xRec."No Series", 0D, "Code", "No Series");
        END;
        "User Id" := USERID;
        "Date Created" := CURRENTDATETIME;
    end;

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