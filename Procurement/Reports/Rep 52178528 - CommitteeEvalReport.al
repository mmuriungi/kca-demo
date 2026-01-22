report 52178528 "Committee Eval Report"
{
    RDLCLayout = './Procurement/Reports/SSR/Tender.EvalReport.rdl';
    DefaultLayout = RDLC;

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
            dataitem(Eval; "Proc Evaluation Report")
            {
                DataItemLink = "No." = field("Request for Quote No.");
                column(RequisitionNo_Eval; "Requisition No.")
                {
                }
                column(No_Eval; "No.")
                {
                }
                column(ProcurementMethods_Eval; "Procurement Methods")
                {
                }
                column(RecommendedforAward_Eval; "Recommended for Award")
                {
                }
                column(QuotedAmount; QuotedAmount)
                {

                }
                column(BidderSupplier_Eval; "Bidder/Supplier")
                {
                }
                column(name_Eval; name)
                {
                }
                column(CompName; info.Name)
                {

                }
                column(CompAddress; info.Address)
                {

                }
                column(CompMail; info."E-Mail")
                {

                }
                column(CompPhone; info."Phone No.")
                {

                }
                column(logo; info.Picture)
                {

                }
                column(BidderNo; BidderNo)
                {

                }
                column(Address; Address)
                {

                }

                dataitem(Purchasequote; "Proc-Purchase Quote Header")
                {
                    DataItemLink = "No." = field("No."), "Procurement methods" = field("Procurement Methods");
                    column(AwardedBId_Purchasequote; "Awarded BId")
                    {
                    }
                    column(Description_Purchasequote; Description)
                    {
                    }
                    column(ExpectedOpeningDate_Purchasequote; "Expected Opening Date")
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
                        Purchasequote.Reset();
                        Purchasequote.SetRange("No.", Eval."No.");
                        if Purchasequote.Find('-') then begin
                            Tenderdesc := Purchasequote.Description;
                            Openingdate := Purchasequote."Expected Opening Date";
                        end;
                    end;

                }
                dataitem("Proc-Confirm Recommended"; "Proc-Confirm Recommended")
                {
                    DataItemLink = "No." = field("No.");
                    DataItemTableView = where(Confirmed = filter(true));
                    column(Confirmed_ProcConfirmRecommended; Confirmed)
                    {
                    }
                    column(Date_ProcConfirmRecommended; "Date")
                    {
                    }
                    column(Recommendation_ProcConfirmRecommended; Recommendation)
                    {
                    }
                    column(StaffNo_ProcConfirmRecommended; "Staff No.")
                    {
                    }
                    column(No_ProcConfirmRecommended; "No.")
                    {
                    }
                    column(Name_ProcConfirmRecommended; Name)
                    {
                    }
                    column(BidderNo_ProcConfirmRecommended; "Bidder No")
                    {
                    }
                    column(ProcConfirmRecommendedsno; sno)
                    {

                    }
                    dataitem("User Setup"; "User Setup")
                    {
                        DataItemLink = "Employee No." = field("Staff No.");
                        column(UserSignature_UserSetup; "User Signature")
                        {
                        }
                        column(ApprovalTitle_UserSetup; "Approval Title")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            "User Setup".CalcFields("User Signature")
                        end;
                    }
                    trigger OnPreDataItem()
                    begin
                        sno := 0;
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        sno := sno + 1;

                    end;
                }
                dataitem(ProcCommitteeAppointmentH; "Proc-Committee Appointment H")
                {
                    DataItemLink = "Tender/Quote No" = field("No.");
                    column(Date_ProcCommitteeAppointmentH; Date_ProcCommitteeAppointmentH)
                    {
                    }
                    column(To_ProcCommitteeAppointmentH; To_ProcCommitteeAppointmentH)
                    {
                    }
                    column(RefNo_ProcCommitteeAppointmentH; "Ref No")
                    {
                    }
                    column(ProcurementMethod_ProcCommitteeAppointmentH; "Procurement Method")
                    {
                    }
                    column(Description_ProcCommitteeAppointmentH; Description)
                    {
                    }
                    DataItem("Proc-Committee Members"; "Proc-Committee Members")
                    {
                        DataItemLink = "Ref No" = field("Ref No");
                        DataItemTableView = where(Committee = filter(Evaluation));
                        column(MemberNo_ProcCommitteeMembers; "Member No")
                        {
                        }
                        column(Email_ProcCommitteeMembers; Email)
                        {
                        }
                        column(PhoneNo_ProcCommitteeMembers; "Phone No")
                        {
                        }
                        column(Committee_ProcCommitteeMembers; Committee)
                        {
                        }
                        column(Name_ProcCommitteeMembers; Name)
                        {
                        }
                        column(Role_ProcCommitteeMembers; Role)
                        {
                        }
                        column(MemberType_ProcCommitteeMembers; "Member Type")
                        {
                        }
                        column(sno3; sno)
                        {

                        }
                        trigger OnPreDataItem()
                        begin
                            sno := 0;
                        end;

                        trigger OnAfterGetRecord()
                        begin
                            sno := sno + 1;
                        end;
                    }
                    trigger OnAfterGetRecord()
                    var

                    begin
                        ProcCommitteeAppointmentH.Reset();
                        ProcCommitteeAppointmentH.SetRange("Tender/Quote No", eval."No.");
                        if ProcCommitteeAppointmentH.Find('-') then begin
                            To_ProcCommitteeAppointmentH := ProcCommitteeAppointmentH."To";
                            Date_ProcCommitteeAppointmentH := ProcCommitteeAppointmentH.Date;
                        end;
                    end;

                }

                trigger OnAfterGetRecord()
                begin
                    Plines.Reset();
                    Plines.SetRange("Document No.", "Recommended for Award");
                    if Plines.Find('-') then
                        Plines.CalcSums("Line Amount");
                    QuotedAmount := Plines."Line Amount";
                end;

            }
            dataitem("Proc-Preliminary Qualif.Quote"; "Proc-Preliminary Qualif.Quote")
            {
                DataItemLink = "No." = field("Request for Quote No.");
                DataItemTableView = where("Quote Status" = filter(Technical));
                column(ProcPreliminaryEntry_No_; "Entry No.")
                {

                }
                column(ProcPreliminaryDescription; Description)
                {

                }
                column(ProcPreliminaryStaff_No; "Staff No")
                {

                }
                column(ProcPreliminaryStaff_Name; "Staff Name")
                {

                }
                column(ProcPreliminaryQuote_No_; "Quote No.")
                {

                }
                column(ProcPreliminaryScored; Scored)
                {

                }
                column(ProcPreliminaryReason; Reason)
                {

                }
                column(sno; sno)
                {

                }
                trigger OnPreDataItem()
                begin
                    sno := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    sno := sno + 1;
                end;

            }
            dataitem("Proc-Technical Qualif.Quote"; "Proc-Technical Qualif.Quote")
            {
                DataItemLink = "No." = field("Request for Quote No.");
                DataItemTableView = where("Quote Status" = filter(Demonstration));
                column(ProcTechnicalQuote_No_; "Quote No.")
                {

                }
                column(ProcTechnicalEntryNo; "Entry No.")
                {

                }
                column(ProcTechnicalScored; Scored)
                {

                }
                column(ProcTechnicalStaff_No; "Staff No")
                {

                }
                column(ProcTechnicalStaff_Name; "Staff Name")
                {

                }
                column(ProcTechnicalMaxScore; "Maximum Score")
                {

                }
                column(ProcTechnicalDescription; Description)
                {

                }
                column(ProcTechnicalAverage_Score; "Average Score")
                {

                }
                column(sno1; sno)
                {

                }
                trigger OnPreDataItem()
                begin
                    sno := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    sno := sno + 1;
                end;


            }
            dataitem("Proc-Demo Qualif.Quote"; "Proc-Demo Qualif.Quote")
            {
                DataItemLink = "No." = field("Request for Quote No.");
                DataItemTableView = where("Quote Status" = filter(Financials));
                column(ProcDemoQualifQuote_No_; "Quote No.")
                {

                }
                column(ProcDemoQualifEntryNo; "Entry No.")
                {

                }
                column(ProcDemoQualifScored; Scored)
                {

                }
                column(ProcDemoQualifMaxScore; "Maximum Score")
                {

                }
                column(ProcDemoQualifDescription; Description)
                {

                }
                column(ProcDemoQualifAverage_Score; "Average Score")
                {

                }
                column(ProcDemoQualifStaff_No; "Staff No")
                {

                }
                column(ProcDemoQualifStaff_Name; "Staff Name")
                {

                }
                column(sno2; sno)
                {

                }
                trigger OnPreDataItem()
                begin
                    sno := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    sno := sno + 1;
                end;
            }
            dataitem("Proc-Financial Qualif.Quote"; "Proc-Financial Qualif.Quote")
            {
                DataItemLink = "No." = field("Request for Quote No.");
                DataItemTableView = where("Quote Status" = filter(Financials));
                column(ProcFinancialQuote_No_; "Quote No.")
                {

                }
                column(ProcFinancialEntry_No_; "Entry No.")
                {

                }
                column(ProcFinancialQuoted_Amount; "Quoted Amount")
                {

                }
                column(ProcFinancialScore; Score)
                {

                }
                column(ProcFinancialTender_Quoted_Amount; "Tender Quoted Amount")
                {

                }
                column(snofin; sno)
                {

                }
                trigger OnPreDataItem()
                begin
                    sno := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    sno := sno + 1;
                end;
            }
        }

    }
    trigger OnInitReport()
    begin
        info.get;
        info.CalcFields(Picture);
    end;

    var
        Pagerec: page "Evaluation Report";
        info: Record "Company Information";
        BidderNo: Code[50];
        sno: Integer;
        Tenderdesc: Text[500];
        bidsno: Integer;
        Openingdate: DateTime;
        Quoteno: code[50];
        To_ProcCommitteeAppointmentH: Text;
        Date_ProcCommitteeAppointmentH: DateTime;
        Pheader: Record "Purchase Header";
        Plines: Record "Purchase Line";
        Address: Text;
        QuotedAmount: Decimal;





}