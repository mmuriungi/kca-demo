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

        GenerateProjects();
        GenerateContractDocuments();
        GenerateContractInvoices();

        Message('Contract Management demo data generated successfully!\n\n' +
                'Generated:\n' +
                '• 20 Contract Projects\n' +
                '• Contract Documents\n' +
                '• Invoicing Records');
    end;

    local procedure GenerateProjects()
    var
        Project: Record Project;
        ProjectTypes: List of [Text];
        Descriptions: List of [Text];
        i: Integer;
    begin
        // Initialize project types and descriptions
        ProjectTypes.Add('IT Services');
        ProjectTypes.Add('Construction');
        ProjectTypes.Add('Consultancy');
        ProjectTypes.Add('Supply');
        ProjectTypes.Add('Maintenance');

        Descriptions.Add('IT Support and Maintenance Services Contract');
        Descriptions.Add('Academic Building Construction Project');
        Descriptions.Add('Management Consultancy Services');
        Descriptions.Add('Office Equipment Supply Contract');
        Descriptions.Add('Facilities Maintenance Services');

        for i := 1 to 20 do begin
            Clear(Project);
            Project.Init();
            
            // Let the system generate the number
            Project.Insert(true);
            
            // Set project details
            Project.Description := Descriptions.Get(((i - 1) mod Descriptions.Count) + 1) + ' ' + Format(i);
            Project."Contract Summary" := 'Comprehensive ' + LowerCase(ProjectTypes.Get(((i - 1) mod ProjectTypes.Count) + 1)) + 
                                        ' contract for delivery of services as per specifications and terms agreed upon.';
            Project."Estimated Cost" := 1000000 + (i * 200000) + Random(1000000);

            // Set dates
            Project."Start Date" := CalcDate('-' + Format(Random(120)) + 'D', WorkDate());
            Project."Expected End Date" := CalcDate('+' + Format(180 + Random(365)) + 'D', Project."Start Date");
            Project."Date Created" := Project."Start Date" - Random(30);
            Project."Created by" := GetRandomUserId();
            
            // Set status based on dates
            if Project."Start Date" > WorkDate() then
                Project.Status := Project.Status::Scheduled
            else if Project."Expected End Date" < WorkDate() then
                Project.Status := Project.Status::Completed
            else if Random(10) < 2 then
                Project.Status := Project.Status::Pending
            else if Random(10) < 1 then
                Project.Status := Project.Status::Cancelled
            else
                Project.Status := Project.Status::InProgress;

            // Set performance bond and other fields
            Project."Perfomance Bond" := 'PB-' + Format(1000 + i);
            Project."Project Description" := Project.Description + '. ' + Project."Contract Summary";
            
            // Try to set a requester if employee exists
            if SetRandomRequester(Project) then;
            
            Project.Modify(true);
        end;
    end;

    local procedure GenerateContractDocuments()
    var
        Project: Record Project;
        LegalDocument: Record "Legal Document";
        DocumentTitles: List of [Text];
        i: Integer;
    begin
        // Initialize document titles
        DocumentTitles.Add('Service Level Agreement');
        DocumentTitles.Add('Non-Disclosure Agreement');
        DocumentTitles.Add('Terms and Conditions');
        DocumentTitles.Add('Technical Specifications');
        DocumentTitles.Add('Payment Schedule');

        if Project.FindSet() then
            repeat
                // Generate 1-3 documents per project
                for i := 1 to (1 + Random(3)) do begin
                    Clear(LegalDocument);
                    LegalDocument.Init();
                    LegalDocument.Insert(true); // Let system generate Document No.
                    
                    LegalDocument."Document Type" := LegalDocument."Document Type"::Contract;
                    LegalDocument."Document Title" := DocumentTitles.Get(((i - 1) mod DocumentTitles.Count) + 1) + ' - ' + CopyStr(Project.Description, 1, 50);
                    LegalDocument."Case No." := Project."No."; // Link to project
                    LegalDocument."Document Date" := Project."Start Date" - Random(20);
                    LegalDocument."Created By" := GetRandomUserId();
                    LegalDocument."Date Created" := CurrentDateTime;
                    LegalDocument."File Path" := '\\contracts\\' + LegalDocument."Document No." + '.pdf';
                    
                    LegalDocument.Modify();
                end;
            until Project.Next() = 0;
    end;

    local procedure GenerateContractInvoices()
    var
        Project: Record Project;
        LegalInvoice: Record "Legal Invoice";
        ServiceDescriptions: List of [Text];
        i: Integer;
    begin
        ServiceDescriptions.Add('Contract Management Fee');
        ServiceDescriptions.Add('Legal Review Service');
        ServiceDescriptions.Add('Document Preparation');
        ServiceDescriptions.Add('Compliance Review');

        if Project.FindSet() then
            repeat
                // Generate invoices for active/completed projects
                if Project.Status in [Project.Status::InProgress, Project.Status::Completed] then
                    for i := 1 to (1 + Random(2)) do begin
                        Clear(LegalInvoice);
                        LegalInvoice.Init();
                        LegalInvoice.Insert(true); // Let system generate Invoice No.
                        
                        LegalInvoice."Case No." := Project."No.";
                        LegalInvoice."Invoice Date" := CalcDate('+' + Format(i * 45 + Random(30)) + 'D', Project."Start Date");
                        LegalInvoice."Due Date" := CalcDate('+30D', LegalInvoice."Invoice Date");
                        LegalInvoice.Description := ServiceDescriptions.Get(((i - 1) mod ServiceDescriptions.Count) + 1) + ' - ' + CopyStr(Project.Description, 1, 50);
                        LegalInvoice."Service Type" := LegalInvoice."Service Type"::"Legal Consultation";
                        LegalInvoice."Total Amount" := 75000 + Random(300000);
                        LegalInvoice."Created By" := GetRandomUserId();
                        LegalInvoice."Date Created" := CurrentDateTime;
                        
                        // Set payment status
                        if LegalInvoice."Due Date" <= WorkDate() then
                            if Random(10) < 8 then // 80% paid on time
                                LegalInvoice."Payment Status" := LegalInvoice."Payment Status"::Paid
                            else
                                LegalInvoice."Payment Status" := LegalInvoice."Payment Status"::Pending
                        else
                            LegalInvoice."Payment Status" := LegalInvoice."Payment Status"::Pending;
                        
                        LegalInvoice.Modify();
                    end;
            until Project.Next() = 0;
    end;

    local procedure SetRandomRequester(var Project: Record Project): Boolean
    var
        Employee: Record "HRM-Employee C";
        FullName: Text;
    begin
        // Try to find an employee
        if Employee.FindFirst() then begin
            Project.Requester := Employee."No.";
            
            // Build full name
            FullName := Employee."First Name";
            if Employee."Middle Name" <> '' then
                FullName := FullName + ' ' + Employee."Middle Name";
            if Employee."Last Name" <> '' then
                FullName := FullName + ' ' + Employee."Last Name";
            
            Project."Requester Name" := CopyStr(FullName, 1, MaxStrLen(Project."Requester Name"));
            Project."Department Code" := Employee."Department Code";
            Project.Department := Employee."Department Name";
            Project."E-MAIL" := Employee."Company E-Mail";
            Project."Phone No." := Employee."Cellular Phone Number";
            
            exit(true);
        end;
        exit(false);
    end;

    local procedure GetRandomUserId(): Code[50]
    var
        UserIds: List of [Code[50]];
    begin
        UserIds.Add('ADMIN');
        UserIds.Add('LEGAL');
        UserIds.Add('CONTRACT');
        UserIds.Add('MANAGER');
        
        exit(UserIds.Get(Random(UserIds.Count) + 1));
    end;
}