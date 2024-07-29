report 53035 "Graphical Cust. Invoices"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Graphical Cust. Invoices.rdl';

    dataset
    {
        dataitem(SalesHeader; "Sales Invoice Header")
        {
            PrintOnlyIfDetail = true;
            // RequestFilterFields = "Sell-to Customer No.", "Posting Date", "No.";
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(OderDate; SalesHeader."Order Date")
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

            trigger OnPreDataItem()
            begin
                SalesHeader.SETRANGE("Posting Date", StartDate, EndDate);
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
                    Caption = 'Date Filter';
                    field(strsDate; StartDate)
                    {
                        Caption = 'Start Date';
                    }
                    field(endDate; EndDate)
                    {
                        Caption = 'End Date';
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
    end;

    trigger OnPreReport()
    begin
        IF ((StartDate = 0D) OR (EndDate = 0D)) THEN ERROR('Specify begining and end date');
        IF StartDate > EndDate THEN ERROR('Invalid start date!');
    end;

    var
        info: Record "Company Information";
        route: Code[20];
        cust: Record "Customer";
        StartDate: Date;
        EndDate: Date;
}

