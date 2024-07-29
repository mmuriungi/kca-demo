report 52063 "ACA-Validate Stages"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ACA-Validate Stages.rdl';

    dataset
    {
        dataitem(ProgStages; "ACA-Programme Stages")
        {

            trigger OnAfterGetRecord()
            begin
                ProgStages.VALIDATE(Code);
                ProgStages.MODIFY;
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

