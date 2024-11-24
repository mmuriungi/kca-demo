Report 52178801 "Tender Award Letter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Tendering Process/Reports/SSR/Tender Award Letter.rdl';

    dataset
    {
        dataitem("Tender Submission Header"; "Tender Submission Header")
        {
            RequestFilterFields = "No.";

            column(No_TenderSubmissionHeader; "No.")
            {
            }
            column(BidderNo_TenderSubmissionHeader; "Bidder No")
            {
            }
            column(TenderNo_TenderSubmissionHeader; "Tender No.")
            {
            }
            column(BidStatus_TenderSubmissionHeader; "Bid Status")
            {
            }
            column(ExpectedOpeningDate_TenderSubmissionHeader; "Expected Opening Date")
            {
            }
            column(PostingDate_TenderSubmissionHeader; "Posting Date")
            {
            }
            column(ExpectedClosingDate_TenderSubmissionHeader; "Expected Closing Date")
            {
            }
            column(PostingDescription_TenderSubmissionHeader; "Posting Description")
            {
            }
            column(TechnicalTotal_TenderSubmissionHeader; "Technical Total")
            {
            }
            column(TechnicalScore_TenderSubmissionHeader; "Technical Score")
            {
            }
            column(TechnicalPercentage_TenderSubmissionHeader; "Technical Percentage")
            {
            }
            column(DemoTotal_TenderSubmissionHeader; "Demo Total")
            {
            }
            column(DemoScore_TenderSubmissionHeader; "Demo  Score")
            {
            }
            column(DemoPercentage_TenderSubmissionHeader; "Demo Percentage")
            {
            }
            column(FinancialBudgetedAmount_TenderSubmissionHeader; "Financial Budgeted Amount")
            {
            }
            column(FinancialQuotedAmount_TenderSubmissionHeader; "Financial Quoted Amount")
            {
            }
            column(FinancialVariation_TenderSubmissionHeader; "Financial Variation")
            {
            }
            column(TechnicalProposalPath_TenderSubmissionHeader; "Technical Proposal Path")
            {
            }
            column(FinancialProposalPath_TenderSubmissionHeader; "Financial Proposal Path")
            {
            }
            column(FinancialQuotedAmount2_TenderSubmissionHeader; "Financial Quoted Amount2")
            {
            }
            column(ResponsibilityCenter_TenderSubmissionHeader; "Location Code")
            {
            }
            column(QuoteNo_TenderSubmissionHeader; "Quote No.")
            {
            }
            column(cname; info.Name)
            {

            }
            column(cname2; info."Name 2")
            {

            }
            column(logo; info.Picture)
            {

            }
            column(mail; info."E-Mail")
            {

            }
            column(url; info."Home Page")
            {

            }
            column(phone; info."Phone No.")
            {

            }
            column(caddress; info.Address)
            {

            }
            column(caddress2; info."Address 2")
            {

            }

            dataitem("Tender Applicants Registration"; "Tender Applicants Registration")
            {
                DataItemLink = "No." = field("Bidder No");
                column(No_TenderApplicantsRegistration; "No.")
                {
                }
                column(Name_TenderApplicantsRegistration; Name)
                {
                }
                column(Address_TenderApplicantsRegistration; Address)
                {
                }
                column(City_TenderApplicantsRegistration; City)
                {
                }
                column(Contact_TenderApplicantsRegistration; Contact)
                {
                }
                column(PhoneNo_TenderApplicantsRegistration; "Phone No.")
                {
                }
                column(ContactPerson_TenderApplicantsRegistration; "Contact Person")
                {
                }
                column(ContactPersonEmail_TenderApplicantsRegistration; "Contact Person Email")
                {
                }
                column(OurAccountNo_TenderApplicantsRegistration; "Our Account No.")
                {
                }
            }
            dataitem("Tender Bidder Prelim Reqs"; "Tender Bidder Prelim Reqs")
            {
                DataItemLink = "Tender No." = field("Tender No.");

                column(TenderNo_TenderBidderPrelimReqs; "Tender No.")
                {
                }
                column(Code_TenderBidderPrelimReqs; "Code")
                {
                }
                column(Description_TenderBidderPrelimReqs; Description)
                {
                }
                column(Description2_TenderBidderPrelimReqs; "Description 2")
                {
                }
                column(RequirementsMet_TenderBidderPrelimReqs; "Requirements Met?")
                {
                }
                column(Remarks_TenderBidderPrelimReqs; Remarks)
                {
                }
                column(BidNo_TenderBidderPrelimReqs; "Bid No.")
                {
                }
                column(BidderNo_TenderBidderPrelimReqs; "Bidder No.")
                {
                }
                column(Employeeno_TenderBidderPrelimReqs; "Employee no")
                {
                }
                column(UserName_TenderBidderPrelimReqs; "User Name")
                {
                }
            }
            dataitem("Tender Bidder Technical Reqs"; "Tender Bidder Technical Reqs")
            {
                DataItemLink = "Tender No." = field("Tender No.");
                column(TenderNo_TenderBidderTechnicalReqs; "Tender No.")
                {
                }
                column(Code_TenderBidderTechnicalReqs; "Code")
                {
                }
                column(Description_TenderBidderTechnicalReqs; Description)
                {
                }
                column(Description2_TenderBidderTechnicalReqs; "Description 2")
                {
                }
                column(MaximumScore_TenderBidderTechnicalReqs; "Maximum Score")
                {
                }
                column(score_TenderBidderTechnicalReqs; score)
                {
                }
                column(Remarks_TenderBidderTechnicalReqs; Remarks)
                {
                }
                column(BidNo_TenderBidderTechnicalReqs; "Bid No.")
                {
                }
                column(BidderNo_TenderBidderTechnicalReqs; "Bidder No.")
                {
                }
            }

            dataitem("Tender Bidder Demo Reqs"; "Tender Bidder Demo Reqs")
            {
                DataItemLink = "Tender No." = field("Tender No.");
                column(TenderNo_TenderBidderDemoReqs; "Tender No.")
                {
                }
                column(Code_TenderBidderDemoReqs; "Code")
                {
                }
                column(Description_TenderBidderDemoReqs; Description)
                {
                }
                column(Description2_TenderBidderDemoReqs; "Description 2")
                {
                }
                column(MaximumScore_TenderBidderDemoReqs; "Maximum Score")
                {
                }
                column(Score_TenderBidderDemoReqs; Score)
                {
                }
                column(Remarks_TenderBidderDemoReqs; Remarks)
                {
                }
                column(BidNo_TenderBidderDemoReqs; "Bid No.")
                {
                }
                column(BidderNo_TenderBidderDemoReqs; "Bidder No.")
                {
                }
            }
            dataitem("Tender Bidder Fin Reqs"; "Tender Bidder Fin Reqs")
            {
                DataItemLink = "Tender No." = field("Tender No.");
                column(TenderNo_TenderBidderFinReqs; "Tender No.")
                {
                }
                column(Code_TenderBidderFinReqs; "Code")
                {
                }
                column(Description_TenderBidderFinReqs; Description)
                {
                }
                column(Description2_TenderBidderFinReqs; "Description 2")
                {
                }
                column(BudgetedValue_TenderBidderFinReqs; "Budgeted Value")
                {
                }
                column(QuotedAmount_TenderBidderFinReqs; "Quoted Amount")
                {
                }
                column(Remarks_TenderBidderFinReqs; Remarks)
                {
                }
                column(BidNo_TenderBidderFinReqs; "Bid No.")
                {
                }
                column(BidderNo_TenderBidderFinReqs; "Bidder No.")
                {
                }
                column(TotalBidAmount_TenderBidderFinReqs; "Total Bid Amount")
                {
                }
            }
            dataitem("Tender Submission Lines"; "Tender Submission Lines")
            {
                DataItemLink = "Document No." = field("No.");
                column(BuyfromBidderNo_TenderSubmissionLines; "Buy-from Bidder No.")
                {
                }
                column(No_TenderSubmissionLines; "No.")
                {
                }
                column(DocumentNo_TenderSubmissionLines; "Document No.")
                {
                }
                column(LocationCode_TenderSubmissionLines; "Location Code")
                {
                }
                column(ExpectedReceiptDate_TenderSubmissionLines; "Document Date")
                {
                }
                column(Description_TenderSubmissionLines; Description)
                {
                }
                column(UnitofMeasure_TenderSubmissionLines; "Unit of Measure")
                {
                }
                column(Quantity_TenderSubmissionLines; Quantity)
                {
                }
            }
            trigger OnPreDataItem()
            begin
                info.Get();
                info.CalcFields(Picture);
            end;
        }
    }

    var
        info: Record "Company Information";
}