report 50180 Abcd
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Abcd.rdl';

    dataset
    {
        dataitem(AC; "ACA-Stage Charges")
        {
            column(a; AC."Programme Code")
            {
            }
            column(b; AC."Stage Code")
            {
            }
            column(c; AC."Settlement Type")
            {
            }
            column(d; AC."Student Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                AC."Student Type" := AC."Student Type"::"Full Time";
                AC.MODIFY;
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

