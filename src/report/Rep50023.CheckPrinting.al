report 50023 "Check-Printing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Check-Printing.rdlc';

    dataset
    {
        dataitem(Payments; "FIN-Payments Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(FORMAT__Payment_Date__0_4_; FORMAT("Payment Release Date", 0, 4))
            {
            }
            column(Account_Name__________; '****' + Payee + '****')
            {
            }
            column(FORMAT_ROUND__Net_Amount__2___________; '****' + FORMAT(Payments."Total Net Amount") + '****')
            {
            }
            column(NumberText_1________NumberText_2_; NumberText[1] + ' ' + NumberText[2])
            {
            }
            column(Payments_No; "No.")
            {
            }
            column(ChequeAmounnt; Payments."Total Net Amount")
            {
            }
            column(ChequeNo_Payments; Payments."Cheque No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS(Payments."Total Net Amount");
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, Payments."Total Net Amount", '');
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Payments."No.");
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

    trigger OnPostReport()
    begin
        IF CurrReport.PREVIEW = FALSE THEN BEGIN

            //Payments."Cheque Raised":=TRUE;
            //Payments."Cheque Raised Date":=TODAY;
            // Payments."Cheque Raised Time":=TIME;
            //Payments."Cheque Raised By":=USERID;
            Payments."No. Printed" := Payments."No. Printed" + 1;

            IF BankRec.GET(Payments."Paying Bank Account") THEN BEGIN

                BankRec."Last Check No." := INCSTR(BankRec."Last Check No.");
                Payments."Cheque No." := BankRec."Last Check No.";
                BankRec.MODIFY;
            END;
            Payments.MODIFY;
        END;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Check: Report "Check-Printing";
        NumberText: array[2] of Text[80];
        CheckReport: Report 1401;
        BankRec: Record 270;
}

