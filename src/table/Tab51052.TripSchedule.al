table 51052 "Trip Schedule"
{
    Caption = 'Trip Schedule';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Transport Requisition No."; Code[20])
        {
            Caption = 'Transport Requisition No.';
            TableRelation = "FLT-Transport Requisition"."Transport Requisition No";
        }
        field(3; "Driver Code "; Code[40])
        {
            Caption = 'Driver Code ';
            TableRelation = "FLT-Driver".Driver;
            trigger OnValidate()
            var
                FLTDriver: Record "FLT-Driver";
            begin
                if FLTDriver.Get("Driver Code ") then
                    "Driver Name" := FLTDriver."Driver Name";
            end;
        }
        field(4; "Driver Name"; Code[40])
        {
            Caption = 'Driver Name';
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(6; Destination; Text[2048])
        {
            Caption = 'Destination';
        }
        field(7; "No Of Days"; Code[60])
        {
            Caption = 'No Of Days';
        }
        field(8; Amount; Decimal)
        {
            Caption = 'DSA Amount';
        }
        field(9; "Vehicle Reg No"; Code[60])
        {
            Caption = 'Vehicle Reg No';
            TableRelation = "FLT-Vehicle Header"."Registration No.";
        }
        field(10; "Fuel Amount"; Decimal)
        {
            Caption = 'Fuel Amount';
        }
        field(11; "Created Date"; Date)
        {
            Caption = 'Created Date';
        }
        field(12; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }

    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(SK1; "Transport Requisition No.")
        {
        }
        key(SK2; "Driver Code ", "Date")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created By" := UserId;
    end;
}
