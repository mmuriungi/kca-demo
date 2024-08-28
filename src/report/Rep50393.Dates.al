report 50393 Dates
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Dates.rdl';

    dataset
    {
        dataitem(DataItem1; 2000000007)
        {
            column(Type; "Period Type")
            {
            }
            column(Start; "Period Start")
            {
            }
            column("End"; "Period End")
            {
            }
            column(Period_No; "Period No.")
            {
            }
            column(PerName; "Period Name")
            {
            }
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

