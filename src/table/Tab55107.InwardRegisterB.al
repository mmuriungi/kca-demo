table 55107 "Inward Register B"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Date Received"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "From Whom"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Ref No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "File Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Subject; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "File Index"; Code[50])
        {
            TableRelation = "REG-Files"."File Index";
            trigger OnValidate()
            var
                RF: Record "REG-Files";
            begin
                RF.SetRange("File Index", "File Index");
                if RF.Find('-') then begin
                    "File Name" := RF."File Name";
                end;
            end;
        }
        field(8; "File Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "No Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "User"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Date Created"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Region; Code[20])
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

        field(21; "Region Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD(Region)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.", Region)
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
            NoSeriesMgt.InitSeries('INREG', xRec."No Series", 0D, "Code", "No Series");
        END;
        "User" := USERID;
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