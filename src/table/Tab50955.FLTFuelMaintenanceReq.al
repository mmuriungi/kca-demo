table 50955 "FLT-Fuel & Maintenance Req."
{
    // DrillDownPageID = "HRM-Emp Resp. Center Card";
    //LookupPageID = "HRM-Emp Resp. Center CarD";

    fields
    {
        field(1; "Requisition No"; Code[20])
        {
        }
        field(2; "Vehicle Reg No"; Code[20])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";

            trigger OnValidate()
            begin
                WshpFA.Reset;
                WshpFA.SetRange(WshpFA."Registration No.", "Vehicle Reg No");
                if WshpFA.Find('-') then
                    "Fixed Asset No" := WshpFA."No.";
            end;
        }
        field(3; "Vendor(Dealer)"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vendor.Get("Vendor(Dealer)") then
                    "Vendor Name" := Vendor.Name;
            end;
        }
        field(4; "Quantity of Fuel(Litres)"; Decimal)
        {

        }
        field(5; "Total Price of Fuel"; Decimal)
        {
            Editable = false;
            trigger OnValidate()
            var
                Fuel: Record "FLT-Fuel & Maintenance Req.";
            begin
                "Total Price of Fuel" := FUEL."Total Price of Fuel" * Fuel."Quantity of Fuel(Litres)";
                rec.Modify();
            end;
        }
        field(6; "Odometer Reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(7; "Request Date"; Date)
        {
        }
        field(8; "Date Taken for Fueling"; Date)
        {
        }
        field(9; Status; Option)
        {
            OptionMembers = Open,Submitted,Approved,Closed,Cancelled;
        }
        field(10; "Prepared By"; Code[20])
        {
        }
        field(11; "Closed By"; Code[20])
        {
        }
        field(12; "Date Closed"; Date)
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
        field(18; "Vendor Name"; Text[100])
        {
        }
        field(19; "Date Taken for Maintenance"; Date)
        {
        }
        field(98; "Maintanance Type"; Option)
        {
            OptionMembers = "",Service,Repair;
            DataClassification = ToBeClassified;
        }
        field(20; Type; Option)
        {
            OptionMembers = ,fuel,maintenance;
        }
        field(345; "Fuel For"; Option)
        {
            OptionMembers = "",Vehicle,Machinery;
            DataClassification = ToBeClassified;
        }
        field(21; "Type of Maintenance"; Text[50])
        {
            //   OptionMembers = " ",Repair,"Scheduled Service",Tyre;
        }
        field(22; Driver; Code[10])
        {
            TableRelation = "FLT-Driver";

            trigger OnValidate()
            begin
                if Drivers.Get(Driver) then
                    "Driver Name" := Drivers."Driver Name";
            end;
        }
        field(23; "Driver Name"; Text[100])
        {
        }
        field(24; "Fixed Asset No"; Code[20])
        {
        }
        field(25; "Litres of Oil"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(26; "Quote No"; Code[20])
        {
        }
        field(27; "Price/Litre"; Decimal)
        {

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Total Price of Fuel" := "Quantity of Fuel(Litres)" * "Price/Litre";

            end;
        }
        field(28; "Type of Fuel"; Code[67])
        {
            TableRelation = "Fuel Type";

        }
        field(29; Coolant; Decimal)
        {
        }
        field(30; "Battery Water"; Decimal)
        {
        }
        field(31; "Wheel Alignment"; Decimal)
        {
        }
        field(32; "Wheel Balancing"; Decimal)
        {
        }
        field(33; "Car Wash"; Decimal)
        {
        }
        field(34; "Requesting officer"; Code[24])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            var
                emp: Record "HRM-Employee C";
            begin
                IF Emp.GET("Requesting officer") THEN begin
                    "Requester Name" := (Emp."First Name") + ' ' + (Emp."Last Name");
                    "Designation2 " := emp."Job Title";
                    "requester Contact number" := emp."Cellular Phone Number";
                    Department := emp."Department Name";
                end;

            end;

        }
        field(35; "Requester Name"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Designation2 "; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "requester Contact number"; code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "mileage at request of services"; code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "mileage at service"; code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Date of Service"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Time Fuel Is Required"; Time)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Requisition No")
        {
        }
    }

    fieldgroups
    {
    }




    trigger OnInsert()
    begin

        FltMgtSetup.Get;
        FltMgtSetup.TestField(FltMgtSetup."Fuel Register");
        NoSeriesMgt.InitSeries(FltMgtSetup."Fuel Register", xRec."No. Series", 0D, "Requisition No", "No. Series");
        // if Type = Type::Fuel then begin
        //     if "Requisition No" = '' then begin
        //         FltMgtSetup.Get;
        //         FltMgtSetup.TestField(FltMgtSetup."Fuel Register");
        //         NoSeriesMgt.InitSeries(FltMgtSetup."Fuel Register", xRec."No. Series", 0D, "Requisition No", "No. Series");
        //     end;
        // end else begin
        //     if Type = Type::Maintenance then begin
        //         if "Requisition No" = '' then begin
        //             FltMgtSetup.Get;
        //             FltMgtSetup.TestField(FltMgtSetup."Maintenance Request");
        //             NoSeriesMgt.InitSeries(FltMgtSetup."Maintenance Request", xRec."No. Series", 0D, "Requisition No", "No. Series");
        //         end;
        //     end;
        // end;
    end;
    // if Type = Type::Fuel then begin
    //     if "Requisition No" = '' then begin
    //         FltMgtSetup.Get;
    //         FltMgtSetup.TestField(FltMgtSetup."Fuel Register");
    //         NoSeriesMgt.InitSeries(FltMgtSetup."Fuel Register", xRec."No. Series", 0D, "Requisition No", "No. Series");
    //     end;
    // end else begin
    //     if Type = Type::Maintenance then begin
    //         if "Requisition No" = '' then begin
    //             FltMgtSetup.Get;
    //             FltMgtSetup.TestField(FltMgtSetup."Maintenance Request");
    //             NoSeriesMgt.InitSeries(FltMgtSetup."Maintenance Request", xRec."No. Series", 0D, "Requisition No", "No. Series");
    //         end;
    //     end;
    // end;


    var
        FltMgtSetup: Record "FLT-Fleet Mgt Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Vendor: Record Vendor;
        Drivers: Record "FLT-Driver";
        WshpFA: Record "FLT-Vehicle Header";
}

