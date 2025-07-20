codeunit 52179081 "Legal Affairs Installer"
{
    Subtype = Install;
    
    trigger OnInstallAppPerCompany()
    begin
        SetupLegalAffairsData();
    end;
    
    trigger OnInstallAppPerDatabase()
    begin
        // Database-level installation tasks if needed
    end;
    
    local procedure SetupLegalAffairsData()
    begin
        SetupLegalAffairsConfiguration();
        SetupNumberSeries();
        SetupDefaultData();
        
        Message('Legal Affairs Management module has been successfully installed and configured.');
    end;
    
    local procedure SetupLegalAffairsConfiguration()
    var
        LegalSetup: Record "Legal Affairs Setup";
    begin
        if not LegalSetup.Get() then begin
            LegalSetup.Init();
            LegalSetup."Primary Key" := '';
            LegalSetup."Contract Expiry Alert Days" := 90;
            LegalSetup."Deadline Alert Days" := 7;
            LegalSetup."Court Date Reminder Days" := 7;
            LegalSetup."Enable Email Notifications" := true;
            LegalSetup."Legal Department Email" := 'legal@karatinauniversity.ac.ke';
            LegalSetup."Default Document Storage Path" := 'C:\LegalDocs\';
            LegalSetup.Insert();
        end;
    end;
    
    local procedure SetupNumberSeries()
    var
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
    begin
        // Create Legal Case Number Series
        CreateNumberSeries('LEGALCASE', 'Legal Case Numbers', 'CASE{YYYYMMDD}-{0000}', NoSeries, NoSeriesLine);
        UpdateLegalSetupWithNoSeries('LEGALCASE', 'Case Nos.');
        
        // Create Legal Document Number Series
        CreateNumberSeries('LEGALDOC', 'Legal Document Numbers', 'DOC{YYYY}-{0000}', NoSeries, NoSeriesLine);
        UpdateLegalSetupWithNoSeries('LEGALDOC', 'Document Nos.');
        
        // Create Legal Invoice Number Series
        CreateNumberSeries('LEGALINV', 'Legal Invoice Numbers', 'LINV{YY}{MM}-{000}', NoSeries, NoSeriesLine);
        UpdateLegalSetupWithNoSeries('LEGALINV', 'Legal Invoice Nos.');
        
        // Create Compliance Task Number Series
        CreateNumberSeries('COMPLIANCE', 'Compliance Task Numbers', 'COMP{YYYY}-{000}', NoSeries, NoSeriesLine);
        UpdateLegalSetupWithNoSeries('COMPLIANCE', 'Compliance Task Nos.');
    end;
    
    local procedure CreateNumberSeries(SeriesCode: Code[20]; SeriesDescription: Text[100]; NumberFormat: Text[50]; var NoSeries: Record "No. Series"; var NoSeriesLine: Record "No. Series Line")
    begin
        if not NoSeries.Get(SeriesCode) then begin
            NoSeries.Init();
            NoSeries.Code := SeriesCode;
            NoSeries.Description := SeriesDescription;
            NoSeries."Default Nos." := true;
            NoSeries."Manual Nos." := false;
            NoSeries.Insert();
        end;
        
        NoSeriesLine.SetRange("Series Code", SeriesCode);
        if not NoSeriesLine.FindFirst() then begin
            NoSeriesLine.Init();
            NoSeriesLine."Series Code" := SeriesCode;
            NoSeriesLine."Line No." := 10000;
            NoSeriesLine."Starting Date" := Today;
            
            case SeriesCode of
                'LEGALCASE':
                    begin
                        NoSeriesLine."Starting No." := 'CASE' + Format(Today, 0, '<Year4><Month,2><Day,2>') + '-0001';
                        NoSeriesLine."Ending No." := 'CASE' + Format(Today, 0, '<Year4><Month,2><Day,2>') + '-9999';
                        NoSeriesLine."Increment-by No." := 1;
                    end;
                'LEGALDOC':
                    begin
                        NoSeriesLine."Starting No." := 'DOC' + Format(Date2DMY(Today, 3)) + '-0001';
                        NoSeriesLine."Ending No." := 'DOC' + Format(Date2DMY(Today, 3)) + '-9999';
                        NoSeriesLine."Increment-by No." := 1;
                    end;
                'LEGALINV':
                    begin
                        NoSeriesLine."Starting No." := 'LINV' + Format(Today, 0, '<Year,2><Month,2>') + '-001';
                        NoSeriesLine."Ending No." := 'LINV' + Format(Today, 0, '<Year,2><Month,2>') + '-999';
                        NoSeriesLine."Increment-by No." := 1;
                    end;
                'COMPLIANCE':
                    begin
                        NoSeriesLine."Starting No." := 'COMP' + Format(Date2DMY(Today, 3)) + '-001';
                        NoSeriesLine."Ending No." := 'COMP' + Format(Date2DMY(Today, 3)) + '-999';
                        NoSeriesLine."Increment-by No." := 1;
                    end;
            end;
            
            NoSeriesLine.Insert();
        end;
    end;
    
    local procedure UpdateLegalSetupWithNoSeries(SeriesCode: Code[20]; FieldName: Text[50])
    var
        LegalSetup: Record "Legal Affairs Setup";
    begin
        if LegalSetup.Get() then begin
            case FieldName of
                'Case Nos.':
                    LegalSetup."Case Nos." := SeriesCode;
                'Document Nos.':
                    LegalSetup."Document Nos." := SeriesCode;
                'Legal Invoice Nos.':
                    LegalSetup."Legal Invoice Nos." := SeriesCode;
                'Compliance Task Nos.':
                    LegalSetup."Compliance Task Nos." := SeriesCode;
            end;
            LegalSetup.Modify();
        end;
    end;
    
    local procedure SetupDefaultData()
    begin
        SetupRoleCenter();
        SetupMenuItems();
    end;
    
    local procedure SetupRoleCenter()
    var
        AllProfile: Record "All Profile";
    begin
        if not AllProfile.Get('', 'LEGALAFFAIRS') then begin
            AllProfile.Init();
            AllProfile."Profile ID" := 'LEGALAFFAIRS';
            AllProfile.Description := 'Legal Affairs Manager';
            AllProfile."Role Center ID" := Page::"Legal Affairs Role Center";
            AllProfile.Enabled := true;
            AllProfile.Promoted := true;
            AllProfile."Default Role Center" := false;
            AllProfile.Insert();
        end;
    end;
    
    local procedure SetupMenuItems()
    begin
        // This would set up any additional menu items or shortcuts needed
        // for the Legal Affairs module
    end;
}