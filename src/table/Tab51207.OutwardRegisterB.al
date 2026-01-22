table 51207 "Outward Register B"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "From File Index"; Code[50])
        {
            TableRelation = "REG-Files"."File Index";
            trigger OnValidate()
            var
                RF: Record "REG-Files";
            begin
                RF.SetRange("File Index", "From File Index");
                if RF.Find('-') then begin
                    "From File Name" := RF."File Name";
                end;
            end;
        }
        field(3; "From File Name"; Text[150])
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
                RF.SetRange("File Index", "From File Index");
                if RF.Find('-') then begin
                    "From File Name" := RF."File Name";
                end;
            end;
        }
        field(8; "File Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Date Sent"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "To Who"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Code"; Code[30])
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
        key(Key1; No, Region)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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