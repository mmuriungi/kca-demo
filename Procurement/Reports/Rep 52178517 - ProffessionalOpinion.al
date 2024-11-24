report 52178517 "Proffessional Opinion"
{
    RDLCLayout = './Procurement/Reports/SSR/Professional Opinion.rdl';
    DefaultLayout = RDLC;
    Caption = 'Proffessional Opinion';
    dataset
    {
        dataitem(ProcProffessionalOpinion; "Proc Proffessional Opinion")
        {
            column(AccountingOfficer; "Accounting Officer")
            {
            }
            column(No; "No.")
            {
            }
            column(ProcurementMethods; "Procurement Methods")
            {
            }
            column(ProffessionalOpinion; "Proffessional Opinion")
            {
            }
            column(RecommendedforAward; "Recommended for Award")
            {
            }
            column(RequisitionNo; "Requisition No.")
            {
            }
            column(Status; Status)
            {
            }
            column(SubmittedBy_ProcProffessionalOpinion; "Submitted By")
            {
            }
            column(name; name)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {

            }
            column(CompInfoEmail; CompInfo."E-Mail")
            {

            }
            column(CompInfoaddress; CompInfo.Address)
            {

            }
            column(MemoNo; MemoNo)
            {

            }
            column(MemoDate; MemoDate)
            {

            }

            dataitem(ProcCommitteeMembership; "Proc-Committee Membership")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = where("Committee Type" = filter("Evaluation Committee"));
                column(Email_ProcCommitteeMembership; Email)
                {
                }
                column(Name_ProcCommitteeMembership; Name)
                {
                }
                column(StaffNo_ProcCommitteeMembership; "Staff No.")
                {
                }
                column(Role_ProcCommitteeMembership; Role)
                {
                }
                column(Comments_ProcCommitteeMembership; Comments)
                {
                }
                column(Sno; Sno)
                {

                }
                dataitem(ProcCommitteeAppointmentH; "Proc-Committee Appointment H")
                {
                    DataItemLink = "Tender/Quote No" = field("No.");
                    column(RefNo_ProcCommitteeAppointmentH; "Ref No")
                    {
                    }
                    column(Date_ProcCommitteeAppointmentH; "Date")
                    {
                    }
                }
                trigger OnPreDataItem()
                begin
                    Sno := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    Sno := Sno + 1;
                end;
            }
            dataitem(ProcPurchaseQuoteHeader; "Proc-Purchase Quote Header")
            {
                DataItemLink = "No." = field("No.");
                column(Description_ProcPurchaseQuoteHeader; Description)
                {
                }
                column(AdvertDate_ProcPurchaseQuoteHeader; "Advert Date")
                {
                }
                column(ExpectedOpeningDate_ProcPurchaseQuoteHeader; "Expected Opening Date")
                {
                }
                column(TotalQuotes_ProcPurchaseQuoteHeader; "Total Quotes")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CalcFields("Total Quotes");
                end;
            }
            dataitem(ProcBidderQuotedAmounts; "Proc Bidder Quoted Amounts")
            {
                DataItemLink = "Document No" = field("No.");
                DataItemTableView = where(Select = filter(true));
                column(BidNo_ProcBidderQuotedAmounts; "Bid No")
                {
                }
                column(Amount_ProcBidderQuotedAmounts; Amount)
                {
                }
                column(SupplierNo_ProcBidderQuotedAmounts; "Supplier No")
                {
                }
                column(SupplierName_ProcBidderQuotedAmounts; "Supplier Name")
                {
                }
                column(ItemNo_ProcBidderQuotedAmounts; "Item No")
                {
                }
                column(ItemDescription_ProcBidderQuotedAmounts; "Item Description")
                {
                }
                column(Sno1; Sno1)
                {

                }
                trigger OnPreDataItem()
                begin
                    Sno1 := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    Sno1 := Sno + 1;
                end;
            }
            dataitem(PurchaseHeader; "Purchase Header")
            {
                DataItemLink = "Request for Quote No." = field("No.");

                column(No_PurchaseHeader; "No.")
                {
                }
                column(BuyfromVendorNo_PurchaseHeader; "Buy-from Vendor No.")
                {
                }
                column(BuyfromVendorName_PurchaseHeader; "Buy-from Vendor Name")
                {
                }
                column(BuyfromAddress_PurchaseHeader; "Buy-from Address")
                {
                }
            }

            dataitem(UserSetup1; "User Setup")
            {
                DataItemLink = "User ID" = field("Submitted By");

                column(ApprovalTitle_UserSetup1; "Approval Title")
                {
                }
                column(UserSignature_UserSetup1; "User Signature")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    UserSetup1.CalcFields("User Signature");
                end;
            }
            dataitem(UserSetup2; "User Setup")
            {
                DataItemLink = "User ID" = field("Accounting Officer");
                column(ApprovalTitle_UserSetup2; "Approval Title")
                {
                }
                column(UserSignature_UserSetup2; "User Signature")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    UserSetup2.CalcFields("User Signature");
                end;
            }
            trigger OnAfterGetRecord()
            begin
                PurchQteHeader.Reset();
                PurchQteHeader.SetRange("No.", ProcProffessionalOpinion."No.");
                if PurchQteHeader.Find('-') then begin
                    MemoHeader.Reset();
                    MemoHeader.SetRange("PRN No.", PurchQteHeader."Requisition No.");
                    if MemoHeader.Find('-') then begin
                        MemoNo := MemoHeader."No.";
                        MemoDate := MemoHeader."Date/Time";
                    end;
                end;
            end;
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
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
        CompInfo.get();
        CompInfo.CalcFields(Picture);
    end;


    var
        PurchQteHeader: Record "PROC-Purchase Quote Header";
        PurHeader: Record "Purchase Header";
        MemoHeader: Record "FIN-Memo Header";
        MemoNo: Code[50];
        MemoDate: Date;
        CompInfo: Record "Company Information";
        Sno: Integer;
        Sno1: Integer;

}
