table 54212 "Gate Pass"
{
    DrillDownPageID = "Gatepass List";
    LookupPageID = "Gatepass List";

    fields
    {
        field(1; "Gate Pass No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Date Out"; Date)
        {
        }
        field(3; "Time Out"; Time)
        {
        }
        field(4; "Asset Transfer No"; Code[10])
        {
            TableRelation = "Asset Transfer"."No." WHERE(Status = FILTER('Approved'));

            trigger OnValidate()
            begin
                "Date Out" := 0D;
                "Time Out" := 0T;
                "Asset No." := '';
                "Asset Description" := '';
                "Asset From Location" := '';
                "Asset To Location" := '';

                AssetTrans.RESET;
                AssetTrans.SETRANGE(AssetTrans."No.", "Asset Transfer No");
                IF AssetTrans.FIND('-') THEN BEGIN
                    "Date Out" := TODAY;
                    "Time Out" := TIME;
                    "Asset No." := AssetTrans."Asset to Transfer";
                    "Asset Description" := AssetTrans."Asset Description";
                    "Asset From Location" := AssetTrans."From Location";
                    "Asset To Location" := AssetTrans."To Location";

                END;
            end;
        }
        field(5; "Asset No."; Code[20])
        {
            Editable = false;
        }
        field(6; "Asset Description"; Text[100])
        {
            Editable = false;
        }
        field(7; "Asset From Location"; Code[30])
        {
            Editable = false;
        }
        field(8; "Asset To Location"; Code[30])
        {
            Editable = false;
        }
        field(9; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(10; "Date Created"; Date)
        {
            Editable = false;
        }
        field(11; "Created By"; Code[80])
        {
            Editable = false;
        }
        field(50000; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            //TableRelation = "FIN-Responsibility Center BR"; // WHERE(Grouping = FILTER(ADMIN));
        }
        field(50001; "Returned Status"; Boolean)
        {
        }
        field(50002; Comment; Text[250])
        {
        }
        field(50003; "To Be Returned"; Option)
        {
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(50004; "Employee No"; Code[20])
        {
            Editable = false;
            TableRelation = "HRM-Employee C";

            trigger OnValidate()
            begin
                CLEAR(HRemployee);
                HRemployee.SETRANGE(HRemployee."No.", "Employee No");
                IF HRemployee.FIND('-') THEN
                    "Employee Name" := HRemployee."Full Name";
            end;
        }
        field(50005; "Employee Name"; Text[100])
        {
        }
        field(50006; No; Code[20])
        {
        }
        field(50007; "No. Series"; Code[10])
        {
        }
        field(50008; "Serial No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
        key(Key2; "Gate Pass No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF No = '' THEN BEGIN
            HRSetup.GET;
            //HRSetup.TESTFIELD(HRSetup."Gate Pass No");
            //NoSeriesMgt.InitSeries(HRSetup."Gate Pass No", xRec."No. Series", 0D, No, "No. Series");
            NoSeriesMgt.InitSeries('GATEPASS', xRec."No. Series", 0D, No, "No. Series");
        END;

        "Date Created" := TODAY;
        "Created By" := USERID;

        CLEAR(HRemployee);
        HRemployee.SETRANGE(HRemployee."User ID", "Created By");
        IF HRemployee.FIND('-') THEN
            "Employee Name" := HRemployee."Full Name";
        "Employee No" := HRemployee."No.";
    end;

    var
        AssetTrans: Record "Asset Transfer";
        HRemployee: Record "HRM-Employee C";
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit 396;
}

