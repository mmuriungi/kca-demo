#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 61823 "ACA-Hostel Block Rooms"
{
    DrillDownPageID = "ACA-Hostel Block Rooms Lst";
    LookupPageID = "ACA-Hostel Block Rooms Lst";

    fields
    {
        field(1; "Hostel Code"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No";
        }
        field(2; "Room Code"; Code[20])
        {

            trigger OnValidate()
            begin
                hostel.Reset;
                hostel.SetRange(hostel."Asset No", "Hostel Code");
                if hostel.Find('-') then begin
                    "JAB Fees" := hostel."JAB Fees";
                    "SSP Fees" := hostel."SSP Fees";
                    "Special Programme" := hostel."Special Programme";
                end;
            end;
        }
        field(3; "Bed Spaces"; Integer)
        {
            CalcFormula = count("ACA-Room Spaces" where("Hostel Code" = field("Hostel Code"),
                                                         "Room Code" = field("Room Code"),
                                                         Status = filter(<> "Black-Listed")));
            FieldClass = FlowField;
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Vaccant,Partially Occupied,Fully Occupied,Black-Listed,Partially Booked,Fully Booked,Out of Order,Over-Allocated';
            OptionMembers = Vaccant,"Partially Occupied","Fully Occupied","Black-Listed","Partially Booked","Fully Booked","Out of Order","Over-Allocated";

            trigger OnValidate()
            var
                ACARoomSpaces: Record "ACA-Room Spaces";
            begin
                ACARoomSpaces.Reset;
                ACARoomSpaces.SetRange("Hostel Code", Rec."Hostel Code");
                ACARoomSpaces.SetRange("Room Code", Rec."Room Code");
                if ACARoomSpaces.Find('-') then begin
                    repeat
                    begin
                        ACARoomSpaces.CalcFields("Current Student");
                        if ACARoomSpaces."Current Student" <> '' then begin
                            ACARoomSpaces.Status := ACARoomSpaces.Status::"Fully Occupied";
                            ACARoomSpaces.Modify;
                        end else begin
                            if ACARoomSpaces.Status <> ACARoomSpaces.Status::"Black-Listed" then begin
                                ACARoomSpaces.Status := ACARoomSpaces.Status::Vaccant;
                                ACARoomSpaces.Modify;
                            end;
                        end;
                    end;
                    until ACARoomSpaces.Next = 0;
                end;

                CalcFields("Bed Spaces", "Occupied Spaces");
                if "Occupied Spaces" = 0 then begin
                    Status := Status::Vaccant;
                    Modify;
                end else if "Occupied Spaces" < "Bed Spaces" then begin
                    Status := Status::"Partially Occupied";
                    Modify;
                end else if "Occupied Spaces" = "Bed Spaces" then begin
                    Status := Status::"Fully Occupied";
                    Modify;
                end else begin
                    Status := Status::"Over-Allocated";
                    Modify;
                end;
                // ELSE IF "Occupied Spaces">"Bed Spaces" THEN  ERROR('You can not allocate more than the available spaces!');
            end;
        }
        field(5; "Room Cost"; Decimal)
        {
        }
        field(14; "Reservation Remarks"; Text[100])
        {
        }
        field(15; "Reservation UserID"; Code[20])
        {
        }
        field(16; "Reservation Date"; Date)
        {
        }
        field(17; "Black List reason"; Text[30])
        {
        }
        field(18; "Occupied Spaces"; Integer)
        {
            CalcFormula = count("ACA-Hostel Ledger" where("Hostel No" = field("Hostel Code"),
                                                           "Room No" = field("Room Code"),
                                                           Status = filter("Fully Occupied")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /* CALCFIELDS("Bed Spaces","Occupied Spaces");
                  IF "Occupied Spaces"=0 THEN BEGIN
                  Status:=Status::Vaccant;
                  MODIFY;
                 END ELSE  IF "Occupied Spaces"<"Bed Spaces" THEN BEGIN
                  Status:=Status::"Partially Occupied";
                  MODIFY;
                  END ELSE IF "Occupied Spaces"="Bed Spaces" THEN BEGIN
                  Status:=Status::"Fully Occupied";
                  MODIFY;
                 END ELSE IF "Occupied Spaces">"Bed Spaces" THEN  ERROR('You can not allocate more than the available spaces!'); */

            end;
        }
        field(50005; "JAB Fees"; Decimal)
        {
        }
        field(50006; "SSP Fees"; Decimal)
        {
        }
        field(50007; "Special Programme"; Decimal)
        {
        }
        field(50008; "Total Spaces"; Integer)
        {
            CalcFormula = count("ACA-Room Spaces" where("Hostel Code" = field("Hostel Code"),
                                                         "Room Code" = field("Room Code"),
                                                         Status = filter(<> "Black-Listed")));
            FieldClass = FlowField;
        }
        field(50010; "Vacant Spaces"; Integer)
        {
            CalcFormula = count("ACA-Room Spaces" where("Hostel Code" = field("Hostel Code"),
                                                         "Room Code" = field("Room Code"),
                                                         Status = filter(Vaccant)));
            FieldClass = FlowField;
        }
        field(50011; Sequence; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Hostel Code", "Room Code")
        {
            Clustered = true;
        }
        key(Key2; Sequence, "Hostel Code", "Room Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ACAHostelPermissions.PermissionMan(UserId, 8);
        rmsLedger.Reset;
        //rmsLedger.SETRANGE(rmsLedger."Hostel No","Asset No");
        rmsLedger.SetRange(rmsLedger."Room No", "Room Code");
        if rmsLedger.Find('-') then begin
            Error('Allocations exists for this Room. Clear the room/spaces first.');
        end;

        roomspaces.Reset;
        roomspaces.SetRange(roomspaces."Room Code", "Room Code");
        roomspaces.SetFilter(roomspaces.Status, '<>%1', roomspaces.Status::Vaccant);
        if roomspaces.Find('-') then begin
            Error('There are some occupied spaces in the room');
        end;

        roomspaces.Reset;
        roomspaces.SetRange(roomspaces."Room Code", "Room Code");
        if roomspaces.Find('-') then begin
            roomspaces.DeleteAll;
        end;// error('There are some occupied spaces in the room');
    end;

    trigger OnInsert()
    begin
        ACAHostelPermissions.PermissionMan(UserId, 8);
    end;

    trigger OnModify()
    begin
        ACAHostelPermissions.PermissionMan(UserId, 8);
    end;

    var
        hostel: Record "ACA-Hostel Card";
        roomspaces: Record "ACA-Room Spaces";
        rmsLedger: Record "ACA-Hostel Ledger";
        ACAHostelPermissions: Record "ACA-Hostel Permissions";
}

