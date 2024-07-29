report 51804 "Programme List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Programme List.rdl';

    dataset
    {
        dataitem(PL; "ACA-Programme")
        {
            column(Schl; PL."School Code")
            {
            }
            column("code"; PL.Code)
            {
            }
            column(Description; PL.Description)
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

