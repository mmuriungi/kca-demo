report 50200 "Oll prog"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Oll prog.rdl';

    dataset
    {
        dataitem("ACA-Old Programmes"; "ACA-Old Programmes")
        {

            trigger OnAfterGetRecord()
            begin
                "ACA-Old Programmes".CALCFIELDS("New Code FK");
                "ACA-Old Programmes"."New Code" := "ACA-Old Programmes"."New Code FK";
                "ACA-Old Programmes".MODIFY;
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

