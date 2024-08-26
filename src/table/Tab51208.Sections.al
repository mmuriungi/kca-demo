table 51208 "Sections"
{
    LookupPageId = "REG-Sections List";
    DrillDownPageId = "REG-Sections List";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;

        }
        field(2; "Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Section Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Abbreviation; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", Number)
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

    var
        secs: Record Sections;
        files: Record "REG-Files";

    procedure AddFile()
    begin
        secs.Reset();
        secs.SetRange("No.", Rec."No.");
        secs.SetRange(Number, Rec.Number);
        if secs.Find('-') then begin
            If Confirm('Add File ?', true) = false then Error('Cancelled');
            files.Init();
            files."File No." := 'File No.!';
            files."Section Number" := secs.Number;
            files."File Index" := 'Update Index';
            files.Abbreviation := secs.Abbreviation;
            files."Section Name" := secs."Section Name";
            files."No." := GetLastEntryNo() + 1;
            files."File Index" := 'TMU/REG/' + Rec.Abbreviation + '/' + secs.Number + '/' + format(files."No.");
            // files.Validate("Section Number");
            files.Insert();
            page.Run(Page::"REG-Files Card", files);

        end;

    end;

    procedure GetLastEntryNo(): Integer;
    var
        LedgerEntry: Record "REG-Files";
    begin
        LedgerEntry.Reset();
        if LedgerEntry.FindLast() then
            exit(LedgerEntry."No.")
        else
            exit(0);
    end;

}