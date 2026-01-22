report 50184 "Jab Billing Correction"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Jab Billing Correction.rdl';

    dataset
    {
        dataitem(CR; "ACA-Course Registration")
        {
            RequestFilterFields = Stage, "Settlement Type";
            column(No; CR."Student No.")
            {
            }
            column(Prog; CR.Programmes)
            {
            }
            column(Stage; CR.Stage)
            {
            }
            column(SettlementType; CR."Settlement Type")
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

