codeunit 52179116 "Contract Demo Data Generator"
{
    trigger OnRun()
    begin
        GenerateContractManagementDemoData();
    end;
    
    procedure GenerateContractManagementDemoData()
    begin
        if not Confirm('This will generate comprehensive demo data for Contract Management. Continue?', false) then
            exit;

        GenerateProjectHeaders();
        GenerateContractDocuments();
        GenerateContractInvoices();

        Message('Contract Management demo data generated successfully!\n\n' +
                'Generated:\n' +
                '• 20 Contract Project Headers\n' +
                '• Contract Documents\n' +
                '• Invoicing Records');
    end;

    local procedure GenerateProjectHeaders()
    var
        ProjectHeader: Record "Project Header(new)";
        ProjectNames: List of [Text];
        Descriptions: List of [Text];
        i: Integer;
    begin
        // Initialize project names and descriptions
        ProjectNames.Add('IT Infrastructure Upgrade');
        ProjectNames.Add('Campus Building Construction');
        ProjectNames.Add('Management System Implementation');
        ProjectNames.Add('Office Equipment Supply');
        ProjectNames.Add('Maintenance Services Contract');
        ProjectNames.Add('Software Development Project');
        ProjectNames.Add('Security Services Contract');
        ProjectNames.Add('Cleaning Services Contract');

        Descriptions.Add('Comprehensive IT infrastructure upgrade including servers, network equipment, and security systems');
        Descriptions.Add('Construction of new academic building with modern facilities and smart classroom technology');
        Descriptions.Add('Implementation of integrated management system for improved operational efficiency');
        Descriptions.Add('Supply and installation of office equipment and furniture for various departments');
        Descriptions.Add('Preventive and corrective maintenance services for buildings and facilities');
        Descriptions.Add('Custom software development for academic and administrative processes');
        Descriptions.Add('Professional security services including personnel and surveillance systems');
        Descriptions.Add('Professional cleaning and sanitation services for all university facilities');

        for i := 1 to 20 do begin
            Clear(ProjectHeader);
            ProjectHeader.Init();
            
            // Set project details
            ProjectHeader."No." := 'PROJ-' + Format(1000 + i);
            ProjectHeader."Project Name" := ProjectNames.Get((i - 1) mod ProjectNames.Count + 1);
            ProjectHeader."Contract Name" := 'Contract ' + Format(i) + ' - ' + ProjectHeader."Project Name";
            ProjectHeader."Contract No" := 'CTR-' + Format(2000 + i);
            ProjectHeader.Description := Descriptions.Get((i - 1) mod Descriptions.Count + 1);
            
            // Set dates
            ProjectHeader."Project Date" := CalcDate('-' + Format(Random(90)) + 'D', WorkDate());
            ProjectHeader."Estimated Start Date" := CalcDate('+' + Format(Random(60)) + 'D', ProjectHeader."Project Date");
            ProjectHeader."Estimated End Date" := CalcDate('+' + Format(180 + Random(365)) + 'D', ProjectHeader."Estimated Start Date");
            
            // Set actual dates for some projects
            if Random(10) < 6 then begin // 60% have started
                ProjectHeader."Actual Start Date" := ProjectHeader."Estimated Start Date" + Random(15) - 7; // +/- 7 days variance
                
                if Random(10) < 4 then begin // 40% of started projects are finished
                    ProjectHeader."Actual End Date" := ProjectHeader."Estimated End Date" + Random(30) - 15; // +/- 15 days variance
                end;
            end;
            
            // Set budget
            ProjectHeader."Project Budget" := 1000000 + (i * 500000) + Random(2000000);
            
            // Set status based on dates and completion
            if ProjectHeader."Actual End Date" <> 0D then
                ProjectHeader.Status := ProjectHeader.Status::Finished
            else if ProjectHeader."Actual Start Date" <> 0D then
                ProjectHeader.Status := ProjectHeader.Status::Approved
            else if ProjectHeader."Estimated Start Date" > WorkDate() then
                case Random(4) of
                    0: ProjectHeader.Status := ProjectHeader.Status::"Pending Approval";
                    1: ProjectHeader.Status := ProjectHeader.Status::Approved;
                    2: ProjectHeader.Status := ProjectHeader.Status::Verified;
                    3: ProjectHeader.Status := ProjectHeader.Status::"Pending Verification";
                end
            else
                ProjectHeader.Status := ProjectHeader.Status::Open;
            
            // Set additional random statuses for variety
            if Random(20) < 1 then
                ProjectHeader.Status := ProjectHeader.Status::Suspended
            else if Random(20) < 1 then
                ProjectHeader.Status := ProjectHeader.Status::Rejected;
                
            ProjectHeader."User ID" := GetRandomUserId();
            
            if ProjectHeader.Insert() then;
        end;
    end;

    local procedure GenerateContractDocuments()
    var
        ProjectHeader: Record "Project Header(new)";
        LegalDocument: Record "Legal Document";
        DocumentTitles: List of [Text];
        i: Integer;
    begin
        // Initialize document titles
        DocumentTitles.Add('Service Level Agreement');
        DocumentTitles.Add('Non-Disclosure Agreement');
        DocumentTitles.Add('Terms and Conditions');
        DocumentTitles.Add('Technical Specifications');
        DocumentTitles.Add('Payment Schedule Agreement');
        DocumentTitles.Add('Performance Bond');
        DocumentTitles.Add('Quality Assurance Plan');

        if ProjectHeader.FindSet() then
            repeat
                // Generate 2-4 documents per project
                for i := 1 to (2 + Random(3)) do begin
                    Clear(LegalDocument);
                    LegalDocument.Init();
                    LegalDocument.Insert(true); // Let system generate Document No.
                    
                    LegalDocument."Document Type" := LegalDocument."Document Type"::Contract;
                    LegalDocument."Document Title" := DocumentTitles.Get((i - 1) mod DocumentTitles.Count + 1) + ' - ' + CopyStr(ProjectHeader."Project Name", 1, 40);
                    LegalDocument."Case No." := ProjectHeader."No."; // Link to project
                    LegalDocument."Document Date" := ProjectHeader."Project Date" + Random(15);
                    LegalDocument."Created By" := GetRandomUserId();
                    LegalDocument."Date Created" := CurrentDateTime;
                    LegalDocument."File Path" := '\\contracts\\' + ProjectHeader."Contract No" + '\\' + LegalDocument."Document No." + '.pdf';
                    
                    LegalDocument.Modify();
                end;
            until ProjectHeader.Next() = 0;
    end;

    local procedure GenerateContractInvoices()
    var
        ProjectHeader: Record "Project Header(new)";
        LegalInvoice: Record "Legal Invoice";
        ServiceDescriptions: List of [Text];
        i: Integer;
    begin
        ServiceDescriptions.Add('Contract Management Fee');
        ServiceDescriptions.Add('Legal Review and Advisory');
        ServiceDescriptions.Add('Document Preparation Service');
        ServiceDescriptions.Add('Compliance and Monitoring');
        ServiceDescriptions.Add('Performance Review Service');

        if ProjectHeader.FindSet() then
            repeat
                // Generate invoices for active projects
                if ProjectHeader.Status in [ProjectHeader.Status::Approved, ProjectHeader.Status::Finished, ProjectHeader.Status::Verified] then
                    for i := 1 to (1 + Random(2)) do begin
                        Clear(LegalInvoice);
                        LegalInvoice.Init();
                        LegalInvoice.Insert(true); // Let system generate Invoice No.
                        
                        LegalInvoice."Case No." := ProjectHeader."No.";
                        LegalInvoice."Invoice Date" := CalcDate('+' + Format(i * 60 + Random(30)) + 'D', ProjectHeader."Estimated Start Date");
                        LegalInvoice."Due Date" := CalcDate('+30D', LegalInvoice."Invoice Date");
                        LegalInvoice.Description := ServiceDescriptions.Get((i - 1) mod ServiceDescriptions.Count + 1) + ' - ' + CopyStr(ProjectHeader."Project Name", 1, 40);
                        LegalInvoice."Service Type" := LegalInvoice."Service Type"::"Legal Consultation";
                        
                        // Calculate amount based on project budget
                        LegalInvoice."Total Amount" := Round(ProjectHeader."Project Budget" * 0.02, 1000) + Random(100000); // 2% of project budget plus variance
                        
                        LegalInvoice."Created By" := GetRandomUserId();
                        LegalInvoice."Date Created" := CurrentDateTime;
                        
                        // Set payment status based on due date
                        if LegalInvoice."Due Date" <= WorkDate() then
                            if Random(10) < 8 then // 80% paid on time
                                LegalInvoice."Payment Status" := LegalInvoice."Payment Status"::Paid
                            else
                                LegalInvoice."Payment Status" := LegalInvoice."Payment Status"::Pending
                        else
                            LegalInvoice."Payment Status" := LegalInvoice."Payment Status"::Pending;
                        
                        LegalInvoice.Modify();
                    end;
            until ProjectHeader.Next() = 0;
    end;

    local procedure GetRandomUserId(): Code[50]
    var
        UserIds: List of [Code[50]];
        RandomIndex: Integer;
    begin
        UserIds.Add('ADMIN');
        UserIds.Add('LEGAL');
        UserIds.Add('CONTRACT');
        UserIds.Add('MANAGER');
        UserIds.Add('FINANCE');
        
        if UserIds.Count = 0 then
            exit('ADMIN');
            
        RandomIndex := (Random(UserIds.Count)) + 1;
        if RandomIndex > UserIds.Count then
            RandomIndex := 1;
            
        exit(UserIds.Get(RandomIndex));
    end;
}