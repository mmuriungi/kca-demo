table 51121 "HMS-Off Duty"
{

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
        }
        field(2; "Staff No"; Code[20])
        {
        }
        field(3; "Staff Name"; Text[30])
        {
            Caption = 'Name';
        }
        field(4; "Off Duty Start Date"; Date)
        {
        }
        field(5; "Contact person"; Text[30])
        {
            FieldClass = Normal;
        }
        field(6; "Off Duty Reason Reason"; Text[250])
        {
        }
        field(7; "Referral Remarks"; Text[100])
        {
        }
        field(8; Status; Option)
        {
            FieldClass = Normal;
            OptionMembers = New,Referred,Released;
        }
        field(9; "No of days"; Decimal)
        {
        }
        field(10; "Patient No"; Code[10])
        {
        }
        field(11; "Certificate No."; Code[20])
        {
            Caption = 'Certificate No.';
            Editable = false;
        }
        field(12; "Certificate Date"; Date)
        {
            Caption = 'Certificate Date';
        }
        field(13; "PF No."; Code[20])
        {
            Caption = 'PF No.';
        }
        field(14; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(15; Department; Text[100])
        {
            Caption = 'Department';
        }
        field(16; "Sick Leave Duration"; Integer)
        {
            Caption = 'Sick Leave Duration (Days)';
        }
        field(17; "Duration Unit"; Option)
        {
            Caption = 'Duration Unit';
            OptionMembers = Days,Weeks;
            OptionCaption = 'Days,Weeks';
        }
        field(18; "Review Date"; Date)
        {
            Caption = 'Review Date';
        }
        field(19; "Chief Medical Officer"; Text[100])
        {
            Caption = 'Chief Medical Officer';
        }
        field(20; "Illness Description"; Text[250])
        {
            Caption = 'Illness Description';
        }
        field(21; Title; Option)
        {
            Caption = 'Title';
            OptionMembers = " ",Prof,Dr,Mr,Mrs,Miss;
            OptionCaption = ' ,Prof,Dr,Mr,Mrs,Miss';
        }
        field(22; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(23; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Certificate No.")
        {
            Clustered = true;
        }
        key(Key2; "Treatment No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HMSSetup: Record "HMS-Setup";
    begin
        if "Certificate No." = '' then begin
            HMSSetup.Get();
            HMSSetup.TestField("Sick Leave Cert. Nos.");
            NoSeriesMgt.InitSeries(HMSSetup."Sick Leave Cert. Nos.", xRec."Certificate No.", 0D, "Certificate No.", HMSSetup."Sick Leave Cert. Nos.");
        end;
        
        "Certificate Date" := Today;
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        if "Certificate No." = '' then
            Error('Certificate No. must have a value');
    end;
}

