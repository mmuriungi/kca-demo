codeunit 52179082 "Legal Affairs Upgrade"
{
    Subtype = Upgrade;
    
    trigger OnUpgradePerCompany()
    begin
        UpgradeLegalAffairsData();
    end;
    
    trigger OnUpgradePerDatabase()
    begin
        // Database-level upgrade tasks if needed
    end;
    
    local procedure UpgradeLegalAffairsData()
    begin
        UpgradeLegalAffairsSetup();
        UpgradeExistingData();
        
        Message('Legal Affairs Management module has been successfully upgraded.');
    end;
    
    local procedure UpgradeLegalAffairsSetup()
    var
        LegalSetup: Record "Legal Affairs Setup";
    begin
        if LegalSetup.Get() then begin
            // Update any new fields or settings that might have been added in newer versions
            if LegalSetup."Court Date Reminder Days" = 0 then
                LegalSetup."Court Date Reminder Days" := 7;
            if LegalSetup."Contract Expiry Alert Days" = 0 then
                LegalSetup."Contract Expiry Alert Days" := 90;
            if LegalSetup."Deadline Alert Days" = 0 then
                LegalSetup."Deadline Alert Days" := 7;
            
            LegalSetup.Modify();
        end;
    end;
    
    local procedure UpgradeExistingData()
    var
        LegalCase: Record "Legal Case";
        LegalDocument: Record "Legal Document";
        ComplianceTask: Record "Legal Compliance Task";
    begin
        // Update existing Legal Cases
        LegalCase.SetRange("Court Date Reminder", 0D);
        if LegalCase.FindSet() then
            repeat
                if LegalCase."Next Court Date" <> 0D then begin
                    LegalCase."Court Date Reminder" := CalcDate('-1W', LegalCase."Next Court Date");
                    LegalCase.Modify();
                end;
            until LegalCase.Next() = 0;
        
        // Update existing Legal Documents
        LegalDocument.SetRange("Is View Only", false);
        if LegalDocument.FindSet() then
            repeat
                LegalDocument."Is View Only" := true;
                LegalDocument.Modify();
            until LegalDocument.Next() = 0;
        
        // Update existing Compliance Tasks - set default risk levels
        ComplianceTask.SetRange("Risk Level", ComplianceTask."Risk Level"::" ");
        if ComplianceTask.FindSet() then
            repeat
                case ComplianceTask.Priority of
                    ComplianceTask.Priority::Critical:
                        ComplianceTask."Risk Level" := ComplianceTask."Risk Level"::Critical;
                    ComplianceTask.Priority::High:
                        ComplianceTask."Risk Level" := ComplianceTask."Risk Level"::High;
                    ComplianceTask.Priority::Medium:
                        ComplianceTask."Risk Level" := ComplianceTask."Risk Level"::Medium;
                    else
                        ComplianceTask."Risk Level" := ComplianceTask."Risk Level"::Low;
                end;
                ComplianceTask.Modify();
            until ComplianceTask.Next() = 0;
    end;
}