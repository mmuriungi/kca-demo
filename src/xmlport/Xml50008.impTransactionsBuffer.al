xmlport 50008 "imp. Transactions Buffer"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Trans; "HRM-Emp. Trans. Adjst Buffer")
            {

                fieldelement(TransactionCode; Trans."Transaction Code")
                {
                }
                fieldelement(EmployeeNo; Trans."Employee No")
                {
                }
                fieldelement(Period; Trans.Period)
                {
                }
                fieldelement(Amount; Trans.Amount)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    //Programme."School Code":='003';
                end;
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
}

