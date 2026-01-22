report 50012 "General Journal Report"
{
    Caption = 'General Journal Report';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/GeneralJournalReport.rdlc';
    ;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Gen. Journal Line"; "General Journal Archive")
        {
            RequestFilterFields = "Journal Batch Name", "Document No.", "Posting Date";
            CalcFields = Posted;
            column(CompInfo_pic; CompInfo.Picture)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Address; CompInfo.Address)
            {
            }
            column(CompInfo_City; CompInfo.City)
            {
            }
            column(CompInfo_email; CompInfo."E-Mail")
            {
            }
            column(AccountId_GenJournalLine; "Account Id")
            {
            }
            column(AccountNo_GenJournalLine; "Account No.")
            {
            }
            column(AccountType_GenJournalLine; "Account Type")
            {
            }
            column(AdditionalCurrencyPosting_GenJournalLine; "Additional-Currency Posting")
            {
            }
            column(AllocAccModifiedbyUser_GenJournalLine; "Alloc. Acc. Modified by User")
            {
            }
            column(AllocatedAmtLCY_GenJournalLine; "Allocated Amt. (LCY)")
            {
            }
            column(AllocationAccountNo_GenJournalLine; "Allocation Account No.")
            {
            }
            column(AllowApplication_GenJournalLine; "Allow Application")
            {
            }
            column(AllowZeroAmountPosting_GenJournalLine; "Allow Zero-Amount Posting")
            {
            }
            column(Amount_GenJournalLine; Amount)
            {
            }
            column(AmountLCY_GenJournalLine; "Amount (LCY)")
            {
            }
            column(AppliedAutomatically_GenJournalLine; "Applied Automatically")
            {
            }
            column(AppliestoDocNo_GenJournalLine; "Applies-to Doc. No.")
            {
            }
            column(AppliestoDocType_GenJournalLine; "Applies-to Doc. Type")
            {
            }
            column(AppliestoExtDocNo_GenJournalLine; "Applies-to Ext. Doc. No.")
            {
            }
            column(AppliestoID_GenJournalLine; "Applies-to ID")
            {
            }
            column(AppliestoInvoiceId_GenJournalLine; "Applies-to Invoice Id")
            {
            }
            column(BalAccountNo_GenJournalLine; "Bal. Account No.")
            {
            }
            column(BalAccountType_GenJournalLine; "Bal. Account Type")
            {
            }
            column(BalGenBusPostingGroup_GenJournalLine; "Bal. Gen. Bus. Posting Group")
            {
            }
            column(BalGenPostingType_GenJournalLine; "Bal. Gen. Posting Type")
            {
            }
            column(BalGenProdPostingGroup_GenJournalLine; "Bal. Gen. Prod. Posting Group")
            {
            }
            column(BalNonDedVAT_GenJournalLine; "Bal. Non-Ded. VAT %")
            {
            }
            column(BalNonDedVATAmount_GenJournalLine; "Bal. Non-Ded. VAT Amount")
            {
            }
            column(BalNonDedVATAmountLCY_GenJournalLine; "Bal. Non-Ded. VAT Amount LCY")
            {
            }
            column(BalNonDedVATBase_GenJournalLine; "Bal. Non-Ded. VAT Base")
            {
            }
            column(BalNonDedVATBaseLCY_GenJournalLine; "Bal. Non-Ded. VAT Base LCY")
            {
            }
            column(BalTaxAreaCode_GenJournalLine; "Bal. Tax Area Code")
            {
            }
            column(BalTaxGroupCode_GenJournalLine; "Bal. Tax Group Code")
            {
            }
            column(BalTaxLiable_GenJournalLine; "Bal. Tax Liable")
            {
            }
            column(BalUseTax_GenJournalLine; "Bal. Use Tax")
            {
            }
            column(BalVAT_GenJournalLine; "Bal. VAT %")
            {
            }
            column(BalVATAmount_GenJournalLine; "Bal. VAT Amount")
            {
            }
            column(BalVATAmountLCY_GenJournalLine; "Bal. VAT Amount (LCY)")
            {
            }
            column(BalVATBaseAmount_GenJournalLine; "Bal. VAT Base Amount")
            {
            }
            column(BalVATBaseAmountLCY_GenJournalLine; "Bal. VAT Base Amount (LCY)")
            {
            }
            column(BalVATBusPostingGroup_GenJournalLine; "Bal. VAT Bus. Posting Group")
            {
            }
            column(BalVATCalculationType_GenJournalLine; "Bal. VAT Calculation Type")
            {
            }
            column(BalVATDifference_GenJournalLine; "Bal. VAT Difference")
            {
            }
            column(BalVATProdPostingGroup_GenJournalLine; "Bal. VAT Prod. Posting Group")
            {
            }
            column(BalanceLCY_GenJournalLine; "Balance (LCY)")
            {
            }
            column(BalanceAccountId_GenJournalLine; "Balance Account Id")
            {
            }
            column(BankPaymentType_GenJournalLine; "Bank Payment Type")
            {
            }
            column(BilltoPaytoNo_GenJournalLine; "Bill-to/Pay-to No.")
            {
            }
            column(BudgetedFANo_GenJournalLine; "Budgeted FA No.")
            {
            }
            column(BusinessUnitCode_GenJournalLine; "Business Unit Code")
            {
            }
            column(CampaignNo_GenJournalLine; "Campaign No.")
            {
            }
            column(CheckExported_GenJournalLine; "Check Exported")
            {
            }
            column(CheckPrinted_GenJournalLine; "Check Printed")
            {
            }
            column(CheckTransmitted_GenJournalLine; "Check Transmitted")
            {
            }
            column(Comment_GenJournalLine; Comment)
            {
            }
            column(ContactGraphId_GenJournalLine; "Contact Graph Id")
            {
            }
            column(CopyVATSetuptoJnlLines_GenJournalLine; "Copy VAT Setup to Jnl. Lines")
            {
            }
            column(Correction_GenJournalLine; Correction)
            {
            }
            column(CountryRegionCode_GenJournalLine; "Country/Region Code")
            {
            }
            column(CreditAmount_GenJournalLine; "Credit Amount")
            {
            }
            column(CreditorNo_GenJournalLine; "Creditor No.")
            {
            }
            column(CurrencyCode_GenJournalLine; "Currency Code")
            {
            }
            column(CurrencyFactor_GenJournalLine; "Currency Factor")
            {
            }
            column(CustomerId_GenJournalLine; "Customer Id")
            {
            }
            column(DataExchEntryNo_GenJournalLine; "Data Exch. Entry No.")
            {
            }
            column(DataExchLineNo_GenJournalLine; "Data Exch. Line No.")
            {
            }
            column(DebitAmount_GenJournalLine; "Debit Amount")
            {
            }
            column(DeferralCode_GenJournalLine; "Deferral Code")
            {
            }
            column(DeferralLineNo_GenJournalLine; "Deferral Line No.")
            {
            }
            column(DeprAcquisitionCost_GenJournalLine; "Depr. Acquisition Cost")
            {
            }
            column(DepruntilFAPostingDate_GenJournalLine; "Depr. until FA Posting Date")
            {
            }
            column(DepreciationBookCode_GenJournalLine; "Depreciation Book Code")
            {
            }
            column(Description_GenJournalLine; Description)
            {
            }
            column(DimensionSetID_GenJournalLine; "Dimension Set ID")
            {
            }
            column(DirectDebitMandateID_GenJournalLine; "Direct Debit Mandate ID")
            {
            }
            column(DocumentDate_GenJournalLine; "Document Date")
            {
            }
            column(DocumentNo_GenJournalLine; "Document No.")
            {
            }
            column(DocumentType_GenJournalLine; "Document Type")
            {
            }
            column(DueDate_GenJournalLine; "Due Date")
            {
            }
            column(DuplicateinDepreciationBook_GenJournalLine; "Duplicate in Depreciation Book")
            {
            }
            column(EU3PartyTrade_GenJournalLine; "EU 3-Party Trade")
            {
            }
            column(ExpirationDate_GenJournalLine; "Expiration Date")
            {
            }
            column(ExportedtoPaymentFile_GenJournalLine; "Exported to Payment File")
            {
            }
            column(ExternalDocumentNo_GenJournalLine; "External Document No.")
            {
            }
            column(FAAddCurrencyFactor_GenJournalLine; "FA Add.-Currency Factor")
            {
            }
            column(FAErrorEntryNo_GenJournalLine; "FA Error Entry No.")
            {
            }
            column(FAGLAccountNo_GenJournalLine; "FA G/L Account No.")
            {
            }
            column(FAPostingDate_GenJournalLine; "FA Posting Date")
            {
            }
            column(FAPostingType_GenJournalLine; "FA Posting Type")
            {
            }
            column(FAReclassificationEntry_GenJournalLine; "FA Reclassification Entry")
            {
            }
            column(FinancialVoid_GenJournalLine; "Financial Void")
            {
            }
            column(GenBusPostingGroup_GenJournalLine; "Gen. Bus. Posting Group")
            {
            }
            column(GenPostingType_GenJournalLine; "Gen. Posting Type")
            {
            }
            column(GenProdPostingGroup_GenJournalLine; "Gen. Prod. Posting Group")
            {
            }
            column(HasPaymentExportError_GenJournalLine; "Has Payment Export Error")
            {
            }
            column(ICAccountNo_GenJournalLine; "IC Account No.")
            {
            }
            column(ICAccountType_GenJournalLine; "IC Account Type")
            {
            }
            column(ICDirection_GenJournalLine; "IC Direction")
            {
            }
            column(ICPartnerCode_GenJournalLine; "IC Partner Code")
            {
            }

            column(ICPartnerTransactionNo_GenJournalLine; "IC Partner Transaction No.")
            {
            }
            column(IncomingDocumentEntryNo_GenJournalLine; "Incoming Document Entry No.")
            {
            }
            column(IndexEntry_GenJournalLine; "Index Entry")
            {
            }
            column(InsuranceNo_GenJournalLine; "Insurance No.")
            {
            }
            column(InvDiscountLCY_GenJournalLine; "Inv. Discount (LCY)")
            {
            }
            column(InvoiceReceivedDate_GenJournalLine; "Invoice Received Date")
            {
            }
            column(JobCurrencyCode_GenJournalLine; "Job Currency Code")
            {
            }
            column(JobCurrencyFactor_GenJournalLine; "Job Currency Factor")
            {
            }
            column(JobLineAmount_GenJournalLine; "Job Line Amount")
            {
            }
            column(JobLineAmountLCY_GenJournalLine; "Job Line Amount (LCY)")
            {
            }
            column(JobLineDiscAmountLCY_GenJournalLine; "Job Line Disc. Amount (LCY)")
            {
            }
            column(JobLineDiscount_GenJournalLine; "Job Line Discount %")
            {
            }
            column(JobLineDiscountAmount_GenJournalLine; "Job Line Discount Amount")
            {
            }
            column(JobLineType_GenJournalLine; "Job Line Type")
            {
            }
            column(JobNo_GenJournalLine; "Job No.")
            {
            }
            column(JobPlanningLineNo_GenJournalLine; "Job Planning Line No.")
            {
            }
            column(JobQuantity_GenJournalLine; "Job Quantity")
            {
            }
            column(JobQueueEntryID_GenJournalLine; "Job Queue Entry ID")
            {
            }
            column(JobQueueStatus_GenJournalLine; "Job Queue Status")
            {
            }
            column(JobRemainingQty_GenJournalLine; "Job Remaining Qty.")
            {
            }
            column(JobTaskNo_GenJournalLine; "Job Task No.")
            {
            }
            column(JobTotalCost_GenJournalLine; "Job Total Cost")
            {
            }
            column(JobTotalCostLCY_GenJournalLine; "Job Total Cost (LCY)")
            {
            }
            column(JobTotalPrice_GenJournalLine; "Job Total Price")
            {
            }
            column(JobTotalPriceLCY_GenJournalLine; "Job Total Price (LCY)")
            {
            }
            column(JobUnitCost_GenJournalLine; "Job Unit Cost")
            {
            }
            column(JobUnitCostLCY_GenJournalLine; "Job Unit Cost (LCY)")
            {
            }
            column(JobUnitOfMeasureCode_GenJournalLine; "Job Unit Of Measure Code")
            {
            }
            column(JobUnitPrice_GenJournalLine; "Job Unit Price")
            {
            }
            column(JobUnitPriceLCY_GenJournalLine; "Job Unit Price (LCY)")
            {
            }
            column(JournalBatchId_GenJournalLine; "Journal Batch Id")
            {
            }
            column(JournalBatchName_GenJournalLine; "Journal Batch Name")
            {
            }
            column(JournalTemplateName_GenJournalLine; "Journal Template Name")
            {
            }
            column(KeepDescription_GenJournalLine; "Keep Description")
            {
            }
            column(LastModifiedDateTime_GenJournalLine; "Last Modified DateTime")
            {
            }
            column(LineNo_GenJournalLine; "Line No.")
            {
            }
            column(LinkedSystemID_GenJournalLine; "Linked System ID")
            {
            }
            column(LinkedTableID_GenJournalLine; "Linked Table ID")
            {
            }
            column(MaintenanceCode_GenJournalLine; "Maintenance Code")
            {
            }
            column(MessagetoRecipient_GenJournalLine; "Message to Recipient")
            {
            }
            column(NoofDepreciationDays_GenJournalLine; "No. of Depreciation Days")
            {
            }
            column(NonDeductibleVAT_GenJournalLine; "Non-Deductible VAT %")
            {
            }
            column(NonDeductibleVATAmount_GenJournalLine; "Non-Deductible VAT Amount")
            {
            }
            column(NonDeductibleVATAmountACY_GenJournalLine; "Non-Deductible VAT Amount ACY")
            {
            }
            column(NonDeductibleVATAmountLCY_GenJournalLine; "Non-Deductible VAT Amount LCY")
            {
            }
            column(NonDeductibleVATBase_GenJournalLine; "Non-Deductible VAT Base")
            {
            }
            column(NonDeductibleVATBaseACY_GenJournalLine; "Non-Deductible VAT Base ACY")
            {
            }
            column(NonDeductibleVATBaseLCY_GenJournalLine; "Non-Deductible VAT Base LCY")
            {
            }
            column(NonDeductibleVATDiff_GenJournalLine; "Non-Deductible VAT Diff.")
            {
            }
            column(OnHold_GenJournalLine; "On Hold")
            {
            }
            column(OrigPmtDiscPossible_GenJournalLine; "Orig. Pmt. Disc. Possible")
            {
            }
            column(OrigPmtDiscPossibleLCY_GenJournalLine; "Orig. Pmt. Disc. Possible(LCY)")
            {
            }

            column(PayerInformation_GenJournalLine; "Payer Information")
            {
            }
            column(PaymentDiscount_GenJournalLine; "Payment Discount %")
            {
            }
            column(PaymentMethodCode_GenJournalLine; "Payment Method Code")
            {
            }
            column(PaymentMethodId_GenJournalLine; "Payment Method Id")
            {
            }
            column(PaymentReference_GenJournalLine; "Payment Reference")
            {
            }
            column(PaymentTermsCode_GenJournalLine; "Payment Terms Code")
            {
            }
            column(PendingApproval_GenJournalLine; "Pending Approval")
            {
            }
            column(PmtDiscountDate_GenJournalLine; "Pmt. Discount Date")
            {
            }
            column(PostingDate_GenJournalLine; "Posting Date")
            {
            }
            column(PostingGroup_GenJournalLine; "Posting Group")
            {
            }
            column(PostingNoSeries_GenJournalLine; "Posting No. Series")
            {
            }
            column(Prepayment_GenJournalLine; Prepayment)
            {
            }
            column(PrintPostedDocuments_GenJournalLine; "Print Posted Documents")
            {
            }
            column(ProdOrderNo_GenJournalLine; "Prod. Order No.")
            {
            }
            column(ProfitLCY_GenJournalLine; "Profit (LCY)")
            {
            }
            column(Quantity_GenJournalLine; Quantity)
            {
            }
            column(ReasonCode_GenJournalLine; "Reason Code")
            {
            }
            column(RecipientBankAccount_GenJournalLine; "Recipient Bank Account")
            {
            }
            column(RecurringFrequency_GenJournalLine; "Recurring Frequency")
            {
            }
            column(RecurringMethod_GenJournalLine; "Recurring Method")
            {
            }
            column(RemittoCode_GenJournalLine; "Remit-to Code")
            {
            }
            column(ReverseDateCalculation_GenJournalLine; "Reverse Date Calculation")
            {
            }
            column(ReversingEntry_GenJournalLine; "Reversing Entry")
            {
            }
            column(SalesPurchLCY_GenJournalLine; "Sales/Purch. (LCY)")
            {
            }
            column(SalespersPurchCode_GenJournalLine; "Salespers./Purch. Code")
            {
            }
            column(SalvageValue_GenJournalLine; "Salvage Value")
            {
            }
            column(SelectedAllocAccountNo_GenJournalLine; "Selected Alloc. Account No.")
            {
            }
            column(SelltoBuyfromNo_GenJournalLine; "Sell-to/Buy-from No.")
            {
            }
            column(ShiptoOrderAddressCode_GenJournalLine; "Ship-to/Order Address Code")
            {
            }
            column(ShortcutDimension1Code_GenJournalLine; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_GenJournalLine; "Shortcut Dimension 2 Code")
            {
            }
            column(SourceCode_GenJournalLine; "Source Code")
            {
            }
            column(SourceCurrVATAmount_GenJournalLine; "Source Curr. VAT Amount")
            {
            }
            column(SourceCurrVATBaseAmount_GenJournalLine; "Source Curr. VAT Base Amount")
            {
            }
            column(SourceCurrencyAmount_GenJournalLine; "Source Currency Amount")
            {
            }
            column(SourceCurrencyCode_GenJournalLine; "Source Currency Code")
            {
            }
            column(SourceLineNo_GenJournalLine; "Source Line No.")
            {
            }
            column(SourceNo_GenJournalLine; "Source No.")
            {
            }
            column(SourceType_GenJournalLine; "Source Type")
            {
            }
            column(TaxAreaCode_GenJournalLine; "Tax Area Code")
            {
            }
            column(TaxGroupCode_GenJournalLine; "Tax Group Code")
            {
            }
            column(TaxLiable_GenJournalLine; "Tax Liable")
            {
            }
            column(TransactionInformation_GenJournalLine; "Transaction Information")
            {
            }
            column(UseDuplicationList_GenJournalLine; "Use Duplication List")
            {
            }
            column(UseTax_GenJournalLine; "Use Tax")
            {
            }
            column(VAT_GenJournalLine; "VAT %")
            {
            }
            column(VATAmount_GenJournalLine; "VAT Amount")
            {
            }
            column(VATAmountLCY_GenJournalLine; "VAT Amount (LCY)")
            {
            }
            column(VATBaseAmount_GenJournalLine; "VAT Base Amount")
            {
            }
            column(VATBaseAmountLCY_GenJournalLine; "VAT Base Amount (LCY)")
            {
            }
            column(VATBaseBeforePmtDisc_GenJournalLine; "VAT Base Before Pmt. Disc.")
            {
            }
            column(VATBaseDiscount_GenJournalLine; "VAT Base Discount %")
            {
            }
            column(VATBusPostingGroup_GenJournalLine; "VAT Bus. Posting Group")
            {
            }
            column(VATCalculationType_GenJournalLine; "VAT Calculation Type")
            {
            }
            column(VATDifference_GenJournalLine; "VAT Difference")
            {
            }
            column(VATPosting_GenJournalLine; "VAT Posting")
            {
            }
            column(VATProdPostingGroup_GenJournalLine; "VAT Prod. Posting Group")
            {
            }
            column(VATRegistrationNo_GenJournalLine; "VAT Registration No.")
            {
            }
            column(VATReportingDate_GenJournalLine; "VAT Reporting Date")
            {
            }
            column(VendorId_GenJournalLine; "Vendor Id")
            {
            }
            column(YourReference_GenJournalLine; "Your Reference")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompInfo.get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
}
