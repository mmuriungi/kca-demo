report 50741 Labreport
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Labreport.rdl';

    dataset
    {
        dataitem(DataItem1000000000; "HMS-Laboratory Form Header")
        {
            column(LabNo; "Laboratory No.")
            {
            }
            column(PatNO; "Patient No.")
            {
            }
            column(date; "Laboratory Date")
            {
            }
            column(StudNO; "Student No.")
            {
            }
            column(EmpNo; "Employee No.")
            {
            }
            column(ID; "ID Number")
            {
            }
            column(LabNos; "Lab. Reference No.")
            {
            }
            column(Noseries; "No. Series")
            {
            }
            column(Remarks; Remarks)
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

