/// <summary>
/// Report ACA-Marketing Strategy (ID 50049).
/// </summary>
report 50415 "ACA-Marketing Strategy"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ACAMarketingStrategy.rdl';

    dataset
    {
        dataitem("ACA-Marketing Strategies"; "ACA-Marketing Strategies")
        {
            column(mktDesc_desc; "ACA-Marketing Strategies".Code + ': ' + "ACA-Marketing Strategies".Description)
            {
            }
            dataitem("ACA-Enquiry Header"; "ACA-Enquiry Header")
            {
                DataItemLink = "How You knew about us" = FIELD(Code);
                column(No; "ACA-Enquiry Header"."Enquiry No.")
                {
                }
                column(Date; "ACA-Enquiry Header"."Enquiry Date")
                {
                }
                column(SName; "ACA-Enquiry Header".Surname)
                {
                }
                column(ONames; "ACA-Enquiry Header"."Other Names")
                {
                }
                column(Programme; "ACA-Enquiry Header".Programmes)
                {
                }
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

