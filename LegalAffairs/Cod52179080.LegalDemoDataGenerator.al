codeunit 52179080 "Legal Demo Data Generator"
{
    Subtype = Normal;
    
    trigger OnRun()
    begin
        if not Confirm('This will generate demo data for Legal Affairs module. Do you want to continue?', false) then
            exit;
            
        GenerateLegalAffairsSetup();
        GenerateLegalCases();
        GenerateLegalDocuments();
        GenerateComplianceTasks();
        GenerateLegalInvoices();
        GenerateRiskAssessments();
        GenerateCalendarEntries();
        GenerateCaseParties();
        GenerateCourtHearings();
        
        Message('Legal Affairs demo data has been generated successfully.');
    end;
    
    local procedure GenerateLegalAffairsSetup()
    var
        LegalSetup: Record "Legal Affairs Setup";
    begin
        if not LegalSetup.Get() then begin
            LegalSetup.Init();
            LegalSetup."Primary Key" := '';
            LegalSetup."Case Nos." := 'CASE';
            LegalSetup."Document Nos." := 'LEGDOC';
            LegalSetup."Legal Invoice Nos." := 'LEGINV';
            LegalSetup."Compliance Task Nos." := 'COMPLY';
            LegalSetup."Contract Expiry Alert Days" := 90;
            LegalSetup."Deadline Alert Days" := 7;
            LegalSetup."Court Date Reminder Days" := 7;
            LegalSetup."Enable Email Notifications" := true;
            LegalSetup."Legal Department Email" := 'legal@karatinauniversity.ac.ke';
            Evaluate(LegalSetup."Risk Assessment Period", '3M');
            LegalSetup.Insert();
        end;
    end;
    
    local procedure GenerateLegalCases()
    var
        LegalCase: Record "Legal Case";
        i: Integer;
    begin
        for i := 1 to 15 do begin
            Clear(LegalCase);
            LegalCase.Init();
            LegalCase."Case No." := 'CASE' + Format(i, 0, '<Integer,4><Filler Character,0>');
            
            case i mod 5 of
                0:
                    begin
                        LegalCase."Case Type" := LegalCase."Case Type"::Litigation;
                        LegalCase."Case Category" := LegalCase."Case Category"::"Labor Law";
                        LegalCase."Case Title" := 'Employee Termination Dispute - ' + Format(i);
                        LegalCase."Plaintiff/Claimant" := 'Former Employee ' + Format(i);
                        LegalCase."Defendant/Respondent" := 'Karatina University';
                        LegalCase."Claim Amount" := 500000 + (i * 100000);
                    end;
                1:
                    begin
                        LegalCase."Case Type" := LegalCase."Case Type"::"Contract Dispute";
                        LegalCase."Case Category" := LegalCase."Case Category"::"Contract Law";
                        LegalCase."Case Title" := 'Service Contract Breach - Vendor ' + Format(i);
                        LegalCase."Plaintiff/Claimant" := 'Karatina University';
                        LegalCase."Defendant/Respondent" := 'Vendor Company ' + Format(i);
                        LegalCase."Claim Amount" := 1000000 + (i * 200000);
                    end;
                2:
                    begin
                        LegalCase."Case Type" := LegalCase."Case Type"::"Intellectual Property";
                        LegalCase."Case Category" := LegalCase."Case Category"::"Intellectual Property";
                        LegalCase."Case Title" := 'Patent Infringement Case ' + Format(i);
                        LegalCase."Plaintiff/Claimant" := 'Karatina University Research Dept';
                        LegalCase."Defendant/Respondent" := 'Tech Company ' + Format(i);
                        LegalCase."Claim Amount" := 2000000 + (i * 500000);
                    end;
                3:
                    begin
                        LegalCase."Case Type" := LegalCase."Case Type"::"Internal Legal Issue";
                        LegalCase."Case Category" := LegalCase."Case Category"::"Student Affairs";
                        LegalCase."Case Title" := 'Student Disciplinary Matter ' + Format(i);
                        LegalCase."Plaintiff/Claimant" := 'University Disciplinary Committee';
                        LegalCase."Defendant/Respondent" := 'Student ' + Format(i);
                        LegalCase."Claim Amount" := 0;
                    end;
                4:
                    begin
                        LegalCase."Case Type" := LegalCase."Case Type"::Civil;
                        LegalCase."Case Category" := LegalCase."Case Category"::"Property Law";
                        LegalCase."Case Title" := 'Land Dispute - Parcel ' + Format(i);
                        LegalCase."Plaintiff/Claimant" := 'Karatina University';
                        LegalCase."Defendant/Respondent" := 'Adjacent Property Owner ' + Format(i);
                        LegalCase."Claim Amount" := 5000000 + (i * 1000000);
                    end;
            end;
            
            LegalCase.Description := 'Demo case for testing purposes. ' + LegalCase."Case Title";
            LegalCase."Filing Date" := CalcDate('<-' + Format(i * 30) + 'D>', Today);
            LegalCase."Court Name" := 'Karatina Law Courts';
            LegalCase."Court File Number" := 'KLR/' + Format(Date2DMY(Today, 3)) + '/' + Format(i * 100);
            
            case i mod 4 of
                0:
                    LegalCase."Case Status" := LegalCase."Case Status"::Open;
                1:
                    LegalCase."Case Status" := LegalCase."Case Status"::"In Progress";
                2:
                    LegalCase."Case Status" := LegalCase."Case Status"::Ongoing;
                3:
                    LegalCase."Case Status" := LegalCase."Case Status"::Closed;
            end;
            
            case i mod 3 of
                0:
                    LegalCase.Priority := LegalCase.Priority::High;
                1:
                    LegalCase.Priority := LegalCase.Priority::Medium;
                2:
                    LegalCase.Priority := LegalCase.Priority::Low;
            end;
            
            case i mod 4 of
                0:
                    LegalCase."Risk Level" := LegalCase."Risk Level"::High;
                1:
                    LegalCase."Risk Level" := LegalCase."Risk Level"::Medium;
                2:
                    LegalCase."Risk Level" := LegalCase."Risk Level"::Low;
                3:
                    LegalCase."Risk Level" := LegalCase."Risk Level"::Critical;
            end;
            
            LegalCase."Lead Counsel" := 'EMP001';
            LegalCase."External Counsel" := 'Advocate ' + SelectRandomName(i);
            LegalCase."External Counsel Firm" := SelectRandomLawFirm(i);
            LegalCase."Judge/Magistrate" := 'Hon. Justice ' + SelectRandomName(i + 10);
            LegalCase."Department Code" := 'LEGAL';
            LegalCase."Estimated Costs" := 100000 + (i * 50000);
            
            if LegalCase."Case Status" in [LegalCase."Case Status"::Open, LegalCase."Case Status"::"In Progress"] then
                LegalCase."Next Court Date" := CalcDate('<+' + Format(i mod 30 + 1) + 'D>', Today);
                
            LegalCase."Notice Type" := LegalCase."Notice Type"::Plaint;
            LegalCase.Insert();
        end;
    end;
    
    local procedure GenerateLegalDocuments()
    var
        LegalDoc: Record "Legal Document";
        i: Integer;
    begin
        for i := 1 to 20 do begin
            Clear(LegalDoc);
            LegalDoc.Init();
            LegalDoc."Document No." := 'LEGDOC' + Format(i, 0, '<Integer,4><Filler Character,0>');
            
            case i mod 6 of
                0:
                    begin
                        LegalDoc."Document Type" := LegalDoc."Document Type"::Charter;
                        LegalDoc."Document Title" := 'University Charter Amendment ' + Format(i);
                    end;
                1:
                    begin
                        LegalDoc."Document Type" := LegalDoc."Document Type"::Policy;
                        LegalDoc."Document Title" := 'HR Policy Document v' + Format(i);
                    end;
                2:
                    begin
                        LegalDoc."Document Type" := LegalDoc."Document Type"::Contract;
                        LegalDoc."Document Title" := 'Service Agreement - ' + Format(i);
                    end;
                3:
                    begin
                        LegalDoc."Document Type" := LegalDoc."Document Type"::"Court Filing";
                        LegalDoc."Document Title" := 'Court Filing - Case ' + Format(i mod 15 + 1);
                    end;
                4:
                    begin
                        LegalDoc."Document Type" := LegalDoc."Document Type"::"Legal Opinion";
                        LegalDoc."Document Title" := 'Legal Opinion on Matter ' + Format(i);
                    end;
                5:
                    begin
                        LegalDoc."Document Type" := LegalDoc."Document Type"::Judgment;
                        LegalDoc."Document Title" := 'Court Judgment - Case ' + Format(i mod 15 + 1);
                    end;
            end;
            
            LegalDoc.Description := 'Demo document for ' + LegalDoc."Document Title";
            if i mod 3 = 0 then
                LegalDoc."Case No." := 'CASE' + Format(i mod 15 + 1, 0, '<Integer,4><Filler Character,0>');
            if i mod 4 = 0 then
                LegalDoc."Contract No." := 'PROJ-000' + Format(i mod 10 + 1);
                
            LegalDoc."Document Date" := CalcDate('<-' + Format(i * 10) + 'D>', Today);
            if i mod 5 = 0 then
                LegalDoc."Expiry Date" := CalcDate('<+' + Format(i * 30) + 'D>', Today);
                
            LegalDoc."Filed By" := UserId;
            LegalDoc."File Name" := LegalDoc."Document Title" + '.pdf';
            LegalDoc."File Extension" := 'PDF';
            LegalDoc."File Size (KB)" := 100 + (i * 50);
            LegalDoc.Keywords := 'legal, document, ' + Format(LegalDoc."Document Type");
            
            case i mod 4 of
                0:
                    LegalDoc."Access Level" := LegalDoc."Access Level"::Public;
                1:
                    LegalDoc."Access Level" := LegalDoc."Access Level"::Internal;
                2:
                    LegalDoc."Access Level" := LegalDoc."Access Level"::Confidential;
                3:
                    LegalDoc."Access Level" := LegalDoc."Access Level"::"Highly Confidential";
            end;
            
            LegalDoc."Approval Status" := LegalDoc."Approval Status"::Approved;
            LegalDoc."Department Code" := 'LEGAL';
            LegalDoc."Is View Only" := true;
            LegalDoc.Insert();
        end;
    end;
    
    local procedure GenerateComplianceTasks()
    var
        CompTask: Record "Legal Compliance Task";
        i: Integer;
    begin
        for i := 1 to 12 do begin
            Clear(CompTask);
            CompTask.Init();
            CompTask."Task No." := 'COMPLY' + Format(i, 0, '<Integer,4><Filler Character,0>');
            
            case i mod 6 of
                0:
                    begin
                        CompTask."Compliance Type" := CompTask."Compliance Type"::"Employment Law";
                        CompTask."Task Description" := 'Annual employment law compliance review';
                        CompTask."Regulation/Law" := 'Employment Act 2007';
                    end;
                1:
                    begin
                        CompTask."Compliance Type" := CompTask."Compliance Type"::"Data Privacy";
                        CompTask."Task Description" := 'GDPR compliance audit';
                        CompTask."Regulation/Law" := 'Data Protection Act 2019';
                    end;
                2:
                    begin
                        CompTask."Compliance Type" := CompTask."Compliance Type"::"Health and Safety";
                        CompTask."Task Description" := 'Workplace safety inspection';
                        CompTask."Regulation/Law" := 'Occupational Safety and Health Act';
                    end;
                3:
                    begin
                        CompTask."Compliance Type" := CompTask."Compliance Type"::"Tax Compliance";
                        CompTask."Task Description" := 'Quarterly tax returns filing';
                        CompTask."Regulation/Law" := 'Income Tax Act';
                    end;
                4:
                    begin
                        CompTask."Compliance Type" := CompTask."Compliance Type"::"Academic Regulations";
                        CompTask."Task Description" := 'CUE compliance requirements';
                        CompTask."Regulation/Law" := 'Universities Act 2012';
                    end;
                5:
                    begin
                        CompTask."Compliance Type" := CompTask."Compliance Type"::"Anti-Corruption";
                        CompTask."Task Description" := 'Anti-corruption policy review';
                        CompTask."Regulation/Law" := 'Anti-Corruption and Economic Crimes Act';
                    end;
            end;
            
            CompTask."Due Date" := CalcDate('<+' + Format(i * 15) + 'D>', Today);
            CompTask."Assigned To" := 'EMP00' + Format(i mod 5 + 1);
            
            case i mod 4 of
                0:
                    CompTask.Status := CompTask.Status::Open;
                1:
                    CompTask.Status := CompTask.Status::"In Progress";
                2:
                    CompTask.Status := CompTask.Status::Completed;
                3:
                    if CompTask."Due Date" < Today then
                        CompTask.Status := CompTask.Status::Overdue
                    else
                        CompTask.Status := CompTask.Status::Open;
            end;
            
            case i mod 3 of
                0:
                    CompTask.Priority := CompTask.Priority::High;
                1:
                    CompTask.Priority := CompTask.Priority::Medium;
                2:
                    CompTask.Priority := CompTask.Priority::Low;
            end;
            
            CompTask."Risk Level" := CompTask.Priority;
            CompTask."Penalty Amount" := 50000 * (i mod 10 + 1);
            
            case i mod 4 of
                0:
                    CompTask.Frequency := CompTask.Frequency::Annually;
                1:
                    CompTask.Frequency := CompTask.Frequency::Quarterly;
                2:
                    CompTask.Frequency := CompTask.Frequency::Monthly;
                3:
                    CompTask.Frequency := CompTask.Frequency::"One-Time";
            end;
            
            CompTask."Department Code" := 'LEGAL';
            CompTask."Evidence Required" := 'Compliance certificate, audit report';
            CompTask.Insert();
        end;
    end;
    
    local procedure GenerateLegalInvoices()
    var
        LegalInv: Record "Legal Invoice";
        i: Integer;
    begin
        for i := 1 to 10 do begin
            Clear(LegalInv);
            LegalInv.Init();
            LegalInv."Invoice No." := 'LEGINV' + Format(i, 0, '<Integer,4><Filler Character,0>');
            LegalInv."Invoice Date" := CalcDate('<-' + Format(i * 5) + 'D>', Today);
            
            if i mod 2 = 0 then
                LegalInv."Case No." := 'CASE' + Format(i mod 15 + 1, 0, '<Integer,4><Filler Character,0>');
                
            LegalInv."Vendor No." := 'V00' + Format(i mod 5 + 1);
            LegalInv."Vendor Name" := SelectRandomLawFirm(i);
            LegalInv."External Counsel" := 'Advocate ' + SelectRandomName(i);
            
            case i mod 5 of
                0:
                    LegalInv."Service Type" := LegalInv."Service Type"::"Legal Consultation";
                1:
                    LegalInv."Service Type" := LegalInv."Service Type"::"Court Representation";
                2:
                    LegalInv."Service Type" := LegalInv."Service Type"::"Document Preparation";
                3:
                    LegalInv."Service Type" := LegalInv."Service Type"::"Court Fees";
                4:
                    LegalInv."Service Type" := LegalInv."Service Type"::"Filing Fees";
            end;
            
            LegalInv.Description := 'Legal services for ' + Format(LegalInv."Service Type");
            
            if LegalInv."Service Type" in [LegalInv."Service Type"::"Legal Consultation", 
                                           LegalInv."Service Type"::"Court Representation",
                                           LegalInv."Service Type"::"Document Preparation"] then begin
                LegalInv."Hours Worked" := 10 + (i * 5);
                LegalInv."Hourly Rate" := 5000 + (i * 500);
                LegalInv."Amount (LCY)" := LegalInv."Hours Worked" * LegalInv."Hourly Rate";
            end else begin
                LegalInv."Amount (LCY)" := 10000 + (i * 5000);
            end;
            
            LegalInv."VAT Amount" := LegalInv."Amount (LCY)" * 0.16;
            LegalInv."Total Amount" := LegalInv."Amount (LCY)" + LegalInv."VAT Amount";
            
            case i mod 4 of
                0:
                    LegalInv."Payment Status" := LegalInv."Payment Status"::Pending;
                1:
                    LegalInv."Payment Status" := LegalInv."Payment Status"::Approved;
                2:
                    LegalInv."Payment Status" := LegalInv."Payment Status"::Posted;
                3:
                    LegalInv."Payment Status" := LegalInv."Payment Status"::Paid;
            end;
            
            LegalInv."Due Date" := CalcDate('<30D>', LegalInv."Invoice Date");
            LegalInv."Department Code" := 'LEGAL';
            LegalInv."Budget Code" := 'LEGAL-EXP';
            LegalInv.Insert();
        end;
    end;
    
    local procedure GenerateRiskAssessments()
    var
        RiskAssess: Record "Legal Risk Assessment";
        i: Integer;
    begin
        for i := 1 to 8 do begin
            Clear(RiskAssess);
            RiskAssess.Init();
            RiskAssess."Assessment No." := 'RISK' + Format(i, 0, '<Integer,4><Filler Character,0>');
            
            case i mod 5 of
                0:
                    begin
                        RiskAssess."Risk Type" := RiskAssess."Risk Type"::"Contract Risk";
                        RiskAssess."Risk Description" := 'Potential breach of service contract terms';
                    end;
                1:
                    begin
                        RiskAssess."Risk Type" := RiskAssess."Risk Type"::"Litigation Risk";
                        RiskAssess."Risk Description" := 'Ongoing litigation may result in financial loss';
                    end;
                2:
                    begin
                        RiskAssess."Risk Type" := RiskAssess."Risk Type"::"Compliance Risk";
                        RiskAssess."Risk Description" := 'Non-compliance with regulatory requirements';
                    end;
                3:
                    begin
                        RiskAssess."Risk Type" := RiskAssess."Risk Type"::"Data Privacy Risk";
                        RiskAssess."Risk Description" := 'Potential data breach exposure';
                    end;
                4:
                    begin
                        RiskAssess."Risk Type" := RiskAssess."Risk Type"::"Employment Risk";
                        RiskAssess."Risk Description" := 'Labor dispute escalation risk';
                    end;
            end;
            
            if i mod 3 = 0 then
                RiskAssess."Case No." := 'CASE' + Format(i mod 15 + 1, 0, '<Integer,4><Filler Character,0>');
            if i mod 4 = 0 then
                RiskAssess."Contract No." := 'PROJ-000' + Format(i mod 10 + 1);
                
            case i mod 3 of
                0:
                    RiskAssess.Probability := RiskAssess.Probability::High;
                1:
                    RiskAssess.Probability := RiskAssess.Probability::Medium;
                2:
                    RiskAssess.Probability := RiskAssess.Probability::Low;
            end;
            
            case i mod 3 of
                0:
                    RiskAssess.Impact := RiskAssess.Impact::Major;
                1:
                    RiskAssess.Impact := RiskAssess.Impact::Moderate;
                2:
                    RiskAssess.Impact := RiskAssess.Impact::Minor;
            end;
            
            RiskAssess."Mitigation Strategy" := 'Implement controls and monitoring for ' + Format(RiskAssess."Risk Type");
            RiskAssess."Responsible Person" := 'EMP00' + Format(i mod 5 + 1);
            RiskAssess."Assessment Date" := Today;
            RiskAssess."Review Date" := CalcDate('<3M>', Today);
            RiskAssess.Status := RiskAssess.Status::Active;
            RiskAssess."Financial Impact" := 100000 * (i mod 10 + 1);
            RiskAssess."Department Code" := 'LEGAL';
            RiskAssess."Legal Opinion Required" := i mod 2 = 0;
            RiskAssess.Insert();
        end;
    end;
    
    local procedure GenerateCalendarEntries()
    var
        CalEntry: Record "Legal Calendar Entry";
        i: Integer;
    begin
        for i := 1 to 15 do begin
            Clear(CalEntry);
            CalEntry.Init();
            
            case i mod 5 of
                0:
                    begin
                        CalEntry."Event Type" := CalEntry."Event Type"::"Court Date";
                        CalEntry."Event Description" := 'Court hearing for Case ' + Format(i mod 15 + 1);
                    end;
                1:
                    begin
                        CalEntry."Event Type" := CalEntry."Event Type"::"Filing Deadline";
                        CalEntry."Event Description" := 'Filing deadline for legal documents';
                    end;
                2:
                    begin
                        CalEntry."Event Type" := CalEntry."Event Type"::"Contract Renewal";
                        CalEntry."Event Description" := 'Contract renewal reminder';
                    end;
                3:
                    begin
                        CalEntry."Event Type" := CalEntry."Event Type"::Meeting;
                        CalEntry."Event Description" := 'Legal team meeting';
                    end;
                4:
                    begin
                        CalEntry."Event Type" := CalEntry."Event Type"::"Compliance Deadline";
                        CalEntry."Event Description" := 'Compliance submission deadline';
                    end;
            end;
            
            CalEntry."Event Date" := CalcDate('<+' + Format(i * 2) + 'D>', Today);
            CalEntry."Event Time" := 090000T + (i * 10000);
            
            if i mod 3 = 0 then
                CalEntry."Case No." := 'CASE' + Format(i mod 15 + 1, 0, '<Integer,4><Filler Character,0>');
                
            CalEntry.Location := 'Conference Room ' + Format(i mod 5 + 1);
            CalEntry."Responsible Person" := 'EMP00' + Format(i mod 5 + 1);
            
            case i mod 3 of
                0:
                    CalEntry.Priority := CalEntry.Priority::High;
                1:
                    CalEntry.Priority := CalEntry.Priority::Medium;
                2:
                    CalEntry.Priority := CalEntry.Priority::Low;
            end;
            
            CalEntry.Status := CalEntry.Status::Scheduled;
            CalEntry."Department Code" := 'LEGAL';
            CalEntry.Insert();
        end;
    end;
    
    local procedure GenerateCaseParties()
    var
        CaseParty: Record "Legal Case Party";
        i: Integer;
    begin
        for i := 1 to 20 do begin
            Clear(CaseParty);
            CaseParty.Init();
            CaseParty."Case No." := 'CASE' + Format((i - 1) div 2 + 1, 0, '<Integer,4><Filler Character,0>');
            
            if i mod 2 = 1 then begin
                CaseParty."Party Type" := CaseParty."Party Type"::Plaintiff;
                CaseParty."Party Name" := 'Plaintiff ' + SelectRandomName(i);
            end else begin
                CaseParty."Party Type" := CaseParty."Party Type"::Defendant;
                CaseParty."Party Name" := 'Defendant ' + SelectRandomName(i);
            end;
            
            CaseParty."Party ID/Registration No." := 'ID' + Format(1000000 + i * 1000);
            CaseParty."Legal Representative" := 'Advocate ' + SelectRandomName(i + 20);
            CaseParty."Law Firm" := SelectRandomLawFirm(i);
            CaseParty."Contact Person" := SelectRandomName(i + 10);
            CaseParty."Phone No." := '+254' + Format(700000000 + i * 1000);
            CaseParty.Email := LowerCase(DelChr(CaseParty."Contact Person", '=', ' ')) + '@example.com';
            CaseParty.Address := 'P.O. Box ' + Format(i * 100) + ' Karatina';
            
            if i mod 5 = 0 then
                CaseParty."Is University Party" := true;
                
            CaseParty.Insert();
        end;
    end;
    
    local procedure GenerateCourtHearings()
    var
        Hearing: Record "Legal Court Hearing";
        i: Integer;
    begin
        for i := 1 to 12 do begin
            Clear(Hearing);
            Hearing.Init();
            Hearing."Case No." := 'CASE' + Format(i mod 10 + 1, 0, '<Integer,4><Filler Character,0>');
            Hearing."Hearing Date" := CalcDate('<+' + Format(i * 7) + 'D>', Today);
            Hearing."Hearing Time" := 090000T + (i * 10000);
            
            case i mod 4 of
                0:
                    Hearing."Hearing Type" := Hearing."Hearing Type"::Mention;
                1:
                    Hearing."Hearing Type" := Hearing."Hearing Type"::"Pre-Trial";
                2:
                    Hearing."Hearing Type" := Hearing."Hearing Type"::"Main Hearing";
                3:
                    Hearing."Hearing Type" := Hearing."Hearing Type"::Ruling;
            end;
            
            Hearing."Court Room" := 'Court Room ' + Format(i mod 5 + 1);
            Hearing."Presiding Judge" := 'Hon. Justice ' + SelectRandomName(i + 30);
            Hearing."Legal Counsel Present" := 'Advocate ' + SelectRandomName(i) + ', Advocate ' + SelectRandomName(i + 40);
            Hearing.Status := Hearing.Status::Scheduled;
            
            if i mod 3 = 0 then begin
                Hearing."Hearing Outcome" := 'Matter adjourned to next hearing date';
                Hearing."Next Hearing Date" := CalcDate('<+30D>', Hearing."Hearing Date");
                Hearing.Status := Hearing.Status::Completed;
            end;
            
            Hearing.Insert();
        end;
    end;
    
    local procedure SelectRandomName(Seed: Integer): Text[50]
    var
        Names: array[20] of Text[50];
    begin
        Names[1] := 'Mwangi';
        Names[2] := 'Kamau';
        Names[3] := 'Njoroge';
        Names[4] := 'Wanjiru';
        Names[5] := 'Kimani';
        Names[6] := 'Mutua';
        Names[7] := 'Ochieng';
        Names[8] := 'Otieno';
        Names[9] := 'Kipchoge';
        Names[10] := 'Wafula';
        Names[11] := 'Nyambura';
        Names[12] := 'Muthoni';
        Names[13] := 'Akinyi';
        Names[14] := 'Chebet';
        Names[15] := 'Ndirangu';
        Names[16] := 'Kariuki';
        Names[17] := 'Odhiambo';
        Names[18] := 'Sang';
        Names[19] := 'Kiptoo';
        Names[20] := 'Muturi';
        
        exit(Names[(Seed mod 20) + 1]);
    end;
    
    local procedure SelectRandomLawFirm(Seed: Integer): Text[100]
    var
        Firms: array[10] of Text[100];
    begin
        Firms[1] := 'Karatina Legal Associates';
        Firms[2] := 'Central Kenya Law Chambers';
        Firms[3] := 'Highland Advocates LLP';
        Firms[4] := 'Justice & Associates';
        Firms[5] := 'Premier Legal Consultants';
        Firms[6] := 'Kenya Law Partners';
        Firms[7] := 'Eagle Legal Services';
        Firms[8] := 'Summit Law Firm';
        Firms[9] := 'Liberty Advocates';
        Firms[10] := 'Unity Legal Practitioners';
        
        exit(Firms[(Seed mod 10) + 1]);
    end;
}