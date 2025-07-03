#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 61560 "ACA-Hostel Rooms"
{
    DrillDownPageID = UnknownPage67059;
    LookupPageID = UnknownPage67059;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
        }
        field(3; Capacity; Integer)
        {
        }
        field(4; Occupied; Integer)
        {
            CalcFormula = count("ACA-Std Charges" where("Room Allocation" = field(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Remarks; Text[200])
        {
        }
        field(6; Building; Code[20])
        {
        }
        field(7; Floor; Option)
        {
            OptionCaption = ' ,First,Second,Third,Fourth,Fifth,Sixth';
            OptionMembers = " ",First,Second,Third,Fourth,Fifth,Sixth;
        }
    }

    keys
    {
        key(Key1; Building, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        roomspaces.Reset;
        roomspaces.SetRange(roomspaces."Hostel Code", Building);
        roomspaces.SetRange(roomspaces."Room Code", Code);
        roomspaces.SetFilter(roomspaces."Student No", '<>%1', '');
        if roomspaces.Find('-') then begin
            Error('Clear the students from the rooms before deleting.');
        end;
        roomspaces.Reset;
        roomspaces.SetRange(roomspaces."Hostel Code", Building);
        roomspaces.SetRange(roomspaces."Room Code", Code);
        if roomspaces.Find('-') then DeleteAll;
    end;

    var
        roomspaces: Record UnknownRecord61824;
}

