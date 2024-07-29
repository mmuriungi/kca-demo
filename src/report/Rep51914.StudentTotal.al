report 51914 "Student Total"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Student Total.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(Customer_Customer__Programme_Filter_; Customer."Programme Filter")
            {
            }
            column(Customer_No_; "No.")
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

