table 54240 "FLT-Daily Work Ticket Header"
{
    DrillDownPageID = "FLT-Closed Work Ticket List";
    LookupPageID = "FLT-Closed Work Ticket List";

    fields
    {
        field(1; "Ticket No."; Code[20])
        {
        }
        field(2; "Previous W.T. No."; Code[20])
        {
        }
        field(3; "G.K. No."; Code[20])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";
        }
        field(4; Make; Code[10])
        {
            CalcFormula = Lookup("FLT-Vehicle Header".Make WHERE("Registration No." = FIELD("G.K. No.")));
            FieldClass = FlowField;
        }
        field(5; Unit; Code[20])
        {
        }
        field(6; Type; Code[10])
        {
            CalcFormula = Lookup("FLT-Vehicle Header".Model WHERE("Registration No." = FIELD("G.K. No.")));
            FieldClass = FlowField;
        }
        field(7; Station; Text[50])
        {
        }
        field(8; "Total Milleage"; Decimal)
        {
            CalcFormula = Sum("FLT-Daily Work Ticket Lines"."Kilometers Covered" WHERE("Ticket No." = FIELD("Ticket No.")));
            FieldClass = FlowField;
        }
        field(9; "Total Fuel Cost"; Decimal)
        {
            CalcFormula = Sum("FLT-Daily Work Ticket Lines"."Fuel Cost (Total)" WHERE("Ticket No." = FIELD("Ticket No.")));
            FieldClass = FlowField;
        }
        field(10; Ministry; Code[50])
        {
        }
        field(11; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(12; "Department Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD(Department)));
            FieldClass = FlowField;
        }
        field(13; "Total Fuel Consumed"; Decimal)
        {
            /* CalcFormula = Sum("FLT-Daily Work Ticket Lines"."Fuel Consumed (Litres)" WHERE("Ticket No." = FIELD("Ticket No.")));
            FieldClass = FlowField; */
        }
        field(14; "Oil Consumed"; Decimal)
        {
            /*  CalcFormula = Sum("FLT-Daily Work Ticket Lines"."Total Oil Consumed" WHERE("Ticket No." = FIELD("Ticket No.")));
             FieldClass = FlowField; */
        }
        field(15; Status; Option)
        {
            OptionMembers = Open,Closed;
        }
        field(16; Month; Option)
        {
            OptionMembers = " ",JANUARY,FEBRUARY,MARCH,APRIL,MAY,JUNE,JULY,AUGUST,SEPTEMBER,OCTOBER,NOVEMBER,DECEMBER;
        }
        field(17; Year; Option)
        {
            OptionMembers = " ","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030","2031","2032","2033","2034","2035","2036","2037","2038","2039","2040","2041","2042","2043","2044","2045","2046","2047","2048","2049","2050","2051","2052","2053","2054","2055","2056","2057","2058","2059","2060";
        }
        field(18; "Fuel Price"; Decimal)
        {
            trigger OnValidate()
            begin
                if (("Total Fuel Consumed" <> 0)) then begin
                    "Total Fuel Cost" := "Total Fuel Consumed" * "Fuel Price" + "Oil Consumed" * "Oil Price";
                end;
            end;
        }
        field(19; "Oil Price"; Decimal)
        {
            trigger OnValidate()
            begin
                if (("Oil Consumed" <> 0)) then begin
                    "Total Fuel Cost" := "Total Fuel Consumed" * "Fuel Price" + "Oil Consumed" * "Oil Price";
                end;
            end;
        }
        field(30; "No. Series"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Ticket No.")
        {
        }
    }

    fieldgroups
    {
    }


    trigger OnInsert()
    begin
        IF "Ticket No." = '' THEN begin
            FltMgtSetup.get();
            FltMgtSetup.TestField(FltMgtSetup."Daily Work Ticket");
            NoSeriesMgt.InitSeries(FltMgtSetup."Daily Work Ticket", xRec."No. Series", 0D, "Ticket No.", "No. Series");

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
    end;


    var
        FltMgtSetup: Record "FLT-Fleet Mgt Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Record "General Ledger Setup";
        //  NoSeriesMgt: Codeunit NoSeriesManagement;
        Nosetup: Record "No. Series Line";
        LastNoUsed: Code[10];
}

