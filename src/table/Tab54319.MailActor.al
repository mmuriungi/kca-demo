table 54319 "Mail Actor"
{
    Caption = 'Mail Actor';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Actor ID"; Code[20])
        {
            Caption = 'Actor ID';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C";

            trigger OnValidate()
            var
                Actor: Record "HRM-Employee C";
            begin
                Actor.Reset();
                Actor.SetRange("No.", "Actor ID");
                if Actor.Find('-') then begin
                    "Actor Name" := Actor."First Name" + ' ' + Actor."Last Name";
                    EMail := Actor."E-Mail";
                    "Phone No." := Actor."Home Phone Number";
                end;
            end;
        }
        field(2; "Actor Name"; Text[300])
        {
            Caption = 'Actor Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; EMail; Text[100])
        {
            Caption = 'EMail';
            DataClassification = ToBeClassified;
        }
        field(4; "Phone No."; Code[15])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
        }
        field(5; Comment; Text[500])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.Reset();
                Rec.SetRange("Actor ID", Rec."Actor ID");
                if Rec.Find('-') then begin
                    if xRec.Comment <> Rec.Comment then
                        Rec.Acted := true;
                end;
            end;
        }
        field(6; Acted; Boolean)
        {
            Caption = 'Acted';
            DataClassification = ToBeClassified;
        }
        field(7; "Mail Code"; Code[20])
        {
            Caption = 'Mail Code';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Actor ID", "Mail Code")
        {
            Clustered = true;
        }
    }
}
