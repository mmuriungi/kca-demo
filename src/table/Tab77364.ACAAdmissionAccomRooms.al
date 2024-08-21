#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 77364 "ACA-Admission Accom. Rooms"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
        }
        field(2; "Space Code"; Code[20])
        {
        }
        field(3; "Room Code"; Code[20])
        {
        }
        field(4; "Block Code"; Code[20])
        {
        }
        field(5; "Allocation Status"; Option)
        {
            OptionCaption = 'Vaccant,Booked,Allocated';
            OptionMembers = Vaccant,Booked,Allocated;
        }
        field(6; "Student No."; Code[20])
        {
        }
        field(7; "Student Name"; Text[150])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Student No.")));
            FieldClass = FlowField;
        }
        field(8; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(9; "Hostel Exists"; Boolean)
        {
            CalcFormula = exist("ACA-Hostel Card" where("Asset No" = field("Block Code")));
            FieldClass = FlowField;
        }
        field(10; "Assignment Sequence"; Integer)
        {
            CalcFormula = lookup("ACA-Hostel Card"."Asignment Sequence" where("Asset No" = field("Block Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Academic Year", "Space Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

