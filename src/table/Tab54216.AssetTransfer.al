table 54216 "Asset Transfer"
{
    DrillDownPageID = "Asset Transfer List";
    LookupPageID = "Asset Transfer List";

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                IF "No." <> xRec."No." THEN BEGIN
                    FASetup.GET;
                    //NoSeriesMgt.TestManual(FASetup."Asset Transfer Nos.");
                    "No. Series" := ' ';
                END;
            end;
        }
        field(5; "Raised By"; Code[50])
        {
            Editable = false;
        }
        field(10; "Asset to Transfer"; Code[20])
        {
            TableRelation = IF (Type = CONST(" ")) "Fixed Asset"."No."
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin
                IF Type = Type::"Fixed Asset" THEN
                    FA.RESET;
                FA.SETRANGE(FA."No.", "Asset to Transfer");
                IF FA.FIND('-') THEN BEGIN
                    "Asset Description" := FA.Description;
                    "From Location" := FA."FA Location Code";
                    "From Responsible Employee" := FA."Responsible Employee";
                END;

                IF Type = Type::Item THEN
                    items.RESET;
                items.SETRANGE(items."No.", "Asset to Transfer");
                IF items.FIND('-') THEN BEGIN
                    "Asset Description" := items.Description;
                END;
            end;
        }
        field(15; "Asset Description"; Text[50])
        {
        }
        field(20; "From Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.", 1);
                DimVal.SETRANGE(DimVal.Code, "From Dimension 1 Code");
                IF DimVal.FIND('-') THEN
                    "From Dimension 1 Description" := DimVal.Name
                ELSE
                    "From Dimension 1 Description" := ' ';
            end;
        }
        field(25; "From Dimension 1 Description"; Text[50])
        {
        }
        field(30; "From Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.", 2);
                DimVal.SETRANGE(DimVal.Code, "From Dimension 2 Code");
                IF DimVal.FIND('-') THEN
                    "From Dimension 2 Description" := DimVal.Name
                ELSE
                    "From Dimension 2 Description" := ' ';
            end;
        }
        field(35; "From Dimension 2 Description"; Text[50])
        {
        }
        field(40; "From Location"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(45; "From Responsible Employee"; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                CLEAR(Employees);
                Employees.SETRANGE(Employees."No.", "From Responsible Employee");
                IF Employees.FIND('-') THEN
                    "From Employee Name" := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name"
                ELSE
                    "From Employee Name" := ' ';
            end;
        }
        field(50; "From Employee Name"; Text[100])
        {
        }
        field(55; "To Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.", 1);
                DimVal.SETRANGE(DimVal.Code, "To Dimension 1 Code");
                IF DimVal.FIND('-') THEN
                    "To Dimension 1 Description" := DimVal.Name
                ELSE
                    "To Dimension 1 Description" := ' ';
            end;
        }
        field(60; "To Dimension 1 Description"; Text[50])
        {
        }
        field(65; "To Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.", 2);
                DimVal.SETRANGE(DimVal.Code, "To Dimension 2 Code");
                IF DimVal.FIND('-') THEN
                    "To Dimension 2 Description" := DimVal.Name
                ELSE
                    "To Dimension 2 Description" := ' ';
            end;
        }
        field(70; "To Dimension 2 Description"; Text[50])
        {
        }
        field(75; "To Location"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(80; "To Responsible Employee"; Code[20])
        {
            TableRelation = "HRM-Employee C";

            trigger OnValidate()
            begin
                CLEAR(Employees);
                Employees.SETRANGE(Employees."No.", "To Responsible Employee");
                IF Employees.FIND('-') THEN
                    "To Employee Name" := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name"
                ELSE
                    "To Employee Name" := ' ';
            end;
        }
        field(85; "To Employee Name"; Text[100])
        {
        }
        field(90; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(95; Transferred; Boolean)
        {
            Editable = false;
        }
        field(100; Comments; Text[100])
        {
        }
        field(105; "No. Series"; Code[20])
        {
        }
        field(106; "Transfer Type"; Option)
        {
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(50000; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            //TableRelation = "FIN-Responsibility Center BR"; //WHERE (Grouping=FILTER(ADMIN));
        }
        field(50001; "Serial No."; Code[20])
        {
        }
        field(50002; Type; Option)
        {
            OptionCaption = ' ,Item,Fixed Asset';
            OptionMembers = " ",Item,"Fixed Asset";
        }
        field(50003; "Destination/Location"; Text[250])
        {
        }
        field(50004; Date; Date)
        {
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
            FASetup.GET;
            /* FASetup.TESTFIELD("Asset Transfer Nos.");
            NoSeriesMgt.InitSeries(FASetup."Asset Transfer Nos.", xRec."No. Series", 0D, "No.", "No. Series"); */
        END;

        "Raised By" := USERID;
        Date := TODAY;
    end;

    var
        FA: Record 5600;
        DimVal: Record 349;
        Employees: Record "HRM-Employee C";
        FASetup: Record 5603;
        NoSeriesMgt: Codeunit 396;
        items: Record 27;
}

