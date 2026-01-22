table 52178546 "Proc Classification Requiremnt"
{
    DrillDownPageId = "Proc Classifctn Requirements";
    Caption = 'Proc Classification Requirements';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Editable = false;
            Caption = 'Line No';
        }
        field(2; "Code"; Code[50])
        {
            Editable = false;
            Caption = 'Code';
        }
        field(3; Description; Text[500])
        {
            Caption = 'Description';
        }
        field(4; Mandatory; Option)
        {
            Caption = 'Mandatory';
            OptionMembers = " ",Yes,No;
        }
        field(5; "Created By"; Code[50])
        {
            Editable = false;
            Caption = 'Created By';
        }
        field(6; "Date Created"; Date)
        {
            Editable = false;
            Caption = 'Date Created ';
        }
    }
    keys
    {
        key(PK; "Line No", "Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "Line No" = 0 then
            "Line No" := GetLastEntryNo() + 1;
        "Created By" := UserId;
        "Date Created" := Today;
    end;

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Line No")))
    end;
}
