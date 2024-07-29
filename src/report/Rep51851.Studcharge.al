report 51851 "Stud charge"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Stud charge.rdl';

    dataset
    {
        dataitem("ACA-Stage Charges"; "ACA-Stage Charges")
        {

            trigger OnAfterGetRecord()
            begin
                "ACA-Stage Charges"."Settlement Type" := 'JAB';
                "ACA-Stage Charges".MODIFY;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('done');
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

