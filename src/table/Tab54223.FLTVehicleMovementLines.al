table 54223 "FLT-Vehicle Movement Lines"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                CalcFields("Ticket No");
            end;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Driver No"; Code[20])
        {
            TableRelation = "FLT-Drivers Setup"."No.";

            trigger OnValidate()
            begin
                GetODO;
            end;
        }
        field(4; "Hirers Name"; Text[100])
        {
        }
        field(5; "Area"; Code[50])
        {
            TableRelation = IF ("Ticket No" = FILTER(<> '')) "FLT-Transport Places".Place WHERE("Request No." = FIELD("Ticket No"))
            ELSE
            IF ("Ticket No" = FILTER('')) "FLT-Transport Places".Place;

            trigger OnValidate()
            begin
                GetODO;
            end;
        }
        field(6; "Starting Odometer"; Integer)
        {
            Editable = false;
        }
        field(7; "Ending Odometer"; Integer)
        {

            trigger OnValidate()
            begin
                /*
                  IF "Ending Odometer"<"Starting Odometer" THEN ERROR('Ending Odometer can not be less than starting Odometer');
                 Mileage:="Ending Odometer"-"Starting Odometer";

                 IF MoveHeader.GET("No.") THEN
                 IF FA.GET(MoveHeader."Vehicle Reg No.") THEN BEGIN
                 FA.Mielage:="Ending Odometer";
                 FA.MODIFY;
                 END;
                */

            end;
        }
        field(8; Mileage; Integer)
        {
        }
        field(9; "In Time"; Time)
        {

            trigger OnValidate()
            begin
                "Exceeded Hrs" := 0;
                if ("In Time" <> 0T) and ("Out Time" <> 0T) then begin
                    "Exceeded Hrs" := ("Out Time" - "In Time") - "Contract Hrs";
                    if "Exceeded Hrs" < 0 then "Exceeded Hrs" := 0;
                    if "Exceeded Hrs" <> 0 then
                        "Exceeded Hrs" := "Exceeded Hrs" / 3600000;
                end;
            end;
        }
        field(10; "Out Time"; Time)
        {

            trigger OnValidate()
            begin
                "Exceeded Hrs" := 0;
                if ("In Time" <> 0T) and ("Out Time" <> 0T) then begin
                    "Exceeded Hrs" := ("Out Time" - "In Time") - "Contract Hrs";
                    if "Exceeded Hrs" < 0 then "Exceeded Hrs" := 0;
                    if "Exceeded Hrs" <> 0 then
                        "Exceeded Hrs" := "Exceeded Hrs" / 3600000;
                end;
            end;
        }
        field(11; "Contract Hrs"; Decimal)
        {

            trigger OnValidate()
            begin
                "Exceeded Hrs" := 0;
                if ("In Time" <> 0T) and ("Out Time" <> 0T) then begin
                    "Exceeded Hrs" := ("Out Time" - "In Time") - "Contract Hrs";
                    if "Exceeded Hrs" < 0 then "Exceeded Hrs" := 0;
                    if "Exceeded Hrs" <> 0 then
                        "Exceeded Hrs" := "Exceeded Hrs" / 3600000;
                end;
            end;
        }
        field(12; "Exceeded Hrs"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(13; "Ticket No"; Code[20])
        {
            CalcFormula = Lookup("FLT-Vehicle Movement"."Ticket No" WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(14; Date; Date)
        {

            trigger OnValidate()
            begin
                GetODO;
            end;
        }
        field(15; "Approved By"; Code[20])
        {
        }
        field(16; "Approval Date"; Date)
        {
        }
        field(17; Dispatched; Boolean)
        {
        }
        field(18; "No of Approvals"; Integer)
        {
        }
        field(19; Received; Boolean)
        {
        }
        field(20; "Received By"; Code[20])
        {
        }
        field(21; "Received Date"; Date)
        {
        }
        field(22; Location; Option)
        {
            OptionCaption = 'In,Out';
            OptionMembers = "In",Out;
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Tdiff: Duration;
        FA: Record "Fixed Asset";
        MoveHeader: Record "FLT-Vehicle Movement";

    procedure GetODO()
    begin
        /*
          IF MoveHeader.GET("No.") THEN
         IF FA.GET(MoveHeader."Vehicle Reg No.") THEN
         "Starting Odometer":=FA.Mielage;
        */

    end;
}

