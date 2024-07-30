report 54207 "Visitors Per Department"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Visitors Per Department.rdl';
    Caption = 'Visitors Per Department';

    dataset
    {
        dataitem(DataItem1000000024; "Dimension Value")
        {
            //DataItemTableView = WHERE("Dimension Code"=FILTER(Code));
            PrintOnlyIfDetail = true;
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
            column(DeptName; Name)
            {
            }
            column(DeptCode; Code)
            {
            }
            dataitem(DataItem1000000000; "Visitors Ledger")
            {
                DataItemLink = "Office Station/Department" = FIELD(Code);
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
                column(seq; seq)
                {
                }
                column(seq2; seq2)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    seq := seq + 1;
                    seq2 := seq2 + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                seq := 0;
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
        CLEAR(seq2);
    end;

    var
        compInfo: Record "Company Information";
        seq: Integer;
        datefilter: Text[30];
        seq2: Integer;
}

