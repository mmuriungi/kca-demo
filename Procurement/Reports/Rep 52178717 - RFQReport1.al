report 52178717 "RFQ Report 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Procurement/Reports/SSR/RFQReport1.rdl';

    dataset
    {
        dataitem(ReqHeader; "PROC-Purchase Quote Header")
        {
            RequestFilterFields = "No.";
            column(ExpectedClosingDateII_ReqHeader; "Expected Closing Date II")
            {
            }
            column(ExpectedOpeningDateII_ReqHeader; "Expected Opening Date II")
            {
            }
            column(BidderSupplier_ReqHeader; "Bidder/Supplier")
            {
            }
            column(OrderNo_ReqHeader; "Order No.")
            {
            }
            column(PrequalificationPeriod_ReqHeader; "Prequalification Period")
            {
            }
            column(Description_ReqHeader; Description)
            {
            }
            column(SuppliersCategory_ReqHeader; "Suppliers Category")
            {
            }

            column(No_ReqHeader; ReqHeader."No.")
            {
            }
            column(Title_ReqHeader; ReqHeader."Category Description")
            {
            }
            column(RequisitionNo_ReqHeader; ReqHeader."No.")
            {
            }

            column(CreationDate_ReqHeader; ReqHeader."Document Date")
            {
            }
            column(UserID_ReqHeader; ReqHeader."Created By")
            {
            }
            column(ProcurementMethod_ReqHeader; ReqHeader."Procurement Methods")
            {
            }

            column(ReturnDate_ReqHeader; ReqHeader."Expected Closing Date")
            {
            }

            column(DocumentNo_ReqHeader; ReqHeader."No.")
            {
            }

            column(ExtendedDate_ReqHeader; ReqHeader."Expected Opening Date")
            {
            }

            column(IssuedDate_ReqHeader; ReqHeader."Document Date")
            {
            }

            column(Compname; info.Name)
            {
            }
            column(CompAddress; info.Address)
            {
            }
            column(CompPhone; info."Phone No.")
            {
            }
            column(CompLogo; info.Picture)
            {
            }
            column(CompMail; info."E-Mail")
            {
            }
            column(CompUrl; info."Home Page")
            {
            }
            dataitem(ReqLines; "PROC-Purchase Quote Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Description2_ReqLines; "Description 2")
                {
                }
                column(BuyfromVendorNo_ReqLines; "Buy-from Vendor No.")
                {
                }
                column(RequisitionNo_ReqLines; ReqLines."No.")
                {
                }
                column(LineNo_ReqLines; ReqLines."Line No.")
                {
                }
                column(Type_ReqLines; ReqLines.Type)
                {
                }
                column(No_ReqLines; ReqLines."No.")
                {
                }
                column(UnitofMeasureCode_ReqLines; "Unit of Measure Code")
                {
                }

                column(Description_ReqLines; ReqLines.Description)
                {
                }
                column(Quantity_ReqLines; ReqLines.Quantity)
                {
                }
                column(UnitofMeasure_ReqLines; ReqLines."Unit of Measure")
                {
                }
                column(UnitPrice_ReqLines; ReqLines."Unit Cost")
                {
                }
                column(Amount_ReqLines; ReqLines.Amount)
                {
                }

                column(SupplierCategory_ReqLines; ReqLines."Transaction Type")
                {
                }
                /* column(Ordered_ReqLines; ReqLines.)
                {
                }  */

                column(OrderDate_ReqLines; ReqLines."Order Date")
                {
                }

                dataitem(ProcItemSpecifications; "Proc Item Specifications")
                {
                    DataItemLink = "No." = field("Document No."), "Item No" = field("No.");

                    column(SNo_ProcItemSpecifications; "S/No")
                    {
                    }
                    column(ItemDescription; Description)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    Itemno := Itemno + 1;

                end;

                trigger OnPreDataItem()
                begin
                    Itemno := 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                info.GET();
                info.CALCFIELDS(Picture);

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
    Procedure GetNo(DocNo: Code[50]) No: Code[20];
    begin
        ItemSpecs.Reset();
        ItemSpecs.SetRange("No.", DocNo);
        if ItemSpecs.Find('-') then begin
            repeat
                SNo_ProcItemSpecifications := ItemSpecs."S/No";
                ItemDescription := ItemSpecs.Description;
            until ItemSpecs.Next() = 0;
        end;
    end;

    var
        SNo_ProcItemSpecifications: Code[20];
        info: Record "Company Information";
        Itemno: Integer;
        ItemDescription: Text;
        ProcHead: Record "Proc-Purchase Quote Header";
        ProcLines: Record "Proc-Purchase Quote Line";
        ItemSpecs: Record "Proc Item Specifications";
}

