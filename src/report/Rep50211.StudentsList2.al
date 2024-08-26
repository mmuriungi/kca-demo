report 50211 "Students List2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Students List2.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "Settlement Type Filter";
            column(No; Customer."No.")
            {
            }
            column(Name; Customer.Name)
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

