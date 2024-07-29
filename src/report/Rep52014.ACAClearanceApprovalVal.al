report 52014 "ACA-Clearance Approval Val"
{
    ProcessingOnly = true;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ACA-Clearance Approval Val.rdl';

    dataset
    {
        dataitem("ACA-Clearance Approval Entries"; "ACA-Clearance Approval Entries")
        {
            DataItemTableView = WHERE("Priority Level" = FILTER("Final level"),
                                      Status = FILTER(Created));

            trigger OnAfterGetRecord()
            begin
                "ACA-Clearance Approval Entries".Status := "ACA-Clearance Approval Entries".Status::Open;
                "ACA-Clearance Approval Entries".MODIFY;
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

