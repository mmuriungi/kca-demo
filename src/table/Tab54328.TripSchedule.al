table 54328 "Trip Schedule"
{
    Caption = 'Trip Schedule';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Driver Code "; Code[40])
        {
            Caption = 'Driver Code ';
            TableRelation = "FLT-Driver".Driver;
            // trigger OnValidate()
            // var
            //     dr: Record "FLT-Driver";
            // begin
            //     dr.Reset();
            //     "Driver Name"

            // end;
        }
        field(2; "Driver Name"; Code[40])
        {
            Caption = 'Driver Name';
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; Destination; Code[60])
        {
            Caption = 'Destination';
        }
        field(5; "No Of Days"; Code[60])
        {
            Caption = 'No Of Days';
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; "Vehicle Reg No"; Code[60])
        {
            Caption = 'Vehicle Reg No';
        }

    }
    keys
    {
        key(PK; "Driver Code ")
        {
            Clustered = true;
        }
    }
}
