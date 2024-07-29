report 53045 "Sales Person/Month/Trans T."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sales PersonMonthTrans T..rdl';

    dataset
    {
        dataitem(SalesHeader; "Sales Shipment Header")
        {
            // DataItemTableView = WHERE("Cash Sale Order" = FILTER(true),
            // "User ID" = FILTER(<> 'WANJALA'));
            PrintOnlyIfDetail = false;
            //RequestFilterFields = "Sell-to Customer No.", "Posting Date", "No.", "User ID";
            column(OderDate; SalesHeader."Posting Date")
            {
            }
            column(TransType; TransType)
            {
            }
            column(seq; seq)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
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
            column(InvAmount; SalesHeader."Document Amount")
            {
            }
            column(Users; SalesHeader."User ID")
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
            column(filters; SalesHeader.GETFILTERS)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(MonthName);
                CLEAR(IntMonth);
                CLEAR(TransType);
                IF SalesHeader."Credit Sale" = TRUE THEN TransType := 'CREDIT' ELSE TransType := 'CASH';
                seq := seq + 1;
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

            trigger OnPreDataItem()
            begin
                SalesHeader.SETRANGE("Posting Date", StartDate, EndDate);
                SalesHeader.SETCURRENTKEY("Posting Date");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(DateFilters)
                {
                    Caption = 'Date Range';
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date:';
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date:';
                    }
                }
            }
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

        CLEAR(seq);
    end;

    trigger OnPreReport()
    begin
        IF ((StartDate = 0D) OR (EndDate = 0D)) THEN ERROR('Specify date range');
    end;

    var
        info: Record "Company Information";
        route: Code[20];
        cust: Record Customer;
        MonthName: Code[20];
        IntMonth: Integer;
        StartDate: Date;
        EndDate: Date;
        seq: Integer;
        TransType: Code[20];
}

