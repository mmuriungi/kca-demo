report 53038 "Sales By Sales Person/Month"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sales By Sales PersonMonth.rdl';

    dataset
    {
        dataitem(SalesHeader; "Sales Invoice Header")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "User ID";//, "Posting Date", "Sell-to Customer No.", "No.";
            column(OderDate; SalesHeader."Order Date")
            {
            }
            column(MonthName; MonthName)
            {
            }
            column(docNo; SalesHeader."No.")
            {
            }
            column(CustNo; SalesHeader."Sell-to Customer No.")
            {
            }
            column(CustName; SalesHeader."Bill-to Name")
            {
            }
            column(SalesPerson; SalesHeader."Salesperson Code")
            {
            }
            column(PostingDate; SalesHeader."Posting Date")
            {
            }
            column(PostingDesc; SalesHeader."Posting Description")
            {
            }
            column(SalesPersonCode; SalesHeader."Salesperson Code")
            {
            }
            column(InvAmount; SalesHeader.Amount)
            {
            }
            column(CompAddress; info.Address)
            {
            }
            column(CompAddress1; info."Address 2")
            {
            }
            column(CompPhonenO; info."Phone No.")
            {
            }
            column(CompPhoneNo2; info."Phone No. 2")
            {
            }
            column(CompPic; info.Picture)
            {
            }
            column(CompEmail1; info."E-Mail")
            {
            }
            column(CompHome; info."Home Page")
            {
            }
            dataitem(SalesLines; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Quantity = FILTER(> 0),
                                          "No." = FILTER(<> ''));
                PrintOnlyIfDetail = false;
                column(SalesLineNo; SalesLines."Line No." / 100)
                {
                }
                column(SalesDocNo; SalesLines."Document No.")
                {
                }
                column(SalesItemNo; SalesLines."No.")
                {
                }
                column(SelesItemDesc; SalesLines.Description)
                {
                }
                column(LineAmountIncludingVAT; SalesLines."Amount Including VAT")
                {
                }
                column(LineAmount; SalesLines.Amount)
                {
                }
                column(SalesQuantity; SalesLines.Quantity)
                {
                }
                column(SalesUnitOfMeasure; SalesLines."Unit of Measure")
                {
                }
                column(SalesUnitPrice; SalesLines."Unit Price")
                {
                }
                column(SalesLineAmount; SalesLines."Unit Price" * SalesLines.Quantity)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //IF SalesLines."Line No.">99 THEN SalesLines."Line No.":=SalesLines."Line No."/100;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(MonthName);
                CLEAR(IntMonth);
                IntMonth := DATE2DMY(SalesHeader."Posting Date", 2);
                IF IntMonth <> 0 THEN BEGIN
                    IF IntMonth = 1 THEN BEGIN
                        MonthName := 'JAN';
                    END ELSE
                        IF IntMonth = 2 THEN BEGIN
                            MonthName := 'FEB';
                        END ELSE
                            IF IntMonth = 3 THEN BEGIN
                                MonthName := 'MAR';
                            END ELSE
                                IF IntMonth = 4 THEN BEGIN
                                    MonthName := 'APRIL';
                                END ELSE
                                    IF IntMonth = 5 THEN BEGIN
                                        MonthName := 'MAY';
                                    END ELSE
                                        IF IntMonth = 6 THEN BEGIN
                                            MonthName := 'JUNE';
                                        END ELSE
                                            IF IntMonth = 7 THEN BEGIN
                                                MonthName := 'JULY';
                                            END ELSE
                                                IF IntMonth = 8 THEN BEGIN
                                                    MonthName := 'AUG';
                                                END ELSE
                                                    IF IntMonth = 9 THEN BEGIN
                                                        MonthName := 'SEPT';
                                                    END ELSE
                                                        IF IntMonth = 10 THEN BEGIN
                                                            MonthName := 'OCT';
                                                        END ELSE
                                                            IF IntMonth = 11 THEN BEGIN
                                                                MonthName := 'NOV';
                                                            END ELSE
                                                                IF IntMonth = 12 THEN BEGIN
                                                                    MonthName := 'DEC';
                                                                END
                END;
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
        IF info.GET() THEN BEGIN
            info.CALCFIELDS(Picture);
        END;
    end;

    var
        info: Record "Company Information";
        route: Code[20];
        cust: Record Customer;
        MonthName: Code[20];
        IntMonth: Integer;
}

