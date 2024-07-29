report 54206 "Visitors Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Security/Reports/SSR/Visitors Register.rdl';
    Caption = 'Visitors Register';

    dataset
    {
        dataitem(DataItem1000000000; "Visitors Ledger")
        {
            column(VisitNo; "Visit No.")
            {
            }
            column(TransDate; "Transaction Date")
            {
            }
            column(IdNo; "ID No.")
            {
            }
            column(FullName; "Full Name")
            {
            }
            column(Phone; "Phone No.")
            {
            }
            column(Email; Email)
            {
            }
            column(Company; Company)
            {
            }
            column(Dept; "Office Station/Department")
            {
            }
            column(InBy; "Signed in by")
            {
            }
            column(TimeIn; "Time In")
            {
            }
            column(OutBy; "Signed Out By")
            {
            }
            column(TimeOut; "Time Out")
            {
            }
            column(Comment; Comment)
            {
            }
            column(CheckedOut; "Checked Out")
            {
            }
            column(CompName; compInfo.Name)
            {
            }
            column(CompAddress; compInfo.Address)
            {
            }
            column(CompCity; compInfo.City)
            {
            }
            column(CompPhone; compInfo."Phone No.")
            {
            }
            column(CompMail; compInfo."E-Mail")
            {
            }
            column(CompWeb; compInfo."Home Page")
            {
            }
            column(Logo; compInfo.Picture)
            {
            }
            column(CompPostCode; compInfo."Post Code")
            {
            }
            column(seq; seq)
            {
            }

            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
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

    trigger OnInitReport()
    begin
        IF compInfo.GET() THEN BEGIN
            compInfo.CALCFIELDS(Picture);
        END;
        CLEAR(seq);
    end;

    var
        compInfo: Record "Company Information";
        seq: Integer;
        datefilter: Text[30];
}

