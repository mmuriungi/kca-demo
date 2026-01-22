xmlport 50007 "Leave Allocations"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(ledger; "HRM-Leave Ledger")
            {

                fieldelement(a1; ledger."Entry No.")
                {
                }
                fieldelement(a2; ledger."Employee No")
                {
                }
                fieldelement(a3; ledger."No. of Days")
                {
                }
                fieldelement(a4; ledger."Document No")
                {
                }
                fieldelement(a5; ledger."Entry Type")
                {
                }
                fieldelement(a6; ledger."Transaction Type")
                {
                }
                fieldelement(a7; ledger."Transaction Date")
                {
                }
                fieldelement(a8; ledger."Transaction Description")
                {
                }
                fieldelement(a9; ledger."Leave Period")
                {
                }
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

