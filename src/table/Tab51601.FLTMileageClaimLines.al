table 51601 "FLT-Mileage Claim Lines"
{
    Caption = 'Transport Mileage Claim Lines';

    fields
    {
        field(1; "Mileage Claim No."; Code[20])
        {
            Caption = 'Mileage Claim No.';
            DataClassification = ToBeClassified;
            TableRelation = "FLT-Mileage Claim Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(3; "Travel Date"; Date)
        {
            Caption = 'Date of Travel';
            DataClassification = ToBeClassified;
        }
        field(4; "Vehicle Registration No."; Code[20])
        {
            Caption = 'Car Model and Registration No.';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            var
                Vehicle: Record "FLT-Vehicle Header";
            begin
                if Vehicle.Get("Vehicle Registration No.") then begin
                    "Engine Capacity" := Vehicle."Engine Serial No.";
                    "Vehicle Make" := Vehicle.Make;
                    "Vehicle Model" := Vehicle.Model;
                end;
            end;
        }
        field(5; "Engine Capacity"; Text[30])
        {
            Caption = 'Engine Capacity';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Vehicle Make"; Text[30])
        {
            Caption = 'Vehicle Make';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Vehicle Model"; Text[30])
        {
            Caption = 'Vehicle Model';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Starting Point"; Text[100])
        {
            Caption = 'Starting Point';
            DataClassification = ToBeClassified;
        }
        field(9; "Destination"; Text[100])
        {
            Caption = 'Destination';
            DataClassification = ToBeClassified;
        }
        field(10; "Purpose of Trip"; Text[250])
        {
            Caption = 'Purpose of Trip';
            DataClassification = ToBeClassified;
        }
        field(11; "Number of Passengers"; Integer)
        {
            Caption = 'Number of Passengers';
            DataClassification = ToBeClassified;
        }
        field(12; "Distance (KM)"; Decimal)
        {
            Caption = 'Estimated Mileage (KM)';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                CalculateTotalCost();
            end;
        }
        field(13; "Rate Per KM"; Decimal)
        {
            Caption = 'Approved Rate Per Km';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                CalculateTotalCost();
            end;
        }
        field(14; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Starting Odometer Reading"; Decimal)
        {
            Caption = 'Starting Odometer Reading';
            DataClassification = ToBeClassified;
        }
        field(16; "Ending Odometer Reading"; Decimal)
        {
            Caption = 'Ending Odometer Reading';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                if ("Ending Odometer Reading" <> 0) and ("Starting Odometer Reading" <> 0) then begin
                    if "Ending Odometer Reading" <= "Starting Odometer Reading" then
                        Error('Ending odometer reading must be greater than starting odometer reading.');
                    "Actual Distance (KM)" := "Ending Odometer Reading" - "Starting Odometer Reading";
                    CalculateActualCost();
                end;
            end;
        }
        field(17; "Actual Distance (KM)"; Decimal)
        {
            Caption = 'Actual Distance (KM)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Actual Total Cost"; Decimal)
        {
            Caption = 'Actual Total Cost';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Fuel Receipts Attached"; Boolean)
        {
            Caption = 'Fuel Receipts Attached';
            DataClassification = ToBeClassified;
        }
        field(20; "Maintenance Receipts Attached"; Boolean)
        {
            Caption = 'Maintenance Receipts Attached';
            DataClassification = ToBeClassified;
        }
        field(21; "Return Date"; Date)
        {
            Caption = 'Return Date';
            DataClassification = ToBeClassified;
        }
        field(22; "Return Time"; Time)
        {
            Caption = 'Return Time';
            DataClassification = ToBeClassified;
        }
        field(23; "Departure Time"; Time)
        {
            Caption = 'Departure Time';
            DataClassification = ToBeClassified;
        }
        field(24; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(26; "Approved by Transport Officer"; Boolean)
        {
            Caption = 'Approved by Transport Officer';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Transport Officer Remarks"; Text[250])
        {
            Caption = 'Transport Officer Remarks';
            DataClassification = ToBeClassified;
        }
        field(28; "Status"; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = Open,Approved,Rejected,Posted;
            OptionCaption = 'Open,Approved,Rejected,Posted';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Mileage Claim No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Distance (KM)", "Total Cost", "Actual Distance (KM)", "Actual Total Cost";
        }
        key(Key2; "Travel Date")
        {
        }
        key(Key3; "Vehicle Registration No.", "Travel Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        MileageClaimHeader: Record "FLT-Mileage Claim Header";
    begin
        // Validate that header exists and is editable
        if MileageClaimHeader.Get("Mileage Claim No.") then begin
            if MileageClaimHeader.Status in [MileageClaimHeader.Status::Approved, MileageClaimHeader.Status::Posted] then
                Error('You cannot add lines to a %1 mileage claim.', MileageClaimHeader.Status);
        end;
        
        // Copy dimensions from header
        if MileageClaimHeader.Get("Mileage Claim No.") then begin
            "Global Dimension 1 Code" := MileageClaimHeader."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := MileageClaimHeader."Shortcut Dimension 2 Code";
        end;
        
        Status := Status::Open;
    end;

    trigger OnModify()
    var
        MileageClaimHeader: Record "FLT-Mileage Claim Header";
    begin
        // Validate that header allows modifications
        if MileageClaimHeader.Get("Mileage Claim No.") then begin
            if MileageClaimHeader.Status in [MileageClaimHeader.Status::Approved, MileageClaimHeader.Status::Posted] then
                Error('You cannot modify lines of a %1 mileage claim.', MileageClaimHeader.Status);
        end;
    end;

    trigger OnDelete()
    var
        MileageClaimHeader: Record "FLT-Mileage Claim Header";
    begin
        // Validate that header allows deletions
        if MileageClaimHeader.Get("Mileage Claim No.") then begin
            if MileageClaimHeader.Status in [MileageClaimHeader.Status::Approved, MileageClaimHeader.Status::Posted] then
                Error('You cannot delete lines from a %1 mileage claim.', MileageClaimHeader.Status);
        end;
    end;

    local procedure CalculateTotalCost()
    begin
        if ("Distance (KM)" <> 0) and ("Rate Per KM" <> 0) then
            "Total Cost" := "Distance (KM)" * "Rate Per KM"
        else
            "Total Cost" := 0;
    end;

    local procedure CalculateActualCost()
    begin
        if ("Actual Distance (KM)" <> 0) and ("Rate Per KM" <> 0) then
            "Actual Total Cost" := "Actual Distance (KM)" * "Rate Per KM"
        else
            "Actual Total Cost" := 0;
    end;

    procedure ApproveLineByTransportOfficer(ApprovalRemarks: Text[250])
    begin
        TestField(Status, Status::Open);
        "Approved by Transport Officer" := true;
        "Transport Officer Remarks" := ApprovalRemarks;
        Status := Status::Approved;
        Modify();
    end;

    procedure RejectLineByTransportOfficer(RejectionRemarks: Text[250])
    begin
        TestField(Status, Status::Open);
        "Approved by Transport Officer" := false;
        "Transport Officer Remarks" := RejectionRemarks;
        Status := Status::Rejected;
        Modify();
    end;
}