table 54208 "Asset Repair Header"
{
    DrillDownPageID = "Asset Repair Card  Others";
    LookupPageID = "Asset Repair Card  Others";

    fields
    {
        field(1; "Request No."; Code[20])
        {
            Editable = false;
        }
        field(5; Description; Text[100])
        {
        }
        field(10; "Requested By"; Code[30])
        {
        }
        field(15; "Request Date"; Date)
        {
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(25; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(30; Status; Option)
        {
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted,Cancelled;
        }
        field(40; Comments; Text[100])
        {
        }
        field(45; "No. Series"; Code[10])
        {
        }
        field(50; "Total Cost"; Decimal)
        {
            CalcFormula = Sum("Asset Repair Lines".Cost WHERE("Request No." = FIELD("Request No.")));
            FieldClass = FlowField;
        }
        field(55; "Incident No."; Code[20])
        {
            TableRelation = "Asset Incident"."Incident No.";

            trigger OnValidate()
            begin

                AssetInciLines.RESET;
                AssetInciLines.SETRANGE(AssetInciLines."Incident No.", "Incident No.");
                IF AssetInciLines.FINDSET THEN BEGIN

                    //Remove Existing Maintenance Lines
                    AssetRepReqLines.RESET;
                    AssetRepReqLines.SETRANGE(AssetRepReqLines."Request No.", "Request No.");
                    IF AssetRepReqLines.FINDSET THEN AssetRepReqLines.DELETEALL;

                                                   REPEAT
                                                       AssetRepReqLines.RESET;
                                                       AssetRepReqLines.INIT;
                                                       AssetRepReqLines."Request No." := "Request No.";
                                                       AssetRepReqLines."Line No." := 0;
                                                       AssetRepReqLines."Fixed Asset No." := AssetInciLines."Fixed Asset No.";
                                                       AssetRepReqLines.VALIDATE(AssetRepReqLines."Fixed Asset No.");
                                                       // AssetRepReqLines."Dimension 1 Code" := AssetInciLines."Dimension 1 Code";
                                                       // AssetRepReqLines."Dimension 2 Code" := AssetInciLines."Dimension 2 Code";
                                                       AssetRepReqLines.INSERT(TRUE);
                                                   UNTIL AssetInciLines.NEXT = 0;

                END
                ELSE
                    ERROR(Txt001, "Incident No.");
            end;
        }
        field(56; "Asset Type"; Option)
        {
            Editable = false;
            OptionMembers = " ",Vehicles,"Other Assets";

            trigger OnValidate()
            begin
                /*
                //DW: Preventing Changing Asset Type When Asset Lines exits
                fn_TestNoLinesExist(FIELDCAPTION("Asset Type"));
                */

            end;
        }
        field(57; "Document Date"; Date)
        {
            Editable = false;
        }
        field(58; "Total Assets"; Integer)
        {
            CalcFormula = Count("Asset Repair Lines" WHERE("Request No." = FIELD("Request No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "FA Subclass"; Text[30])
        {
        }
        field(61; "Asset Description"; Text[100])
        {

        }
        field(62; "From Location"; Text[200])
        {
            TableRelation = "FA Location".Name;
        }
        field(60; "Asset to Transfer"; Code[30])
        {
            TableRelation = "Fixed Asset"."No.";
        }
        field(63; "From Responsible Employee"; Code[30])
        {
            TableRelation = "HRM-Employee C"."No.";
        }


        field(50000; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center"; //WHERE (Grouping=FILTER(ADMIN));
        }
        field(50002; "Asset to Repair"; Code[20])
        {

            trigger OnValidate()
            begin
                FA.RESET;
                FA.SETRANGE(FA."No.", "Asset to Transfer");
                IF FA.FIND('-') THEN BEGIN
                    "Asset Description" := FA.Description;
                    "From Location" := FA."FA Location Code";
                    "From Responsible Employee" := FA."Responsible Employee";

                    VALIDATE("From Responsible Employee");
                END ELSE BEGIN
                    "Asset Description" := ' ';
                    "From Location" := ' ';
                    "From Responsible Employee" := ' ';
                    VALIDATE("From Responsible Employee");
                END;

                items.RESET;
                items.SETRANGE(items."No.", "Asset to Transfer");
                IF items.FIND('-') THEN BEGIN
                    "Asset Description" := items.Description;
                END ELSE BEGIN
                    "Asset Description" := '';
                END;


            end;
        }
    }

    keys
    {
        key(Key1; "Request No.", "Asset Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Request No." = '' THEN BEGIN
            FASetup.GET;
            FASetup.TESTFIELD("Repair Request Nos.");
            NoSeriesMgt.InitSeries(FASetup."Repair Request Nos.", xRec."No. Series", 0D, "Request No.", "No. Series");
        END;

        "Requested By" := USERID;
        "Request Date" := TODAY;
        "Document Date" := TODAY;
        "Global Dimension 1 Code" := 'HQ';
        "Global Dimension 2 Code" := 'FIN_ADM';
    end;

    var
        FASetup: Record "FLT-Fleet Mgt Setup";
        FA: Record 5600;
        items: Record 27;
        NoSeriesMgt: Codeunit 396;
        AssetInciLines: Record "Asset Incident Lines";
        Txt001: Label 'There are no Asset Incident Lines for Incident No. %1';
        AssetRepReqLines: Record "Asset Repair Lines";

    local procedure fn_TestNoLinesExist(FieldCaption: Text)
    var
        AssetRepairLine: Record "Asset Repair Lines";
        Confirmed: Boolean;
        Text004: Label 'Do you want to change %1?';
        Text005: Label 'You cannot change [ %1 ] because the document still has one or more lines.';
    begin
        AssetRepairLine.SETRANGE(AssetRepairLine."Request No.", "Request No.");
        IF NOT AssetRepairLine.ISEMPTY THEN ERROR(Text005, FieldCaption);
    end;
}

