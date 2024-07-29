report 52068 "Val Units"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Student Units"; "ACA-Student Units")
        {
            RequestFilterFields = Semester;

            trigger OnAfterGetRecord()
            begin
                "ACA-Student Units".Taken := TRUE;
                "ACA-Student Units".MODIFY;
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

