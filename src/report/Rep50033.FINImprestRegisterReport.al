report 50033 "FIN-Imprest Register Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Finance/Reports/SSR/ImprestRegister.rdl';
    Caption = 'FIN-Imprest Register Report';
    UsageCategory = Administration;
    dataset
    {
        dataitem(FINImprestHeader; "FIN-Imprest Header")
        {
            DataItemTableView = where
            (Posted = filter(true));
            CalcFields = "Total Net Amount";
            column(AccountNo; "Account No.")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(Payment_Release_Date; Format("Payment Release Date")) { }
            column(ActualExpenditure; "Actual Expenditure")
            {
            }
            column(Expected_Date_of_Surrender; Format("Expected Date of Surrender")) { }
            column(DatePosted; "Date Posted")
            {
            }
            column(Total_Net_Amount; "Total Net Amount") { }
            column(Payee; Payee)
            {
            }
            column(Date; Format(Date))
            {

            }

            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(No_; "No.") { }
            column(DimValName; DimValName) { }
            column(Sn; Sn) { }
            dataitem(SurrenderLines; "FIN-Imprest Surrender Details")
            {
                CalcFields = "Doc No.";
                DataItemLink = "Doc No." = field("No.");
                column(Surrender_Date; Format("Surrender Date")) { }
                column(Currency_Code; "Currency Code") { }
                column(Amount; Amount) { }
                column(Cash_Receipt_No; "Cash Receipt No") { }
                column(Over_Expenditure; "Over Expenditure") { }
                column(Account_No_; "Account No:") { }
                column(OutstandingDays; OutstandingDays) { }
                column(Date_Cash_Collected; Format("Date Cash Collected")) { }
                trigger OnPreDataItem()
                begin
                    FINImprestHeader.SetFilter(Date, '%1..%2', Startdate, EndDate);
                end;

                trigger OnAfterGetRecord()
                begin
                    Clear(OutstandingDays);

                    DimVal.RESET;
                    DimVal.SETRANGE(DimVal."Dimension Code", 'DEPARTMENT');
                    DimVal.SETRANGE(DimVal.Code, "Shortcut Dimension 2 Code");
                    DimValName := '';
                    IF DimVal.FINDFIRST THEN BEGIN
                        DimValName := DimVal.Name;
                    END;
                    Sn := Sn + 1;
                    if FINImprestHeader."Surrender Status" = FINImprestHeader."Surrender Status"::" " then begin
                        DaysFromTodays := Today - FINImprestHeader.Date;
                        OutstandingDays := FINImprestHeader."Expected Date of Surrender" - TODAY;
                    end else
                        OutstandingDays := 0;

                end;



            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field("Stard Date"; Startdate)
                    {

                    }
                    field("End Date"; EndDate)
                    {

                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        Startdate: date;
        EndDate: date;
        Sn: Integer;
        FooterPrinted: Boolean;
        DimVal: Record "Dimension Value";
        DimValName: Text[100];
        Dimension: Record Dimension;
        FinReceipt: Record "FIN-Receipts Header";
        OutstandingDays: Integer;
        DaysFromTodays: Integer;

}
