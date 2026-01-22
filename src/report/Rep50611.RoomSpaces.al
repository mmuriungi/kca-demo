report 50611 "Room Spaces"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Room Spaces.rdl';

    dataset
    {
        dataitem(AS; "ACA-Room Spaces")
        {
            column(host; AS."Hostel Code")
            {
            }
            column(room; AS."Room Code")
            {
            }
            column(spc; AS."Space Code")
            {
            }
            column(cost; AS."Room Cost")
            {
            }

            trigger OnAfterGetRecord()
            begin
                AS."Room Cost" := 5500;
                MODIFY;
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

