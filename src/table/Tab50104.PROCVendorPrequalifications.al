table 50104 "PROC-Vendor Prequalifications"
{
    LookupPageId = "PROC-Vendor Prequalifications";
    DrillDownPageId = "PROC-Vendor Prequalifications";
    fields
    {
        field(1; "Prequalification Code"; Code[50])
        {

        }

        field(3; "Description"; Text[100])
        {

        }
        field(4; "Active"; Boolean)
        {

        }
    }

    var
        purSetup: Record "Purchases & Payables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

}