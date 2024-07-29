report 51027 "Update Leave Entries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Reports/SSR/Update Leave Entries.rdl';

    dataset
    {
        dataitem("HRM-Back To Office Form";"HRM-Back To Office Form")
        {

            trigger OnAfterGetRecord()
            begin
                          Delete;
            end;

            trigger OnPostDataItem()
            begin
                Message('All Deleted!!');
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

    trigger OnPreReport()
    begin
         Clear(seq);
    end;

    var
        seq: Integer;
}

