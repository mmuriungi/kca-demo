report 53033 "Det. Invoices (Customer&Inv.)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Det. Invoices (Customer&Inv.).rdl';

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            PrintOnlyIfDetail = true;
            ///RequestFilterFields = "Sell-to Customer No.", "Posting Date", "No.";
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
            dataitem(SalesLines; "Sales Line")
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
        cust: Record "Customer";
}

