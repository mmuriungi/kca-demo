report 52059 "Validate Reg"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; "ACA-Student Units")
        {

            trigger OnAfterGetRecord()
            begin
                Reg.VALIDATE(Unit);
                reg.MODIFY;
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
    var
        reg: Record "ACA-Student Units";
}

