table 54224 "FLT-Fuel Consumption"
{
    // DrillDownPageID = 39004339;
    // LookupPageID = 39004339;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Vehicle Reg No."; Code[40])
        {
            TableRelation = "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                /*
                IF FA.GET("Vehicle Reg No.") THEN BEGIN
                "Fuel Type":=FA."Fuel Type";
                "Previous ODO Reading":=FA.Mielage;
                END;
                */

            end;
        }
        field(4; Driver; Code[20])
        {
            TableRelation = "FLT-Drivers Setup"."No.";
        }
        field(5; "Ticket No."; Code[20])
        {
        }
        field(6; "Place of Travel"; Code[20])
        {
            TableRelation = "FLT-Transport Places".Place WHERE("Request No." = FIELD("Ticket No."));
        }
        field(7; "Odometer Reading"; Integer)
        {

            trigger OnValidate()
            begin
                /*
                IF FA.GET("Vehicle Reg No.") THEN BEGIN
                IF "Odometer Reading"<FA.Mielage THEN ERROR('Please note that the ODO Reading can not be less than Previous Reading');
                FA.Mielage:="Odometer Reading";
                FA.MODIFY;
                END;
                */

            end;
        }
        field(8; "Litres  Consumed"; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Amount" := "Amount Per Litres" * "Litres  Consumed";
            end;
        }
        field(9; "Amount Per Litres"; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Amount" := "Amount Per Litres" * "Litres  Consumed";
            end;
        }
        field(10; "Total Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Litres  Consumed" = 0) and ("Amount Per Litres" <> 0) then
                    "Litres  Consumed" := "Total Amount" / "Amount Per Litres"
                else
                    if ("Amount Per Litres" = 0) and ("Litres  Consumed" <> 0) then
                        "Amount Per Litres" := "Total Amount" / "Litres  Consumed"
                    else
                        if ("Amount Per Litres" <> 0) and ("Litres  Consumed" <> 0) then
                            "Litres  Consumed" := "Total Amount" / "Amount Per Litres"
                        else
                            Error('Please enter either Amount per litre or Litres consumed');
            end;
        }
        field(11; "Fueling Station"; Code[20])
        {
        }
        field(12; "Entered By"; Code[20])
        {
        }
        field(13; "Previous ODO Reading"; Integer)
        {
        }
        field(14; "Fuel Type"; Option)
        {
            OptionCaption = ' ,Petrol,Diesel';
            OptionMembers = " ",Petrol,Diesel;
        }
        field(15; "Service No."; Code[20])
        {
        }
        field(16; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(17; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            SumIndexFields = "Total Amount";
        }
        key(Key2; "Vehicle Reg No.")
        {
            SumIndexFields = "Total Amount";
        }
        key(Key3; Date, "Vehicle Reg No.")
        {
            SumIndexFields = "Total Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        IF "No." = '' THEN BEGIN
          OPSetUp.GET(0);
          OPSetUp.TESTFIELD(OPSetUp."Consumption Nos");
          NoSeriesMgt.InitSeries(OPSetUp."Consumption Nos",xRec."No. Series",0D,"No.","No. Series");
        END;
         */

    end;

    var
        FA: Record "Fixed Asset";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    //OPSetUp: Record "ACA-Evaluation Questions";
}

