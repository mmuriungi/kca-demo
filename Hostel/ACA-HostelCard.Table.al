#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 61162 "ACA-Hostel Card"
{
    DrillDownPageID = "ACA-Hostel List1";
    LookupPageID = "ACA-Hostel List1";

    fields
    {
        field(1; "Asset No"; Code[10])
        {
            TableRelation = "Fixed Asset"."No.";
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Total Rooms"; Integer)
        {
        }
        field(4; "Space Per Room"; Integer)
        {
        }
        field(5; "Cost Per Occupant"; Decimal)
        {
        }
        field(6; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(7; Location; Code[20])
        {
        }
        field(8; Programme; Code[20])
        {
        }
        field(9; "Cost per Room"; Decimal)
        {
        }
        field(10; "Room Prefix"; Code[10])
        {
        }
        field(11; "Minimum Balance"; Decimal)
        {
        }
        field(12; "Starting No"; Integer)
        {
            InitValue = 1;
        }
        field(13; "Total Rooms Created"; Integer)
        {
            CalcFormula = count("ACA-Hostel Ledger" where("Hostel No" = field("Asset No")));
            FieldClass = FlowField;
        }
        field(14; "Total Vacant"; Integer)
        {
            CalcFormula = count("ACA-Hostel Ledger" where("Hostel No" = field("Asset No"),
                                                           Status = filter(Vaccant)));
            FieldClass = FlowField;
        }
        field(15; "Total Occupied"; Integer)
        {
            CalcFormula = count("ACA-Hostel Ledger" where("Hostel No" = field("Asset No"),
                                                           Status = filter("Partially Occupied")));
            FieldClass = FlowField;
        }
        field(16; "Total Out of Order"; Integer)
        {
            CalcFormula = count("ACA-Hostel Ledger" where("Hostel No" = field("Asset No"),
                                                           Status = filter("Fully Occupied")));
            FieldClass = FlowField;
        }
        field(17; "Hostel Type"; Option)
        {
            OptionMembers = Internal,"Out Sourced";
        }
        field(18; "Provider Code"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(50000; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50001; Vaccant; Integer)
        {
            CalcFormula = count("ACA-Hostel Block Rooms" where("Hostel Code" = field("Asset No"),
                                                                Status = filter(Vaccant)));
            FieldClass = FlowField;
        }
        field(50002; "Fully Occupied"; Integer)
        {
            CalcFormula = count("ACA-Hostel Block Rooms" where("Hostel Code" = field("Asset No"),
                                                                Status = filter("Fully Occupied")));
            FieldClass = FlowField;
        }
        field(50003; Blacklisted; Integer)
        {
            CalcFormula = count("Fixed Asset" where("No." = field("Asset No"),
                                                     Blocked = filter(true)));
            FieldClass = FlowField;
        }
        field(50004; "Partially Occupied"; Integer)
        {
            CalcFormula = count("ACA-Hostel Block Rooms" where("Hostel Code" = field("Asset No"),
                                                                Status = filter("Partially Occupied")));
            FieldClass = FlowField;
        }
        field(50005; "JAB Fees"; Decimal)
        {

            trigger OnValidate()
            begin
                validateCosts();
            end;
        }
        field(50006; "SSP Fees"; Decimal)
        {

            trigger OnValidate()
            begin
                validateCosts();
            end;
        }
        field(50007; "Special Programme"; Decimal)
        {

            trigger OnValidate()
            begin
                validateCosts();
            end;
        }
        field(50008; "Rooms Generated"; Integer)
        {
            CalcFormula = count("ACA-Hostel Block Rooms" where("Hostel Code" = field("Asset No")));
            FieldClass = FlowField;
        }
        field(50009; "Room Spaces"; Integer)
        {
            CalcFormula = count("ACA-Room Spaces" where("Hostel Code" = field("Asset No"),
                                                         Status = filter(<> "Black-Listed")));
            FieldClass = FlowField;
        }
        field(50010; "Vaccant Spaces"; Integer)
        {
            CalcFormula = count("ACA-Room Spaces" where("Hostel Code" = field("Asset No"),
                                                         Status = filter(Vaccant)));
            FieldClass = FlowField;
        }
        field(50011; "Occupied Spaces"; Integer)
        {
            CalcFormula = count("ACA-Room Spaces" where("Hostel Code" = field("Asset No"),
                                                         Status = filter("Fully Occupied")));
            FieldClass = FlowField;
        }
        field(50012; "View Online"; Boolean)
        {
        }
        field(50013; "Asignment Sequence"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Asset No", Gender)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ACAHostelPermissions.PermissionMan(UserId, 7);

        rmsLedger.Reset;
        rmsLedger.SetRange(rmsLedger."Hostel No", "Asset No");
        if rmsLedger.Find('-') then begin
            Error('Allocations exists for this Hostel Block. Clear the rooms/spaces first.');
        end;

        rooms.Reset;
        rooms.SetRange(rooms."Hostel Code", "Asset No");
        if rooms.Find('-') then begin
            rooms.DeleteAll;
        end;

        rmspcs.Reset;
        rmspcs.SetRange(rmspcs."Hostel Code", "Asset No");
        if rmspcs.Find('-') then begin
            rmspcs.DeleteAll;
        end;

        rmsLedger.Reset;
        rmsLedger.SetRange(rmsLedger."Hostel No", "Asset No");
        if rmsLedger.Find('-') then begin
            rmsLedger.DeleteAll;
        end;
    end;

    trigger OnInsert()
    begin
        ACAHostelPermissions.PermissionMan(UserId, 7);
    end;

    trigger OnModify()
    begin
        ACAHostelPermissions.PermissionMan(UserId, 7);
    end;

    var
        rooms: Record "ACA-Hostel Block Rooms";
        rmspcs: Record UnknownRecord61824;
        rmsLedger: Record "ACA-Hostel Ledger";
        ACAHostelPermissions: Record "ACA-Hostel Permissions";

    local procedure validateCosts()
    begin
        rooms.Reset;
        rooms.SetRange(rooms."Hostel Code", "Asset No");
        if rooms.Find('-') then begin
            repeat
            begin
                rooms.Validate(rooms."Room Code");
            end;
            until rooms.Next = 0;
        end;
    end;
}

