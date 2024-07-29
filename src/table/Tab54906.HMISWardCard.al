table 54906 "HMIS Ward Card"
{
    //DrillDownPageID = 64502;
    //LookupPageID = 64502;

    fields
    {
        field(1; "Asset No"; Code[10])
        {
            TableRelation = "Fixed Asset"."No.";
        }
        field(2; Description; Text[100])
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

            trigger OnValidate()
            begin
                //"Cost per Room":="Cost Per Occupant";
            end;
        }
        field(6; Gender; Code[20])
        {
            TableRelation = "HMIS-Central Setup Values".Code WHERE("Setup Group" = FILTER('GENDER' | 'SEX'));
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
            CalcFormula = Count("HMIS Ward Ledger" WHERE("Ward No" = FIELD("Asset No")));
            FieldClass = FlowField;
        }
        field(14; "Total Vacant"; Integer)
        {
            CalcFormula = Count("HMIS Ward Ledger" WHERE("Ward No" = FIELD("Asset No")));
            //Status=FILTER(Vaccant)
            FieldClass = FlowField;
        }
        field(15; "Total Occupied"; Integer)
        {
            CalcFormula = Count("HMIS Ward Ledger" WHERE("Ward No" = FIELD("Asset No")));
            //Status=FILTER("Partially Occupied")
            FieldClass = FlowField;
        }
        field(16; "Total Out of Order"; Integer)
        {
            /* CalcFormula = Count("HMIS Ward Ledger" WHERE (Ward No=FIELD(Asset No),
                                                          Status=FILTER(Fully Occupied)));
            FieldClass = FlowField; */
        }
        field(17; "Ward Type"; Option)
        {
            OptionMembers = Internal,"Out Sourced";
        }
        field(18; "Provider Code"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(50000; "Campus Code"; Code[20])
        {
            // TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1));
        }
        field(50001; Vaccant; Integer)
        {
            /* CalcFormula = Count("HMIS Ward Block Rooms" WHERE (Ward Code=FIELD(Asset No),
                                                               Status=FILTER(Vaccant)));
            FieldClass = FlowField; */
        }
        field(50002; "Fully Occupied"; Integer)
        {
            /*  CalcFormula = Count("HMIS Ward Block Rooms" WHERE (Ward Code=FIELD(Asset No),
                                                                Status=FILTER(Fully Occupied)));
             FieldClass = FlowField; */
        }
        field(50003; Blacklisted; Integer)
        {
            /*  CalcFormula = Count("HMIS Ward Block Rooms" WHERE (Ward Code=FIELD(Asset No),
                                                                Status=FILTER(Black-Listed)));
             FieldClass = FlowField; */
        }
        field(50004; "Partially Occupied"; Integer)
        {
            /* CalcFormula = Count("HMIS Ward Block Rooms" WHERE (Ward Code=FIELD(Asset No),
                                                               Status=FILTER(Partially Occupied)));
            FieldClass = FlowField; */
        }
        field(50008; "Rooms Generated"; Integer)
        {
            /* CalcFormula = Count("HMIS Ward Block Rooms" WHERE (Ward Code=FIELD(Asset No)));
            FieldClass = FlowField; */
        }
        field(50009; "Room Spaces"; Integer)
        {
            /*  CalcFormula = Count("HMIS Room Spaces" WHERE (Ward Code=FIELD(Asset No),
                                                           Status=FILTER(<>Black-Listed)));
             FieldClass = FlowField; */
        }
        field(50010; "Vaccant Spaces"; Integer)
        {
            /* CalcFormula = Count("HMIS Room Spaces" WHERE (Ward Code=FIELD(Asset No),
                                                          Status=FILTER(Vaccant)));
            FieldClass = FlowField; */
        }
        field(50011; "Occupied Spaces"; Integer)
        {
            /*   CalcFormula = Count("HMIS Room Spaces" WHERE (Ward Code=FIELD(Asset No),
                                                            Status=FILTER(Fully Occupied)));
              FieldClass = FlowField; */
        }
        field(50012; "Room Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Asset No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        rmsLedger.RESET;
        rmsLedger.SETRANGE(rmsLedger."Ward No", "Asset No");
        IF rmsLedger.FIND('-') THEN BEGIN
            ERROR('Allocations exists for this Ward Block. Clear the rooms/spaces first.');
        END;

        rooms.RESET;
        rooms.SETRANGE(rooms."Ward Code", "Asset No");
        IF rooms.FIND('-') THEN BEGIN
            rooms.DELETEALL;
        END;

        rmspcs.RESET;
        rmspcs.SETRANGE(rmspcs."Ward Code", "Asset No");
        IF rmspcs.FIND('-') THEN BEGIN
            rmspcs.DELETEALL;
        END;

        rmsLedger.RESET;
        rmsLedger.SETRANGE(rmsLedger."Ward No", "Asset No");
        IF rmsLedger.FIND('-') THEN BEGIN
            rmsLedger.DELETEALL;
        END;
    end;

    var
        rooms: Record "HMIS Ward Block Rooms";
        rmspcs: Record "HMIS Room Spaces";
        rmsLedger: Record "HMIS Ward Ledger";

    local procedure validateCosts()
    begin
        rooms.RESET;
        rooms.SETRANGE(rooms."Ward Code", "Asset No");
        IF rooms.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                rooms.VALIDATE(rooms."Room Code");
            END;
            UNTIL rooms.NEXT = 0;
        END;
    end;
}

