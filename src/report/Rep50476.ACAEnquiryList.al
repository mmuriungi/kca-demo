report 50476 "ACA-Enquiry List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ACA-Enquiry List.rdl';

    dataset
    {
        dataitem(EnH; "ACA-Enquiry Header")
        {
            column(no; EnH."Enquiry No.")
            {
            }
            column(enqDate; EnH."Enquiry Date")
            {
            }
            column(Names; EnH."Name(Surname First)")
            {
            }
            column(Gender; EnH.Gender)
            {
            }
            column(Prog; EnH.Programmes)
            {
            }
            column(Surname; EnH.Surname)
            {
            }
            column(OtherNames; EnH."Other Names")
            {
            }
            column(MktStrategy; EnH."How You knew about us")
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

