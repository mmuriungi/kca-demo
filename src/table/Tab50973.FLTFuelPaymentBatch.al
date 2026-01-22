table 50973 "FLT-Fuel Payment Batch"
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
            trigger OnValidate()
            var
                FuelReq: Record "FLT-Fuel & Maintenance Req.";
                FuelBatchLines: Record "FLT-Fuel Pynts Batch Lines";
                LineNo: Integer;
            begin
                // Validate required fields
                TestField("Vendor No");
                TestField(From);
                if DTo < From then
                    Error('To Date cannot be earlier than From Date');

                // Delete existing lines for this batch
                FuelBatchLines.Reset();
                FuelBatchLines.SetRange("Payment Batch No", "Batch No");
                if FuelBatchLines.FindSet() then
                    FuelBatchLines.DeleteAll();

                // Get all approved fuel requisitions for the vendor within the date range
                FuelReq.Reset();
                FuelReq.SetRange("Vendor(Dealer)", "Vendor No");
                FuelReq.SetRange(Status, FuelReq.Status::Approved);
                FuelReq.SetRange(Type, FuelReq.Type::fuel);
                FuelReq.SetRange(FuelReq."Request Date", From, DTo);
                FuelReq.SetRange("Type of Fuel Requisition", FuelReq."Type of Fuel Requisition"::Invoice);
                FuelReq.SetFilter("Posted Invoice No", '=%1', ''); // Only get non-invoiced requisitions

                if FuelReq.FindSet() then begin
                    repeat
                        // Create batch line for each fuel requisition
                        FuelBatchLines.Init();
                        FuelBatchLines."Payment Batch No" := "Batch No";
                        FuelBatchLines."Requisition No" := FuelReq."Requisition No";
                        FuelBatchLines."Vehicle Reg No" := FuelReq."Vehicle Reg No";
                        FuelBatchLines."Vendor(Dealer)" := FuelReq."Vendor(Dealer)";
                        FuelBatchLines."Vendor Name" := FuelReq."Vendor Name";
                        FuelBatchLines."Quantity of Fuel(Litres)" := FuelReq."Quantity of Fuel(Litres)";
                        FuelBatchLines."Value of Fuel" := FuelReq."Total Price of Fuel";
                        FuelBatchLines."Odometer Reading" := FuelReq."Odometer Reading";
                        FuelBatchLines."Request Date" := FuelReq."Request Date";
                        FuelBatchLines."Date Taken for Fueling" := FuelReq."Date Taken for Fueling";
                        FuelBatchLines.Status := FuelReq.Status;
                        FuelBatchLines."Prepared By" := FuelReq."Prepared By";
                        FuelBatchLines.Description := FuelReq.Description;
                        FuelBatchLines.Department := FuelReq.Department;
                        FuelBatchLines.Type := FuelBatchLines.Type::Fuel;
                        FuelBatchLines.Driver := FuelReq.Driver;
                        FuelBatchLines."Driver Name" := FuelReq."Driver Name";
                        FuelBatchLines."Fixed Asset No" := FuelReq."Fixed Asset No";
                        FuelBatchLines."Litres of Oil" := FuelReq."Litres of Oil";
                        FuelBatchLines.Insert(true);
                    until FuelReq.Next() = 0;

                    Message('%1 fuel requisition(s) added to the batch.', FuelReq.Count);
                end else
                    Message('No approved fuel requisitions found for vendor %1 within the specified date range.', "Vendor Name");
            end;
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
        //posted
        field(16; Posted; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Purch. Inv. Header" where("Batch No." = field("Batch No")));
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

