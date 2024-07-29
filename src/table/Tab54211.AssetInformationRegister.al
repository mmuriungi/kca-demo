table 54211 "Asset Information Register"
{
    DrillDownPageID = "Asset Info Register List";
    LookupPageID = "Asset Info Register List";

    fields
    {
        field(1; "Asset No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Reg Code"; Code[50])
        {
            Caption = 'Reg No., Code, Chassis No., LR No, Serial No., Size in Sqr Feet';
            Description = 'Reg No., Code, Chassis No., LR No, Serial No., Size in Sqr Feet';

            trigger OnValidate()
            begin
                AssetInfoReg.RESET;
                AssetInfoReg.SETRANGE(AssetInfoReg."Reg Code", "Reg Code");
                IF AssetInfoReg.FIND('-') THEN ERROR('Reg Code [ %1 ] already exists');
            end;
        }
        field(3; "Asset Description"; Text[100])
        {
        }
        field(4; "Cost of Asset"; Decimal)
        {
        }
        field(5; "Date Acquired / Installed."; Date)
        {
        }
        field(6; "Asset Category"; Option)
        {
            OptionMembers = " ","Office Equipment";
        }
        field(7; "Repairs and Maintenance Cost"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Asset No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        AssetInfoReg: Record "Asset Information Register";
}

