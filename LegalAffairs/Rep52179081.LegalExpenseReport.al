report 52179081 "Legal Expense Report"
{
    Caption = 'Legal Expense Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './LegalAffairs/Layouts/LegalExpenseReport.rdlc';

    dataset
    {
        dataitem("Legal Invoice"; "Legal Invoice")
        {
            RequestFilterFields = "Invoice No.", "Invoice Date", "Case No.", "Vendor No.", "Payment Status", "Department Code";
            
            column(InvoiceNo; "Invoice No.")
            {
                IncludeCaption = true;
            }
            column(InvoiceDate; "Invoice Date")
            {
                IncludeCaption = true;
            }
            column(CaseNo; "Case No.")
            {
                IncludeCaption = true;
            }
            column(VendorNo; "Vendor No.")
            {
                IncludeCaption = true;
            }
            column(VendorName; "Vendor Name")
            {
                IncludeCaption = true;
            }
            column(ExternalCounsel; "External Counsel")
            {
                IncludeCaption = true;
            }
            column(ServiceType; "Service Type")
            {
                IncludeCaption = true;
            }
            column(Description; Description)
            {
                IncludeCaption = true;
            }
            column(HoursWorked; "Hours Worked")
            {
                IncludeCaption = true;
            }
            column(HourlyRate; "Hourly Rate")
            {
                IncludeCaption = true;
            }
            column(AmountLCY; "Amount (LCY)")
            {
                IncludeCaption = true;
            }
            column(VATAmount; "VAT Amount")
            {
                IncludeCaption = true;
            }
            column(TotalAmount; "Total Amount")
            {
                IncludeCaption = true;
            }
            column(PaymentStatus; "Payment Status")
            {
                IncludeCaption = true;
            }
            column(DueDate; "Due Date")
            {
                IncludeCaption = true;
            }
            column(DepartmentCode; "Department Code")
            {
                IncludeCaption = true;
            }
            column(CompanyName; CompanyProperty.DisplayName())
            {
            }
            column(ReportTitle; ReportTitle)
            {
            }
            column(ReportDate; Format(Today, 0, 4))
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(PeriodStart; Format(PeriodStart))
            {
            }
            column(PeriodEnd; Format(PeriodEnd))
            {
            }
            
            trigger OnAfterGetRecord()
            begin
                // Calculate totals
                TotalInvoices += 1;
                TotalHours += "Hours Worked";
                TotalAmountLCY += "Amount (LCY)";
                TotalVAT += "VAT Amount";
                GrandTotal += "Total Amount";
                
                case "Payment Status" of
                    "Payment Status"::Pending:
                        TotalPending += "Total Amount";
                    "Payment Status"::Paid:
                        TotalPaid += "Total Amount";
                end;
                
                // Group by service type
                case "Service Type" of
                    "Service Type"::"Legal Consultation":
                        ConsultationTotal += "Total Amount";
                    "Service Type"::"Court Representation":
                        RepresentationTotal += "Total Amount";
                    "Service Type"::"Court Fees", "Service Type"::"Filing Fees":
                        CourtFeesTotal += "Total Amount";
                end;
            end;
        }
        
        dataitem(Footer; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            
            column(TotalInvoices; TotalInvoices)
            {
            }
            column(TotalHours; TotalHours)
            {
            }
            column(TotalAmountLCY; TotalAmountLCY)
            {
            }
            column(TotalVAT; TotalVAT)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(TotalPending; TotalPending)
            {
            }
            column(TotalPaid; TotalPaid)
            {
            }
            column(ConsultationTotal; ConsultationTotal)
            {
            }
            column(RepresentationTotal; RepresentationTotal)
            {
            }
            column(CourtFeesTotal; CourtFeesTotal)
            {
            }
        }
    }
    
    requestpage
    {
        SaveValues = true;
        
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    
                    field(PeriodStart; PeriodStart)
                    {
                        ApplicationArea = All;
                        Caption = 'Period Start Date';
                        ToolTip = 'Specifies the start date for the report period.';
                    }
                    field(PeriodEnd; PeriodEnd)
                    {
                        ApplicationArea = All;
                        Caption = 'Period End Date';
                        ToolTip = 'Specifies the end date for the report period.';
                    }
                    field(GroupByCase; GroupByCase)
                    {
                        ApplicationArea = All;
                        Caption = 'Group by Case';
                        ToolTip = 'Specifies whether to group expenses by case.';
                    }
                    field(ShowDetails; ShowDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Invoice Details';
                        ToolTip = 'Specifies whether to show detailed invoice information.';
                    }
                }
            }
        }
    }
    
    trigger OnPreReport()
    begin
        ReportTitle := 'Legal Expense Report';
        FilterString := "Legal Invoice".GetFilters();
        
        if (PeriodStart <> 0D) and (PeriodEnd <> 0D) then
            "Legal Invoice".SetRange("Invoice Date", PeriodStart, PeriodEnd);
            
        // Initialize totals
        TotalInvoices := 0;
        TotalHours := 0;
        TotalAmountLCY := 0;
        TotalVAT := 0;
        GrandTotal := 0;
        TotalPending := 0;
        TotalPaid := 0;
        ConsultationTotal := 0;
        RepresentationTotal := 0;
        CourtFeesTotal := 0;
    end;
    
    var
        ReportTitle: Text[100];
        FilterString: Text;
        PeriodStart: Date;
        PeriodEnd: Date;
        GroupByCase: Boolean;
        ShowDetails: Boolean;
        TotalInvoices: Integer;
        TotalHours: Decimal;
        TotalAmountLCY: Decimal;
        TotalVAT: Decimal;
        GrandTotal: Decimal;
        TotalPending: Decimal;
        TotalPaid: Decimal;
        ConsultationTotal: Decimal;
        RepresentationTotal: Decimal;
        CourtFeesTotal: Decimal;
}