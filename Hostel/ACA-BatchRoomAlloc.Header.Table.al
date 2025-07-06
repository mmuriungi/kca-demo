#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 77340 "ACA-Batch Room Alloc. Header"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
        }
        field(2; "Hostel Block"; Code[20])
        {
        }
        field(3; "Created By"; Code[20])
        {
        }
        field(4; "Date Created"; Date)
        {
        }
        field(5; "Time Created"; Time)
        {
        }
        field(6; "Number of Allocation"; Integer)
        {
            CalcFormula = count("ACA-Batch Room Alloc. Details" where("Academic Year" = field("Academic Year"),
                                                                       "Hostel Block" = field("Hostel Block")));
            FieldClass = FlowField;
        }
        field(7; "Notification type"; Option)
        {
            OptionCaption = ' ,E-Mail,Phone,Both';
            OptionMembers = " ","E-Mail",Phone,Both;
        }
        field(8; "Total Allocations in Year"; Integer)
        {
            CalcFormula = count("ACA-Batch Room Alloc. Details" where("Academic Year" = field("Academic Year")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Academic Year", "Hostel Block")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Clear(ACABatchRoomAllocDetails);
        ACABatchRoomAllocDetails.Reset;
        ACABatchRoomAllocDetails.SetRange("Hostel Block", Rec."Hostel Block");
        if ACABatchRoomAllocDetails.Find('-') then begin
            ACABatchRoomAllocDetails.DeleteAll;
        end;
    end;

    var
        ACABatchRoomAllocDetails: Record "ACA-Batch Room Alloc. Details";
}

