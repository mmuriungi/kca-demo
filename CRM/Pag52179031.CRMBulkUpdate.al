page 52179031 "CRM Bulk Update"
{
    PageType = StandardDialog;
    Caption = 'Bulk Update Customers';
    DataCaptionExpression = '';

    layout
    {
        area(content)
        {
            group("Update Criteria")
            {
                Caption = 'Update Criteria';

                field("Filter Customer Type"; FilterCustomerType)
                {
                    ApplicationArea = All;
                    Caption = 'Filter by Customer Type';
                    ToolTip = 'Select customer type to filter records for update.';
                }
                field("Filter Lead Status"; FilterLeadStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Filter by Lead Status';
                    ToolTip = 'Select lead status to filter records for update.';
                }
                field("Filter Segmentation"; FilterSegmentation)
                {
                    ApplicationArea = All;
                    Caption = 'Filter by Segmentation';
                    ToolTip = 'Select segmentation code to filter records for update.';
                    TableRelation = "CRM Segmentation";
                }
                field("Filter VIP Only"; FilterVIPOnly)
                {
                    ApplicationArea = All;
                    Caption = 'VIP Customers Only';
                    ToolTip = 'Update only VIP customers.';
                }
            }

            group("Update Fields")
            {
                Caption = 'Fields to Update';

                field("Update Customer Type"; UpdateCustomerType)
                {
                    ApplicationArea = All;
                    Caption = 'Update Customer Type';
                    ToolTip = 'Check to update customer type for selected records.';
                }
                field("New Customer Type"; NewCustomerType)
                {
                    ApplicationArea = All;
                    Caption = 'New Customer Type';
                    ToolTip = 'New customer type value.';
                    Enabled = UpdateCustomerType;
                }
                field("Update Lead Status"; UpdateLeadStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Update Lead Status';
                    ToolTip = 'Check to update lead status for selected records.';
                }
                field("New Lead Status"; NewLeadStatus)
                {
                    ApplicationArea = All;
                    Caption = 'New Lead Status';
                    ToolTip = 'New lead status value.';
                    Enabled = UpdateLeadStatus;
                }
                field("Update Segmentation"; UpdateSegmentation)
                {
                    ApplicationArea = All;
                    Caption = 'Update Segmentation';
                    ToolTip = 'Check to update segmentation for selected records.';
                }
                field("New Segmentation"; NewSegmentation)
                {
                    ApplicationArea = All;
                    Caption = 'New Segmentation';
                    ToolTip = 'New segmentation code.';
                    TableRelation = "CRM Segmentation";
                    Enabled = UpdateSegmentation;
                }
                field("Update VIP Status"; UpdateVIP)
                {
                    ApplicationArea = All;
                    Caption = 'Update VIP Status';
                    ToolTip = 'Check to update VIP status for selected records.';
                }
                field("New VIP Status"; NewVIP)
                {
                    ApplicationArea = All;
                    Caption = 'New VIP Status';
                    ToolTip = 'New VIP status value.';
                    Enabled = UpdateVIP;
                }
                field("Update Email Opt-In"; UpdateEmailOptIn)
                {
                    ApplicationArea = All;
                    Caption = 'Update Email Opt-In';
                    ToolTip = 'Check to update email opt-in for selected records.';
                }
                field("New Email Opt-In"; NewEmailOptIn)
                {
                    ApplicationArea = All;
                    Caption = 'New Email Opt-In';
                    ToolTip = 'New email opt-in value.';
                    Enabled = UpdateEmailOptIn;
                }
                field("Update SMS Opt-In"; UpdateSMSOptIn)
                {
                    ApplicationArea = All;
                    Caption = 'Update SMS Opt-In';
                    ToolTip = 'Check to update SMS opt-in for selected records.';
                }
                field("New SMS Opt-In"; NewSMSOptIn)
                {
                    ApplicationArea = All;
                    Caption = 'New SMS Opt-In';
                    ToolTip = 'New SMS opt-in value.';
                    Enabled = UpdateSMSOptIn;
                }
                field("Update Do Not Contact"; UpdateDoNotContact)
                {
                    ApplicationArea = All;
                    Caption = 'Update Do Not Contact';
                    ToolTip = 'Check to update do not contact flag for selected records.';
                }
                field("New Do Not Contact"; NewDoNotContact)
                {
                    ApplicationArea = All;
                    Caption = 'New Do Not Contact';
                    ToolTip = 'New do not contact value.';
                    Enabled = UpdateDoNotContact;
                }
                field("Update Inactive Status"; UpdateInactive)
                {
                    ApplicationArea = All;
                    Caption = 'Update Inactive Status';
                    ToolTip = 'Check to update inactive status for selected records.';
                }
                field("New Inactive Status"; NewInactive)
                {
                    ApplicationArea = All;
                    Caption = 'New Inactive Status';
                    ToolTip = 'New inactive status value.';
                    Enabled = UpdateInactive;
                }
                field("Add Tags"; AddTags)
                {
                    ApplicationArea = All;
                    Caption = 'Add Tags';
                    ToolTip = 'Check to add tags to selected records.';
                }
                field("Tags to Add"; TagsToAdd)
                {
                    ApplicationArea = All;
                    Caption = 'Tags to Add';
                    ToolTip = 'Tags to add (separated by commas).';
                    Enabled = AddTags;
                }
            }

            group("Preview")
            {
                Caption = 'Preview';

                field("Records to Update"; RecordsToUpdate)
                {
                    ApplicationArea = All;
                    Caption = 'Records to Update';
                    ToolTip = 'Number of records that will be updated.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Preview")
            {
                ApplicationArea = All;
                Caption = 'Preview';
                Image = View;
                ToolTip = 'Preview records that will be updated.';

                trigger OnAction()
                begin
                    PreviewUpdate();
                end;
            }
            action("Update")
            {
                ApplicationArea = All;
                Caption = 'Update';
                Image = UpdateDescription;
                ToolTip = 'Execute bulk update.';

                trigger OnAction()
                begin
                    if not Confirm('Do you want to update %1 customer records?', false, RecordsToUpdate) then
                        exit;
                    
                    ExecuteBulkUpdate();
                end;
            }
        }
    }

    var
        FilterCustomerType: Enum "CRM Customer Type";
        FilterLeadStatus: Enum "CRM Lead Status";
        FilterSegmentation: Code[20];
        FilterVIPOnly: Boolean;
        UpdateCustomerType: Boolean;
        NewCustomerType: Enum "CRM Customer Type";
        UpdateLeadStatus: Boolean;
        NewLeadStatus: Enum "CRM Lead Status";
        UpdateSegmentation: Boolean;
        NewSegmentation: Code[20];
        UpdateVIP: Boolean;
        NewVIP: Boolean;
        UpdateEmailOptIn: Boolean;
        NewEmailOptIn: Boolean;
        UpdateSMSOptIn: Boolean;
        NewSMSOptIn: Boolean;
        UpdateDoNotContact: Boolean;
        NewDoNotContact: Boolean;
        UpdateInactive: Boolean;
        NewInactive: Boolean;
        AddTags: Boolean;
        TagsToAdd: Text[250];
        RecordsToUpdate: Integer;

    local procedure PreviewUpdate()
    var
        Customer: Record "CRM Customer";
    begin
        ApplyFilters(Customer);
        RecordsToUpdate := Customer.Count;
        CurrPage.Update(false);
    end;

    local procedure ExecuteBulkUpdate()
    var
        Customer: Record "CRM Customer";
        UpdatedCount: Integer;
    begin
        ApplyFilters(Customer);
        
        if Customer.FindSet() then
            repeat
                if UpdateCustomerType then
                    Customer."Customer Type" := NewCustomerType;
                
                if UpdateLeadStatus then
                    Customer."Lead Status" := NewLeadStatus;
                
                if UpdateSegmentation then
                    Customer."Segmentation Code" := NewSegmentation;
                
                if UpdateVIP then
                    Customer."VIP" := NewVIP;
                
                if UpdateEmailOptIn then
                    Customer."Email Opt-In" := NewEmailOptIn;
                
                if UpdateSMSOptIn then
                    Customer."SMS Opt-In" := NewSMSOptIn;
                
                if UpdateDoNotContact then
                    Customer."Do Not Contact" := NewDoNotContact;
                
                if UpdateInactive then
                    Customer."Inactive" := NewInactive;
                
                if AddTags and (TagsToAdd <> '') then begin
                    if Customer."Tags" <> '' then
                        Customer."Tags" := Customer."Tags" + ',' + TagsToAdd
                    else
                        Customer."Tags" := TagsToAdd;
                end;
                
                Customer.Modify(true);
                UpdatedCount += 1;
            until Customer.Next() = 0;

        Message('Successfully updated %1 customer records.', UpdatedCount);
        CurrPage.Close();
    end;

    local procedure ApplyFilters(var Customer: Record "CRM Customer")
    begin
        Customer.Reset();
        
        if FilterCustomerType <> FilterCustomerType::" " then
            Customer.SetRange("Customer Type", FilterCustomerType);
        
        if FilterLeadStatus <> FilterLeadStatus::" " then
            Customer.SetRange("Lead Status", FilterLeadStatus);
        
        if FilterSegmentation <> '' then
            Customer.SetRange("Segmentation Code", FilterSegmentation);
        
        if FilterVIPOnly then
            Customer.SetRange("VIP", true);
    end;

    trigger OnOpenPage()
    begin
        PreviewUpdate();
    end;
}