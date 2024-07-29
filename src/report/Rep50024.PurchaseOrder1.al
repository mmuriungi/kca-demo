report 50024 "Purchase Order1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LPO Report.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem1; 38)
        {
            RequestFilterFields = "No.";
            column(PaytoVendorNo_PurchaseHeader; "Pay-to Vendor No.")
            {
            }
            column(PaytoName_PurchaseHeader; "Pay-to Name")
            {
            }
            column(PaytoName2_PurchaseHeader; "Pay-to Name 2")
            {
            }
            column(PaytoAddress_PurchaseHeader; "Pay-to Address")
            {
            }
            column(PaytoAddress2_PurchaseHeader; "Pay-to Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader; "Pay-to City")
            {
            }
            column(ShiptoCode_PurchaseHeader; "Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseHeader; "Ship-to Name")
            {
            }
            column(ShiptoName2_PurchaseHeader; "Ship-to Name 2")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Ship-to Address 2")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; "Expected Receipt Date")
            {
            }
            column(PostingDate_PurchaseHeader; "Posting Date")
            {
            }
            column(No_PurchaseHeader; "No.")
            {
            }
            column(LpoDuedate; "Due Date")
            {
            }
            column(CopyText; CopyText)
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Payment Terms Code")
            {
            }
            column(CurrencyCode_PurchaseHeader; "Currency Code")
            {
            }
            column(Amount_PurchaseHeader; Amount)
            {
            }
            column(AmountIncludingVAT_PurchaseHeader; "Amount Including VAT")
            {
            }
            column(TotalDiscountAmount; PurchLines."Line Discount Amount")
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(NoPrinted; "No. Printed")
            {
            }
            column(QuoteNo; "Quote No.")
            {
            }
            column(LPOText; LPOText)
            {
            }
            column(Department; "Shortcut Dimension 2 Code")
            {
            }
            dataitem(DataItem2; 39)
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                column(LineNo_PurchaseLine; "Line No.")
                {
                }
                column(LineAmount_PurchaseLine; "Line Amount")
                {
                }
                column(Decription3_PurchaseLine; "Description 3")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Direct Unit Cost")
                {
                }
                column(Quantity_PurchaseLine; Quantity)
                {
                }
                column(No_PurchaseLine; "No.")
                {
                }
                column(Description_PurchaseLine; Description)
                {
                }
                column(desc2; desc2)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Unit of Measure")
                {
                }
                column(LineDiscount_PurchaseLine; "Line Discount %")
                {
                }
                column(LineDiscountAmount_PurchaseLine; "Line Discount Amount")
                {
                }
                column(Unit_of_Measure_code; "Unit of Measure Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(desc2);
                    IF "Description 2" <> '' THEN desc2 := '(' + "Description 2" + ')';
                end;
            }
            dataitem(ApprovalEntry; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(ApproverID_ApprovalEntry; ApprovalEntry."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; format(ApprovalEntry."Last Date-Time Modified"))
                {
                }

                dataitem(UserSetUp; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(Signature_UserSetup; UserSetUp."User Signature")
                    {
                    }
                    column(ApprovalDesignation_UserSetup; UserSetUp."Approval Title")
                    {
                    }
                }

                trigger OnPreDataItem()
                begin
                    ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PurchLines.RESET;
                PurchLines.SETRANGE("Document Type", "Document Type");
                PurchLines.SETRANGE("Document No.", "No.");
                PurchLines.CALCSUMS("Line Discount Amount");
                CALCFIELDS("Amount Including VAT");
                //Amount into words
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, "Amount Including VAT", '');
                /*
                IF "No. Printed" = 0 THEN LPOText:= 'Suppliers copy'
                ELSE IF "No. Printed" = 1 THEN LPOText:= 'Accounts copy'
                ELSE IF "No. Printed" = 2 THEN LPOText:= 'Store copy'
                ELSE IF "No. Printed" = 3 THEN LPOText:= 'Files copy';
                  */
                GenLedgerSetup.GET;
                IF "Currency Code" = '' THEN "Currency Code" := GenLedgerSetup."LCY Code";
                IF "Quotation No." = '' THEN "Quotation No." := "Quote No.";

            end;

            trigger OnPostDataItem()
            begin
                IF CurrReport.PREVIEW = FALSE THEN BEGIN
                    "No. Printed" := "No. Printed" + 1;
                    MODIFY;
                END
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
        PurchaseOrderCaption = 'Purchase Order';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture)
    end;

    var
        CompanyInfo: Record 79;
        CopyText: Text;
        PurchLines: Record 39;
        NumberText: array[2] of Text[120];
        CheckReport: Report 1401;
        LPOText: Text;
        GenLedgerSetup: Record 98;
        desc2: Text[1024];
}

