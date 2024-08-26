table 51064 "Merged Requisitions"
{
    Caption = 'Merged Requisitions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(2; "Transport Req"; Code[20])
        {
            Caption = 'Transport Req';
            TableRelation = "FLT-Transport Requisition"."Transport Requisition No" where("Car Pool" = const(true));
            trigger OnValidate()
            begin
                transport.Reset();
                transport.SetRange("Transport Requisition No", "Transport Req");
                if transport.Find('-') then begin
                    "Date of Request" := transport."Date of Request";
                    "Duration to be Away" := transport."Duration to be Away";
                    "Number of Passenger" := transport."Number of Passangers";
                    Destination := transport.Destination;
                    "Requested By":= transport."Requested By";
                    transport.Status := transport.Status::Approved;                             
                end;
            end;
        }
        field(3; "Date of Request"; Date)
        {
            Caption = 'Date of Request';
        }
        field(4; "Duration to be Away"; Text[100])
        {
            Caption = 'Duration to be Away';
        }
        field(5; "Number of Passenger"; Integer)
        {
            Caption = 'Number of Passenger';
        }
        field(6; Destination; Text[100])
        {
            Caption = 'Destination';
        }
        field(7; "Requested By"; Code[20])
        {
            Caption = 'Requested By';
        }
        field(8; "No."; code[20])
        {

        }
    }
    keys
    {
        key(PK; "Line No", "Transport Req", "No.")
        {
            Clustered = true;
        }
    }
    var
        transport: Record "FLT-Transport Requisition";
}
