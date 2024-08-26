table 51204 "REG-Files"
{
    LookupPageId = "REG-Files List";
    DrillDownPageId = "REG-Files List";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;

        }
        field(2; "File No."; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "File Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Section Number"; Text[50])
        {
            TableRelation = Sections.Number;
            trigger OnValidate()
            var
                Sections: Record Sections;
                findex: code[100];
            begin
                TestField("File No.");
                Sections.SetRange(Number, "Section Number");
                if Sections.Find('-') then begin
                    "Section Name" := Sections."Section Name";
                    Abbreviation := Sections.Abbreviation;
                    findex := 'TMU/REG/' + Rec.Abbreviation + '/' + "Section Number" + '/' + "File No.";
                    Rec.Rename(Rec."No.", Rec."File No.", findex)
                end;
            end;
        }
        field(5; "Section Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Abbreviation; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Period"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        /* field(13; Version; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Volume';
        } */
        field(8; "File Index"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            OptionMembers = Open,Closed,Archived;
        }
        field(11; "Current Location"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Created By"; code[50])
        {
            DataClassification = ToBeClassified;
        }



    }


    keys
    {
        key(Key1; "No.", "File No.", "File Index")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        "Created By" := USERID;
        "File Index" := 'Yet To Update';
    end;

    trigger OnModify()
    var
        Sections: Record Sections;
        findex: code[100];
    begin
        /* if (Rec."File Index" <> '') AND (Rec."Section Number" <> '') AND (Rec."File No." <> '') then begin
            Sections.SetRange(Number, "Section Number");
            if Sections.Find('-') then begin
                "Section Name" := Sections."Section Name";
                Abbreviation := Sections.Abbreviation;
                findex := 'TMUC/' + Rec.Abbreviation + '/' + "Section Number" + '/' + "File No.";
                Rec.Rename(rec."No.", Rec."File No.", Rec."File Name", findex, Rec.Region, Rec."Version")
            end;
        end */
        ;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    var
        Sections: Record Sections;
    begin
        /*  if (Rec."File Index" <> '') AND (Rec."Section Number" <> '') AND (Rec."File No." <> '') then begin
             Sections.SetRange(Number, "Section Number");
             if Sections.Find('-') then begin
                 "Section Name" := Sections."Section Name";
                 Abbreviation := Sections.Abbreviation;
                 "File Index" := 'TMUC/' + Rec.Abbreviation + '/' + "Section Number" + '/' + "File No.";
             end;
         end; */
    end;

    procedure "GetLastEntryNo"(): Integer;
    var
        Entry: Record "REG-File Movement";
    begin
        Entry.Reset();
        if Entry.FindLast() then
            exit(Entry."No.")
        else
            exit(0);
    end;

    procedure updateRec()
    var
        RegFile: Record "REG-Files";
        Counter: Integer;
        No: Integer;
        fileNo: Text[10];
        fileName: Text[150];
        fileIndex: Code[20];
    begin

        IF NOT DIALOG.CONFIRM('You are about to update Index files, continue?', TRUE) THEN
            exit;
        RegFile.Reset;
        //Rec.SetRange("No.", Rec."No.");
        if RegFile.FindSet() then
            repeat
                //if RegFile."File Index" = '' then begin
                if (Rec."File Index" = '') then
                    if (Rec."Section Number" <> '') then
                        if (Rec."File No." <> '') then begin
                            No := Rec."No.";
                            fileNo := Rec."File No.";
                            fileName := Rec."File Name";
                            fileIndex := 'KEFRI/' + Rec.Abbreviation + '/' + Rec."Section Number" + '/' + Rec."File No.";
                            Rec.Rename(No, fileNo, fileName, fileIndex);
                        end;
                // end;
                Counter += 1;
            until RegFile.Next = 0;
        Message('Total Count updated: %1', Counter);

    end;
}