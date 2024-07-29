table 54217 "Asset Repair Lines"
{

    fields
    {
        field(1; "Request No."; Code[20])
        {
            TableRelation = "Asset Repair Header"."Request No.";
        }
        field(5; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Fixed Asset No."; Code[20])
        {
            TableRelation = "Fixed Asset"."No."; //WHERE ("Type"=FIELD("Asset Type"));

            trigger OnValidate()
            begin
                FA.RESET;
                IF FA.GET("Fixed Asset No.") THEN BEGIN
                    Description := FA.Description;
                    Location := FA."FA Location Code";
                    "Serial No." := FA."Serial No.";
                    "FA Class Code" := FA."FA Subclass Code";
                END
                ELSE BEGIN
                    Description := ' ';
                    Location := ' ';
                    "Serial No." := ' ';
                END;
                /*
                //Check if exists
                AssetRepairLines.SETRANGE(AssetRepairLines."Request No.","Request No.");
                AssetRepairLines.SETRANGE(AssetRepairLines."Fixed Asset No.","Fixed Asset No.");
                IF AssetRepairLines.FIND('-') THEN ERROR('Asset No [ %1 ] already exists',"Fixed Asset No.");
                */

            end;
        }
        field(15; Description; Text[50])
        {
            Editable = false;
        }
        field(20; Location; Code[20])
        {
            Editable = false;
            TableRelation = "FA Location";
        }
        field(25; "Serial No."; Text[30])
        {
            Editable = false;
        }
        field(30; "Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(35; "Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(40; "Repair Date"; Date)
        {
        }
        field(45; Cost; Decimal)
        {
        }
        field(46; "Asset Type"; Option)
        {
            Editable = false;
            OptionMembers = " ",Vehicles,"Other Assets";
        }
        field(47; "FA Class Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Request No.", "Asset Type", "Fixed Asset No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FA: Record 5600;
        AssetRepairLines: Record "Asset Repair Lines";
}

