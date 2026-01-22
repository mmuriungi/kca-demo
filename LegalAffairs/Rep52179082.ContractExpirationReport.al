report 52179082 "Contract Expiration Report"
{
    Caption = 'Contract Expiration Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './LegalAffairs/Layouts/ContractExpirationReport.rdlc';

    dataset
    {
        dataitem("Project Header"; "Project Header")
        {
            RequestFilterFields = "No.", Status, "Contract Type";
            DataItemTableView = where(Status = filter(Approved | Verified));
            
            column(ContractNo; "No.")
            {
                IncludeCaption = true;
            }
            column(ContractName; "Contract Name")
            {
                IncludeCaption = true;
            }
            column(ProjectName; "Project Name")
            {
                IncludeCaption = true;
            }
            column(ContractType; "Contract Type")
            {
                IncludeCaption = true;
            }
            column(VendorNo; "Vendor No")
            {
                IncludeCaption = true;
            }
            column(VendorName; Name)
            {
                IncludeCaption = true;
            }
            column(EstimatedStartDate; "Estimated Start Date")
            {
                IncludeCaption = true;
            }
            column(EstimatedEndDate; "Estimated End Date")
            {
                IncludeCaption = true;
            }
            column(DaysToExpiry; DaysToExpiry)
            {
            }
            column(ExpiryStatus; ExpiryStatus)
            {
            }
            column(RenewalDate; "Renewal Date")
            {
                IncludeCaption = true;
            }
            column(PaymentFrequency; "Payment Frequency")
            {
                IncludeCaption = true;
            }
            column(FrequencyAmount; "Frequency Amount")
            {
                IncludeCaption = true;
            }
            column(DepartmentCode; "DepartmentCode")
            {
                IncludeCaption = true;
            }
            column(Status; Status)
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
            column(ExpiryPeriod; ExpiryPeriod)
            {
            }
            
            trigger OnAfterGetRecord()
            begin
                Clear(DaysToExpiry);
                Clear(ExpiryStatus);
                
                if "Estimated End Date" <> 0D then begin
                    DaysToExpiry := "Estimated End Date" - Today;
                    
                    case true of
                        DaysToExpiry < 0:
                            ExpiryStatus := 'EXPIRED';
                        DaysToExpiry <= 30:
                            ExpiryStatus := 'CRITICAL';
                        DaysToExpiry <= 60:
                            ExpiryStatus := 'WARNING';
                        DaysToExpiry <= 90:
                            ExpiryStatus := 'ATTENTION';
                        else
                            ExpiryStatus := 'OK';
                    end;
                end;
            end;
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
                    
                    field(ExpiryPeriod; ExpiryPeriod)
                    {
                        ApplicationArea = All;
                        Caption = 'Expiry Period (Days)';
                        ToolTip = 'Specifies the number of days to check for contract expiration.';
                    }
                    field(ShowExpiredOnly; ShowExpiredOnly)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Expired Only';
                        ToolTip = 'Specifies whether to show only expired contracts.';
                    }
                }
            }
        }
    }
    
    trigger OnPreReport()
    begin
        ReportTitle := 'Contract Expiration Report';
        
        if ExpiryPeriod = 0 then
            ExpiryPeriod := 90;
            
        if ShowExpiredOnly then
            "Project Header".SetFilter("Estimated End Date", '..%1', Today)
        else
            "Project Header".SetFilter("Estimated End Date", '..%1', CalcDate('<+' + Format(ExpiryPeriod) + 'D>', Today));
    end;
    
    var
        ReportTitle: Text[100];
        DaysToExpiry: Integer;
        ExpiryStatus: Text[20];
        ExpiryPeriod: Integer;
        ShowExpiredOnly: Boolean;
}