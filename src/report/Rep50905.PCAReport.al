report 50905 "PCA Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PCA Report.rdlc';

    dataset
    {
        dataitem(DataItem1; "prEmployee Trans PCA")
        {
            RequestFilterFields = "Start Date";
            column(EmployeeCode_prEmployeeTransPCA; "Employee Code")
            {
            }
            column(TransactionCode_prEmployeeTransPCA; "Transaction Code")
            {
            }
            column(TransactionName_prEmployeeTransPCA; "Transaction Name")
            {
            }
            column(Amount_prEmployeeTransPCA; Amount)
            {
            }
            column(CompLogo; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(EndDate_prEmployeeTransPCA; "Start Date")
            {
            }

            trigger OnPreDataItem()
            begin
                CompInf.GET;
                CompInf.CALCFIELDS(CompInf.Picture);
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
        CompInf: Record 79;
}

