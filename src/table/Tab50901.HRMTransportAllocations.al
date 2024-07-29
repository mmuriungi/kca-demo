/// <summary>
/// Table HRM-Transport Allocations (ID 52178575).
/// </summary>
table 50901 "HRM-Transport Allocations"
{
    Caption = 'HRM-Transport Allocations';
    //LookupPageID = "PRL-Changes Requested Appr";

    fields
    {
        field(1; "Allocation No"; Code[20])
        {
        }
        field(2; "Employee No"; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin

                if HREmp.Get("Employee No") then begin
                    "Passenger/s Full Name/s" := HREmp.FullName;
                    Dept := HREmp."Department Code";
                end;
            end;
        }
        field(3; "Passenger/s Full Name/s"; Text[70])
        {
        }
        field(4; Dept; Text[70])
        {
        }
        field(5; "Requisition No"; Code[20])
        {
            TableRelation = "HRM-Transport Request".Code WHERE(Status = CONST(Approved),
                                                                 "Allocation Done" = CONST(false));

            trigger OnValidate()
            begin

                HRTransportRequests.Reset;
                HRTransportRequests.Get("Requisition No");
                "Employee No" := HRTransportRequests."Requester Code";
                Validate("Employee No");
                From := HRTransportRequests.From;
                "To" := HRTransportRequests."To";

                HRTransportRequests."Allocation Done" := true;
                HRTransportRequests.Modify;
            end;
        }
        field(6; From; Text[30])
        {
        }
        field(7; "To"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Allocation No", "Requisition No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin


        HRTransportRequests.Reset;
        if HRTransportRequests.Get("Requisition No") then begin

            HRTransportRequests."Allocation Done" := false;
            HRTransportRequests.Modify;

        end;
    end;

    trigger OnModify()
    begin

        HRTransportAllocationH.Reset;
        HRTransportAllocationH.Get("Allocation No");
        HRTransportAllocationH.TestField(HRTransportAllocationH.Status, HRTransportAllocationH.Status::Open);
    end;

    var
        Text0001: Label 'You cannot modify an Approved or Closed Record';
        Text001: Label 'Your identification is set up to process from %1 %2 only.';
        HREmp: Record "HRM-Employee C";
        HRTransportRequests: Record "HRM-Transport Request";
        HRTransportAllocationH: Record "HRM-Staff Transport Alloc.";
}

