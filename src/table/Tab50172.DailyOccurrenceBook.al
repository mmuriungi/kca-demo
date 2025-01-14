// Table: Daily Occurrence Book (OB)
table 50172 "Daily Occurrence Book"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "OB No."; Code[20])
        {
            Editable = false;

        }
        field(3; "Date"; Date)
        {
        }
        field(4; "Time"; Time)
        {
        }
        field(5; "Description"; Text[250])
        {
        }
        field(6; "Recorded By"; Code[50])
        {
        }
    }

    keys
    {
        key(PK; "Entry No.", "OB No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        SecuritySetup: Record "Security Setup";
        NoSeriesMgnt: Codeunit NoSeriesManagement;
    begin
        if "OB No." = '' then begin
            SecuritySetup.Get();
            NoSeriesMgnt.InitSeries(SecuritySetup."Daily OB Nos", SecuritySetup."Daily OB Nos", WorkDate(), "OB No.", SecuritySetup."Daily OB Nos");
            "Date" := Today;
        end;
    end;
}
