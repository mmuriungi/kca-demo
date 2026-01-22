report 50440 "Valid Unitsz"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Unitsz; "ACA-Student Units")
        {

            trigger OnAfterGetRecord()
            begin
                Unitsz.VALIDATE(Unit);
                Unitsz.MODIFY;
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

