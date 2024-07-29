table 54249 "FLT-Fuel Payment Batch"
{
    // DrillDownPageID = "HRM-Posting Groups";
    // LookupPageID = "HRM-Posting Groups";

    fields
    {
        field(1; "Batch No"; Code[20])
        {
            Editable = false;
        }
        field(2; "Date Created"; Date)
        {
        }
        field(3; "Created by"; Code[20])
        {
        }
        field(4; "Vendor No"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vendor.Get("Vendor No") then
                    "Vendor Name" := Vendor.Name;
            end;
        }
        field(5; "Date Closed"; Date)
        {
        }
        field(6; "Closed By"; Code[20])
        {
        }
        field(7; "Total Payable"; Decimal)
        {
            CalcFormula = Sum("FLT-Fuel Pynts Batch Lines"."Value of Fuel" WHERE("Payment Batch No" = FIELD("Batch No")));
            FieldClass = FlowField;
        }
        field(8; "No. Series"; Code[20])
        {
        }
        field(9; Closed; Boolean)
        {
        }
        field(10; "Vendor Name"; Text[100])
        {
        }
        field(11; From; Date)
        {
        }
        field(12; DTo; Date)
        {
            Caption = 'To';
        }
        field(13; Invoiced; Boolean)
        {
        }
        field(14; "Invoice No."; Code[20])
        {
        }
        field(15; "Invoiced By"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Batch No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Batch No" = '' then begin
            fleetmgt.Get;
            fleetmgt.TestField("Fuel Payment Batch No");

            NoSeriesMgt.InitSeries(fleetmgt."Fuel Payment Batch No", xRec."No. Series", 0D, "Batch No", "No. Series")

        end;
    end;

    var
        fleetmgt: Record "FLT-Fleet Mgt Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Vendor: Record Vendor;
}

