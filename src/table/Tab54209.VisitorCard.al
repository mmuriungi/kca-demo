table 54209 "Visitor Card"
{
    DrillDownPageID = "Visitors Card";
    LookupPageID = "Visitors Card";
    Caption = 'Visitor Card';

    fields
    {
        field(1; "ID No."; Code[10])
        {
            trigger OnValidate()
            begin
                "Registered By" := UserId;
                "Reg. Date" := Today;
                "Reg. Time" := Time;
            end;
        }
        field(2; "Full Names"; Text[150])
        {
        }
        field(3; "Phone No."; Code[250])
        {
        }
        field(4; Email; Text[100])
        {
        }
        field(5; "Company Name"; Text[150])
        {
        }
        field(6; County; Code[20])
        {
        }
        field(7; "Reg. Date"; Date)
        {
            Editable = false;
        }
        field(8; "Reg. Time"; Time)
        {
            Editable = false;
        }
        field(9; "Registered By"; Code[150])
        {
            Editable = false;
        }

        field(10; "No. of Visits"; Integer)
        {
            CalcFormula = Count("Visitors Ledger" WHERE("ID No." = FIELD("ID No."),
                                                      "Transaction Date" = FIELD("Date Filter"),
                                                                     "Time In" = FIELD("Time Filter")));
            FieldClass = FlowField;
        }
        field(11; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(12; "Time Filter"; Time)
        {
            FieldClass = FlowFilter;
        }
        field(13; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(14; "Vehicle Registration Number"; code[50])
        {

        }
        field(15; "Checked Out By"; code[30])
        {

        }
        field(16; "Checkout Time"; time)
        {

        }
        field(17; "Checkout Date"; date)
        {

        }
        field(18; "Checked Out"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "ID No.")
        {
        }
    }

    fieldgroups
    {
    }
}

