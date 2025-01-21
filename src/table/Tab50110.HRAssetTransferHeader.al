table 50110 "HR Asset Transfer Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Document Date"; Date)
        {
        }
        field(5; "Issuing Admin/Asst"; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin

                hremployee.RESET;
                IF hremployee.GET("Issuing Admin/Asst") THEN BEGIN
                    "Issuing Admin/Asst Name" := hremployee."First Name" + ' ' + hremployee."Last Name";
                END ELSE BEGIN
                    "Issuing Admin/Asst Name" := '';

                END;
            end;
        }
        field(6; "Issuing Admin/Asst Name"; Text[50])
        {
        }
        field(7; "Document Type"; Option)
        {
            OptionCaption = 'Asset Transfer';
            OptionMembers = "Asset Transfer";
        }
        field(8; "Currency Code"; Code[10])
        {
        }
        field(9; "No. Series"; Code[10])
        {
        }
        field(10; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Approved,Canceled;
        }
        field(11; Transfered; Boolean)
        {
        }
        field(12; "Date Transfered"; Date)
        {
        }
        field(13; "Transfered By"; Code[20])
        {
        }
        field(14; "Time Posted"; Time)
        {
        }
        field(50000; "User ID"; Code[50])
        {
        }
        field(50001; "Responsibility Center"; Code[50])
        {
        }
        field(50002; "Asset No"; Code[20])
        {
            CalcFormula = Lookup("HR Asset Transfer Lines"."Asset No." WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50003; Location; Code[50])
        {
            CalcFormula = Lookup("HR Asset Transfer Lines"."New Asset Location" WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50004; Cleared; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Date Cleared"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Cleared by"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "New Holder"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Current Holder"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Asset to Transfer"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Raised by"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Asset Description"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Time Transferred"; time)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Serial No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Leave Application Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    var
        fasetup: Record "FA Setup";
        hremployee: Record "HRM-Employee C";
        fasset: Record "Fixed Asset";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimValue: Record "Dimension Value";
        HRSetup: Record "HRM-Setup";
        "No series": Record 308;
}

