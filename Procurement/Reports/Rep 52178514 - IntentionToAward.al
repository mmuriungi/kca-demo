report 52178514 "Intention To Award"
{
    RDLCLayout = './Procurement/Reports/Ssr/Intention To Award.rdl';
    DefaultLayout = RDLC;
    Caption = 'Intention To Award';
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "Request for Quote No.";

            column(No_PurchaseHeader; "No.")
            {
            }
            column(BuyfromAddress_PurchaseHeader; "Buy-from Address")
            {
            }
            column(BuyfromVendorName_PurchaseHeader; "Buy-from Vendor Name")
            {
            }
            column(BuyfromContactNo_PurchaseHeader; "Buy-from Contact No.")
            {
            }
            column(BuyfromContact_PurchaseHeader; "Buy-from Contact")
            {
            }
            column(BidAmount; BidAmount)
            {

            }
            dataitem("Proc-Intention To Award"; "Proc-Intention To Award")
            {
                dataitemLink = "No." = field("Request for Quote No.");
                column(BidderNo_ProcIntentionToAward; "Bidder No")
                {
                }
                column(No_ProcIntentionToAward; "No.")
                {
                }
                column(StandstillEnd_ProcIntentionToAward; "Standstill End")
                {
                }
                column(SupplierNo_ProcIntentionToAward; "Supplier No")
                {
                }
                column(SupplierName_ProcIntentionToAward; "Supplier Name")
                {
                }
                column(TenderAmount_ProcIntentionToAward; "Tender Amount")
                {
                }
                column(Address_ProcIntentionToAward; Address)
                {
                }
                column(Email_ProcIntentionToAward; Email)
                {
                }
                column(Name_ProcIntentionToAward; Name)
                {
                }
                column(PhoneNo_ProcIntentionToAward; "Phone No")
                {
                }
                column(Compinfopic; Compinfo.Picture)
                {

                }
                column(Compinfoname; Compinfo.Name)
                {

                }
                column(Compinfoaddress; Compinfo.Address)
                {

                }
                column(CompinfoPhone; Compinfo."Phone No.")
                {

                }
                column(Compinfoemail; Compinfo."E-Mail")
                {

                }
                column(Compinfowebpage; Compinfo."Home Page")
                {

                }
                dataitem(Purchasequote; "Proc-Purchase Quote Header")
                {
                    DataItemLink = "No." = field("No.");
                    column(AwardedBId_Purchasequote; "Awarded BId")
                    {
                    }
                    column(Description_Purchasequote; Description)
                    {
                    }
                    column(ExpectedOpeningDate_Purchasequote; "Expected Opening Date")
                    {
                    }
                    column(FinancialEvaluationScore_Purchasequote; "Financial Evaluation Score")
                    {
                    }
                    column(No_Purchasequote; "No.")
                    {
                    }
                    column(CategoryDescription_Purchasequote; "Category Description")
                    {
                    }
                    column(Procurementmethods_Purchasequote; "Procurement methods")
                    {
                    }
                    column(SuppliersCategory_Purchasequote; "Suppliers Category")
                    {
                    }
                    column(Tenderdesc; Description)
                    {

                    }
                    column(Openingdate; "Expected Opening Date")
                    {

                    }
                    trigger OnAfterGetRecord()
                    begin
                        CalcFields("Financial Evaluation Score");
                        Purchasequote.Reset();
                        Purchasequote.SetRange("No.", "Proc-Intention To Award"."No.");
                        if Purchasequote.Find('-') then begin
                            Tenderdesc := Purchasequote.Description;
                            Openingdate := Purchasequote."Expected Opening Date";
                        end;
                    end;

                }

            }
            trigger OnAfterGetRecord()
            begin
                Pline.Reset();
                Pline.SetRange("Document No.", "Purchase Header"."No.");
                if Pline.Find('-') then begin
                    Pline.CalcSums("Line Amount");
                    BidAmount := Pline."Line Amount";
                end;
            end;

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
    trigger OnInitReport()
    begin
        Compinfo.get();
        Compinfo.CalcFields(Picture);
    end;


    var
        Compinfo: Record "Company Information";
        BidderNo: Code[50];
        sno: Integer;
        Tenderdesc: Text[500];
        bidsno: Integer;
        Openingdate: DateTime;
        Pline: Record "Purchase Line";
        BidAmount: Decimal;
}
