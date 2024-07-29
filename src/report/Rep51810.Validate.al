report 51810 Validate
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Validate.rdl';

    dataset
    {
        dataitem(cust; 18)
        {
            column(no; Cust."No.")
            {
            }
            column(name; Cust.Name)
            {
            }
            column(Gender; Cust.Gender)
            {
            }
            column(Dept; Cust."Global Dimension 2 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Gender > 1 THEN BEGIN
                    Gender := Gender - 1;
                    MODIFY;
                END;
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

    var
        unitofNeasure: Record "Item Unit of Measure";
}

