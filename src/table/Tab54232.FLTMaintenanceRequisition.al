table 54232 "FLT-Maintenance Requisition"
{
    DrillDownPageID = "HRM-Holidays";
    LookupPageID = "HRM-Holidays";

    fields
    {
        field(1; "Fuel Req No"; Code[20])
        {
        }
        field(2; "Vehicle Reg No"; Code[20])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";
        }
        field(3; "Vendor(Dealer)"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(6; "Odometer Reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(7; "Request Date"; Date)
        {
        }
        field(8; "Date Taken for Maintenance"; Date)
        {
        }
        field(9; Status; Option)
        {
            OptionMembers = Open,Submitted,Approved,Closed;
        }
        field(10; "Prepared By"; Code[20])
        {
        }
        field(11; "Closed By"; Code[20])
        {
        }
        field(12; "Date Closed"; Code[20])
        {
        }
        field(13; "Vendor Invoice No"; Code[20])
        {
        }
        field(14; "Posted Invoice No"; Code[20])
        {
        }
        field(15; Description; Text[250])
        {
        }
        field(16; Department; Code[20])
        {
        }
        field(17; "No. Series"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Fuel Req No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Fuel Req No" = '' then begin
            FltMgtSetup.Get;
            FltMgtSetup.TestField(FltMgtSetup."Maintenance Request");
            NoSeriesMgt.InitSeries(FltMgtSetup."Maintenance Request", xRec."No. Series", 0D, "Fuel Req No", "No. Series");
        end;
    end;

    var
        FltMgtSetup: Record "FLT-Fleet Mgt Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

