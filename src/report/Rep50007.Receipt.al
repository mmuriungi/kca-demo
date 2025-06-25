report 50007 Receipt
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Receipts Reports.rdlc';

    dataset
    {
        dataitem("FIN-Receipts Header"; "FIN-Receipts Header")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1102755004; 1102755004)
            {
            }
            column(HeaderNo; "FIN-Receipts Header"."No.")
            {
            }
            column(HeaderDate; "FIN-Receipts Header".Date)
            {
            }
            column(UserID; "FIN-Receipts Header".Cashier)
            {
            }
            column(AcctName; AcctName)
            {
            }
            column(RegNo; RegNo)
            {
            }
            column(rec; "FIN-Receipts Header"."Received From")
            {
            }
            dataitem("FIN-Receipt Line q"; "FIN-Receipt Line q")
            {
                DataItemLink = No = field("No.");
                column(ReportForNavId_1102755006; 1102755006)
                {
                }
                column(RecLineNo; "FIN-Receipt Line q"."Account No.")
                {
                }
                column(RecLineAcctName; "FIN-Receipt Line q"."Account Name")
                {
                }
                column(Amount; "FIN-Receipt Line q".Amount)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(NumberText_1_; NumberText[1])
                {
                }
                column(PayMode; "FIN-Receipt Line q"."Pay Mode")
                {
                }
                column(ReceivedFrom; "FIN-Receipt Line q"."Received From")
                {
                }
                column(Cheque; "FIN-Receipt Line q"."Cheque/Deposit Slip No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalAmount := TotalAmount + "FIN-Receipt Line q".Amount;
                    if "FIN-Receipt Line q"."Received From" = '' then "Received From" := "FIN-Receipts Header"."Received From";
                    if "FIN-Receipt Line q"."Received From" = '' then "Received From" := "FIN-Receipts Header"."On Behalf Of";

                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText(NumberText, TotalAmount, '');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Received From" = '' then "Received From" := "FIN-Receipts Header"."On Behalf Of";
                TotalAmount := 0;
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
        AcctName: Text[150];
        RegNo: Code[30];
        NumberText: array[2] of Text[120];
        CheckReport: Report Check;
        TotalAmount: Decimal;
}

