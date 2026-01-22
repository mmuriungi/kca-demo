//was table 130417 "File Cabinet"
table 51198 "File Cabinet"
{

    fields
    {
        field(1; "File No."; Code[30])
        {
            TableRelation = "REG-Files"."File No.";
            trigger OnValidate()
            var
                REGF: Record "REG-Files";
            begin
                REGF.SetRange("File No.", "File No.");
                if REGF.Find('-') then begin
                    "File Subject" := REGF."File Name";
                    "File Name" := REGF."File Name";
                end;
            end;
        }
        field(9; "File Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Section Number"; Text[200])
        {
            TableRelation = Sections.Number;
            trigger OnValidate()
            var
                Sections: Record Sections;
            begin
                Sections.SetRange(Number, "Section Number");
                if Sections.Find('-') then begin
                    "Section Name" := Sections."Section Name";
                    "Abbrev" := Sections.Abbreviation;
                end;
            end;
        }
        field(8; "Section Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "File Subject"; Text[200])
        {
            trigger OnValidate()
            begin
                TestField("Section Number");
                TestField("Section Name");
                TestField("File No.");
                if ("File No." <> '') AND ("Section Number" <> '') AND (Abbrev <> '') then begin
                    "File Index" := 'KEFRI/' + '/' + Abbrev + '/' + "Section Number" + '/' + "File No.";
                end;
            end;
        }
        field(4; Department; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "File Index"; Text[100])
        {

        }
        field(6; "Status"; Option)
        {
            OptionMembers = Open,Closed,Archived;
        }
        field(7; Abbrev; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "File No.", "File Subject")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

