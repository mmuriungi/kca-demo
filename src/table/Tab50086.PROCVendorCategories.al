table 50086 "PROC-Vendor Categories"
{
    LookupPageId = "PROC-Vendor Categories";
    DrillDownPageId = "PROC-Vendor Categories";
    fields
    {
        field(1; "Code"; Code[20])
        {

        }

        field(3; "Description"; Text[100])
        {

        }
    }

    var
        purSetup: Record "Purchases & Payables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "Code" = '' then begin
            purSetup.Get();
            "Code" := NoSeriesManagement.GetNextNo(purSetup."Vendor Categories", Today, True);
        end;

    end;
}