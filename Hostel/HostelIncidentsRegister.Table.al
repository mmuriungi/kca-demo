#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 61832 "Hostel Incidents Register"
{

    fields
    {
        field(1; "Incident No."; Code[20])
        {

            trigger OnValidate()
            begin
                "Incident Date" := Today;
                "Incident Time" := Time;
                "Report By" := UserId;
                //IF TIME IN[0659..1900] THEN BEGIN
                //  "Day/Night":="Day/Night"::Day;
                //END ELSE IF TIME IN[1859..0700] THEN BEGIN
                //"Day/Night":="Day/Night"::Night;
                //END;
            end;
        }
        field(2; "Hostel Block No."; Code[20])
        {
        }
        field(3; "Incident Date"; Date)
        {
        }
        field(4; "Incident Time"; Time)
        {
        }
        field(5; "Day/Night"; Option)
        {
            OptionMembers = " ",Day,Night;
        }
        field(6; "Report By"; Code[100])
        {
        }
        field(7; "Report Summary"; Text[100])
        {
        }
        field(8; "Report Details"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Incident No.", "Hostel Block No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        AppSetup.Get;
        AppSetup.TestField(AppSetup."Hostel Incidents");
        "Incident No." := NoSeriesMgt.GetNextNo(AppSetup."Hostel Incidents", Today, true);
        Validate("Incident No.");
        //InitSeries(AppSetup."Application Form Nos.",xRec."No. Series",0D,"Application No.","No. Series");
    end;

    var
        AppSetup: Record "ACA-General Set-Up";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

