report 50133 "Process Leave Ledger"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HRM-Leave Ledger"; "HRM-Leave Ledger")
        {

            trigger OnAfterGetRecord()
            begin
                if "HRM-Leave Ledger"."Transaction Type" = "HRM-Leave Ledger"."Transaction Type"::Allocation then
                    "HRM-Leave Ledger"."Entry Type" := "HRM-Leave Ledger"."Entry Type"::Allocation;

                if "HRM-Leave Ledger"."Transaction Type" = "HRM-Leave Ledger"."Transaction Type"::Application then
                    "HRM-Leave Ledger"."Entry Type" := "HRM-Leave Ledger"."Entry Type"::Application;
                "HRM-Leave Ledger".Modify;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

