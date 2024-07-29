/// <summary>
/// Report In-bound Mails (ID 52178558).
/// </summary>
report 55101 "In-bound Mails"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/In-bound Mails.rdl';
    Caption = 'In-bound Mails';

    dataset
    {
        dataitem(DataItem1; "REG-Mail Register")
        {
            DataItemTableView = WHERE("Direction Type" = FILTER('Incoming Mail (Internal)' | 'Incoming Mail (External)'));
            column(no; No)
            {
            }
            column(subjDoc; "Subject of Doc.")
            {
            }
            column(maildate; "Mail Date")
            {
            }
            column(address; Addressee)
            {
            }
            column(mailtime; "mail Time")
            {
            }
            column(rec; Receiver)
            {
            }
            column(addtype; "Addresee Type")
            {
            }
            column(comment; Comments)
            {
            }
            column(doctype; "Doc type")
            {
            }
            column(dispBy; "Dispatched by")
            {
            }
            column(email; Email)
            {
            }
            column(ref; "Doc Ref No.")
            {
            }
            column(delBy; "Delivered By (Mail)")
            {
            }
            column(DelPhone; "Delivered By (Phone)")
            {
            }
            column(DelName; "Delivered By (Name)")
            {
            }
            column(DelID; "Delivered By (ID)")
            {
            }
            column(DelTown; "Delivered By (Town)")
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

