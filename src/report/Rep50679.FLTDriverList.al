report 50679 "FLT Driver List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/FLT Driver List.rdl';
    Caption = 'FLT Driver List';

    dataset
    {
        dataitem("FLT-Driver"; "FLT-Driver")
        {
            column(driver; "FLT-Driver".Driver)
            {
            }
            column(DriveName; "FLT-Driver"."Driver Name")
            {
            }
            column(License; "FLT-Driver"."Driver License Number")
            {
            }
            // column(Grade; "FLT-Driver".Grade)
            // {
            // }
            column(RenDate; "FLT-Driver"."Last License Renewal")
            {
            }
            column(RenInterval; "FLT-Driver"."Renewal Interval")
            {
            }
            column(Ren_Value; "FLT-Driver"."Renewal Interval Value")
            {
            }
            column(Status; "FLT-Driver".Active)
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

