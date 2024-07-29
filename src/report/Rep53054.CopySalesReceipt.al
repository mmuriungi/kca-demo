report 53054 "Copy Sales Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Copy Sales Receipt.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            PrintOnlyIfDetail = true;
            column(CompName; compInfo.Name)
            {
            }
            column(CompAddress; compInfo.Address)
            {
            }
            column(CompCity; compInfo.City)
            {
            }
            column(CompPhone; compInfo."Phone No.")
            {
            }
            column(CompMail; compInfo."E-Mail")
            {
            }
            column(CompWeb; compInfo."Home Page")
            {
            }
            column(Logo; compInfo.Picture)
            {
            }
            column(UserNames; UserName)
            {
            }
            column(CompPostCode; compInfo."Post Code")
            {
            }
            column(ReceiptNo; "Sales Shipment Header"."No.")
            {
            }
            column(PostingDate; "Sales Shipment Header"."Posting Date")
            {
            }
            /*  column(AmPaid; "Sales Shipment Header"."Amount Paid")
             {
             }
             column(DocumentAmount; "Sales Shipment Header"."Document Amount")
             {
             }
             column(Balance; "Sales Shipment Header"."Amount Paid" - "Sales Shipment Header"."Document Amount")
             {
             } */
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ItemNo; "Sales Shipment Line"."No.")
                {
                }
                column(ItemDesc; "Sales Shipment Line".Description)
                {
                }
                column(Qty; "Sales Shipment Line".Quantity)
                {
                }
                column(UnitPrice; "Sales Shipment Line"."Unit Price")
                {
                }
                column(LineAmount; "Sales Shipment Line"."Unit Price" * "Sales Shipment Line".Quantity)
                {
                }
                column(seq; seq)
                {
                }
                column(seq2; seq2)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    seq := seq + 1;
                    seq2 := seq2 + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Sales Shipment Header".CalcFields("Sales Shipment Header"."Document date");
                seq := 0;
                Clear(UserName);
                Users.Reset;
                Users.SetRange(Users."User Name", UserId);
                if Users.Find('-') then begin
                    if Users."Full Name" <> '' then
                        UserName := Users."Full Name" else
                        UserName := Users."User Name";
                end;
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
        if compInfo.Get() then begin
            compInfo.CalcFields(Picture);
        end;
        Clear(seq);
        Clear(seq2);
    end;

    var
        compInfo: Record "Company Information";
        seq: Integer;
        datefilter: Text[30];
        seq2: Integer;
        Users: Record User;
        UserName: Text[130];
}

