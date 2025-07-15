page 56271 "Import SMS Recipients"
{
    PageType = StandardDialog;
    Caption = 'Import SMS Recipients';

    layout
    {
        area(Content)
        {
            group(Options)
            {
                Caption = 'Import Options';
                
                field(RecipientSource; RecipientSource)
                {
                    ApplicationArea = All;
                    Caption = 'Recipient Source';
                    OptionCaption = 'All Customers,Customer Filter,All Vendors,Vendor Filter,All KUCCPS,KUCCPS Filter';
                    
                    trigger OnValidate()
                    begin
                        UpdatePageControls();
                    end;
                }
                
                group(CustomerFilters)
                {
                    Caption = 'Customer Filters';
                    Visible = ShowCustomerFilters;
                    
                    field(CustomerPostingGroup; CustomerPostingGroup)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Posting Group';
                        TableRelation = "Customer Posting Group";
                    }
                    
                    field(CustomerBlocked; CustomerBlocked)
                    {
                        ApplicationArea = All;
                        Caption = 'Blocked';
                        OptionCaption = 'All,Not Blocked,Invoice,Ship,All Blocked';
                    }
                    
                    field(CustomerNoFilter; CustomerNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer No. Filter';
                        
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Customer: Record Customer;
                            CustomerList: Page "Customer List";
                        begin
                            CustomerList.LookupMode(true);
                            if CustomerList.RunModal() = Action::LookupOK then begin
                                CustomerList.GetRecord(Customer);
                                if CustomerNoFilter = '' then
                                    CustomerNoFilter := Customer."No."
                                else
                                    CustomerNoFilter += '|' + Customer."No.";
                                exit(true);
                            end;
                        end;
                    }
                }
                
                group(VendorFilters)
                {
                    Caption = 'Vendor Filters';
                    Visible = ShowVendorFilters;
                    
                    field(VendorPostingGroup; VendorPostingGroup)
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor Posting Group';
                        TableRelation = "Vendor Posting Group";
                    }
                    
                    field(VendorBlocked; VendorBlocked)
                    {
                        ApplicationArea = All;
                        Caption = 'Blocked';
                        OptionCaption = 'All,Not Blocked,Payment,All Blocked';
                    }
                    
                    field(VendorNoFilter; VendorNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor No. Filter';
                        
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Vendor: Record Vendor;
                            VendorList: Page "Vendor List";
                        begin
                            VendorList.LookupMode(true);
                            if VendorList.RunModal() = Action::LookupOK then begin
                                VendorList.GetRecord(Vendor);
                                if VendorNoFilter = '' then
                                    VendorNoFilter := Vendor."No."
                                else
                                    VendorNoFilter += '|' + Vendor."No.";
                                exit(true);
                            end;
                        end;
                    }
                }
                
                group(KUCCPSFilters)
                {
                    Caption = 'KUCCPS Filters';
                    Visible = ShowKUCCPSFilters;
                    
                    field(ProgramFilter; ProgramFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Program';
                        TableRelation = "ACA-Programme".Code;
                    }
                    
                    field(AcademicYear; AcademicYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Academic Year';
                    }
                    
                    field(StreamFilter; StreamFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Stream';
                    }
                    
                    field(AdmissionDateFilter; AdmissionDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Admission Date Filter';
                    }
                }
                
                field(IncludeBlankPhones; IncludeBlankPhones)
                {
                    ApplicationArea = All;
                    Caption = 'Include Records with Blank Phone Numbers';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        RecipientSource := RecipientSource::"All Customers";
        UpdatePageControls();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = Action::OK then
            ImportRecipients();
    end;

    var
        CampaignNo: Code[20];
        RecipientSource: Option "All Customers","Customer Filter","All Vendors","Vendor Filter","All KUCCPS","KUCCPS Filter";
        CustomerPostingGroup: Code[20];
        CustomerBlocked: Option All,"Not Blocked",Invoice,Ship,"All Blocked";
        CustomerNoFilter: Text;
        VendorPostingGroup: Code[20];
        VendorBlocked: Option All,"Not Blocked",Payment,"All Blocked";
        VendorNoFilter: Text;
        ProgramFilter: Code[20];
        AcademicYear: Code[20];
        StreamFilter: Code[20];
        AdmissionDateFilter: Text;
        IncludeBlankPhones: Boolean;
        ShowCustomerFilters: Boolean;
        ShowVendorFilters: Boolean;
        ShowKUCCPSFilters: Boolean;

    procedure SetCampaignNo(NewCampaignNo: Code[20])
    begin
        CampaignNo := NewCampaignNo;
    end;

    local procedure UpdatePageControls()
    begin
        ShowCustomerFilters := RecipientSource in [RecipientSource::"Customer Filter"];
        ShowVendorFilters := RecipientSource in [RecipientSource::"Vendor Filter"];
        ShowKUCCPSFilters := RecipientSource in [RecipientSource::"KUCCPS Filter"];
    end;

    local procedure ImportRecipients()
    begin
        case RecipientSource of
            RecipientSource::"All Customers", RecipientSource::"Customer Filter":
                ImportCustomers();
            RecipientSource::"All Vendors", RecipientSource::"Vendor Filter":
                ImportVendors();
            RecipientSource::"All KUCCPS", RecipientSource::"KUCCPS Filter":
                ImportKUCCPS();
        end;
    end;

    local procedure ImportCustomers()
    var
        Customer: Record Customer;
        SMSCampaignLine: Record "SMS Campaign Line";
        Window: Dialog;
        Counter: Integer;
        TotalCount: Integer;
    begin
        Customer.Reset();
        
        if RecipientSource = RecipientSource::"Customer Filter" then begin
            if CustomerPostingGroup <> '' then
                Customer.SetRange("Customer Posting Group", CustomerPostingGroup);
                
            case CustomerBlocked of
                CustomerBlocked::"Not Blocked":
                    Customer.SetRange(Blocked, Customer.Blocked::" ");
                CustomerBlocked::Invoice:
                    Customer.SetRange(Blocked, Customer.Blocked::Invoice);
                CustomerBlocked::Ship:
                    Customer.SetRange(Blocked, Customer.Blocked::Ship);
                CustomerBlocked::"All Blocked":
                    Customer.SetRange(Blocked, Customer.Blocked::All);
            end;
            
            if CustomerNoFilter <> '' then
                Customer.SetFilter("No.", CustomerNoFilter);
        end;
        
        if not IncludeBlankPhones then
            Customer.SetFilter("Phone No.", '<>%1', '');
            
        TotalCount := Customer.Count();
        
        if TotalCount > 0 then begin
            Window.Open('Importing Customers\' +
                       'Progress: #1########## @2@@@@@@@@@@');
            
            if Customer.FindSet() then
                repeat
                    Counter += 1;
                    Window.Update(1, Counter);
                    Window.Update(2, Round(Counter / TotalCount * 10000, 1));
                    
                    SMSCampaignLine.Init();
                    SMSCampaignLine."Campaign No." := CampaignNo;
                    SMSCampaignLine."Recipient Type" := SMSCampaignLine."Recipient Type"::Customer;
                    SMSCampaignLine.Validate("Recipient No.", Customer."No.");
                    SMSCampaignLine.Selected := true;
                    if not SMSCampaignLine.Insert(true) then
                        SMSCampaignLine.Modify(true);
                until Customer.Next() = 0;
                
            Window.Close();
            Message('Imported %1 customer(s).', Counter);
        end else
            Message('No customers found with the specified filters.');
    end;

    local procedure ImportVendors()
    var
        Vendor: Record Vendor;
        SMSCampaignLine: Record "SMS Campaign Line";
        Window: Dialog;
        Counter: Integer;
        TotalCount: Integer;
    begin
        Vendor.Reset();
        
        if RecipientSource = RecipientSource::"Vendor Filter" then begin
            if VendorPostingGroup <> '' then
                Vendor.SetRange("Vendor Posting Group", VendorPostingGroup);
                
            case VendorBlocked of
                VendorBlocked::"Not Blocked":
                    Vendor.SetRange(Blocked, Vendor.Blocked::" ");
                VendorBlocked::Payment:
                    Vendor.SetRange(Blocked, Vendor.Blocked::Payment);
                VendorBlocked::"All Blocked":
                    Vendor.SetRange(Blocked, Vendor.Blocked::All);
            end;
            
            if VendorNoFilter <> '' then
                Vendor.SetFilter("No.", VendorNoFilter);
        end;
        
        if not IncludeBlankPhones then
            Vendor.SetFilter("Phone No.", '<>%1', '');
            
        TotalCount := Vendor.Count();
        
        if TotalCount > 0 then begin
            Window.Open('Importing Vendors\' +
                       'Progress: #1########## @2@@@@@@@@@@');
            
            if Vendor.FindSet() then
                repeat
                    Counter += 1;
                    Window.Update(1, Counter);
                    Window.Update(2, Round(Counter / TotalCount * 10000, 1));
                    
                    SMSCampaignLine.Init();
                    SMSCampaignLine."Campaign No." := CampaignNo;
                    SMSCampaignLine."Recipient Type" := SMSCampaignLine."Recipient Type"::Vendor;
                    SMSCampaignLine.Validate("Recipient No.", Vendor."No.");
                    SMSCampaignLine.Selected := true;
                    if not SMSCampaignLine.Insert(true) then
                        SMSCampaignLine.Modify(true);
                until Vendor.Next() = 0;
                
            Window.Close();
            Message('Imported %1 vendor(s).', Counter);
        end else
            Message('No vendors found with the specified filters.');
    end;

    local procedure ImportKUCCPS()
    var
        KUCCPSImports: Record "KUCCPS Imports";
        SMSCampaignLine: Record "SMS Campaign Line";
        Window: Dialog;
        Counter: Integer;
        TotalCount: Integer;
    begin
        KUCCPSImports.Reset();
        
        if RecipientSource = RecipientSource::"KUCCPS Filter" then begin
            if ProgramFilter <> '' then
                KUCCPSImports.SetRange(KUCCPSImports.Prog, ProgramFilter);
                
            if AcademicYear <> '' then
                KUCCPSImports.SetRange("Academic Year", AcademicYear);
                
        end;
        
        if not IncludeBlankPhones then
            KUCCPSImports.SetFilter(Phone, '<>%1', '');
            
        TotalCount := KUCCPSImports.Count();
        
        if TotalCount > 0 then begin
            Window.Open('Importing KUCCPS Records\' +
                       'Progress: #1########## @2@@@@@@@@@@');
            
            if KUCCPSImports.FindSet() then
                repeat
                    Counter += 1;
                    Window.Update(1, Counter);
                    Window.Update(2, Round(Counter / TotalCount * 10000, 1));
                    
                    SMSCampaignLine.Init();
                    SMSCampaignLine."Campaign No." := CampaignNo;
                    SMSCampaignLine."Recipient Type" := SMSCampaignLine."Recipient Type"::KUCCPS;
                    SMSCampaignLine.Validate("Recipient No.", KUCCPSImports.Admin);
                    SMSCampaignLine.Selected := true;
                    if not SMSCampaignLine.Insert(true) then
                        SMSCampaignLine.Modify(true);
                until KUCCPSImports.Next() = 0;
                
            Window.Close();
            Message('Imported %1 KUCCPS record(s).', Counter);
        end else
            Message('No KUCCPS records found with the specified filters.');
    end;
}