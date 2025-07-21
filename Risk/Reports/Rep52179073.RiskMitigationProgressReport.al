report 52179073 "Risk Mitigation Progress"
{
    Caption = 'Risk Mitigation Progress Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Risk/Reports/RiskMitigationProgress.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem(RiskMitigation; "Risk Mitigation")
        {
            RequestFilterFields = "Risk ID", "Department Code", Status, "Responsible Person";
            
            column(MitigationID; "Mitigation ID") { }
            column(RiskID; "Risk ID") { }
            column(MitigationTitle; "Mitigation Title") { }
            column(MitigationDescription; "Mitigation Description") { }
            column(ActionRequired; "Action Required") { }
            column(ResponsiblePerson; "Responsible Person") { }
            column(DepartmentCode; "Department Code") { }
            column(StartDate; "Start Date") { }
            column(TargetDate; "Target Date") { }
            column(ActualCompletionDate; "Actual Completion Date") { }
            column(Status; Status) { }
            column(ProgressPercent; "Progress %") { }
            column(DaysRemaining; "Days Remaining") { }
            column(BudgetRequired; "Budget Required") { }
            column(BudgetAmount; "Budget Amount") { }
            column(ActualCost; "Actual Cost") { }
            column(ControlEffectiveness; "Control Effectiveness") { }
            column(LastReviewDate; "Last Review Date") { }
            column(NextReviewDate; "Next Review Date") { }
            column(CompanyName; CompanyInfo.Name) { }
            column(ReportTitle; 'Risk Mitigation Progress Report') { }
            column(ReportDate; Today) { }
            column(UserName; UserId) { }
            column(StatusStyle; GetStatusStyle()) { }
            column(RiskTitle; GetRiskTitle()) { }
            
            trigger OnAfterGetRecord()
            begin
                GetRiskInformation();
            end;
        }
    }
    
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowOnlyOverdue; ShowOnlyOverdue)
                    {
                        Caption = 'Show Only Overdue';
                        ApplicationArea = All;
                        
                        trigger OnValidate()
                        begin
                            if ShowOnlyOverdue then begin
                                ShowOnlyAtRisk := false;
                                ShowOnlyCompleted := false;
                            end;
                        end;
                    }
                    field(ShowOnlyAtRisk; ShowOnlyAtRisk)
                    {
                        Caption = 'Show Only At Risk';
                        ApplicationArea = All;
                        
                        trigger OnValidate()
                        begin
                            if ShowOnlyAtRisk then begin
                                ShowOnlyOverdue := false;
                                ShowOnlyCompleted := false;
                            end;
                        end;
                    }
                    field(ShowOnlyCompleted; ShowOnlyCompleted)
                    {
                        Caption = 'Show Only Completed';
                        ApplicationArea = All;
                        
                        trigger OnValidate()
                        begin
                            if ShowOnlyCompleted then begin
                                ShowOnlyOverdue := false;
                                ShowOnlyAtRisk := false;
                            end;
                        end;
                    }
                }
            }
        }
    }
    
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        
        if ShowOnlyOverdue then
            RiskMitigation.SetRange(Status, RiskMitigation.Status::Overdue)
        else if ShowOnlyAtRisk then
            RiskMitigation.SetRange(Status, RiskMitigation.Status::At_Risk)
        else if ShowOnlyCompleted then
            RiskMitigation.SetRange(Status, RiskMitigation.Status::Completed);
    end;
    
    var
        CompanyInfo: Record "Company Information";
        RiskRegister: Record "Risk Register";
        ShowOnlyOverdue: Boolean;
        ShowOnlyAtRisk: Boolean;
        ShowOnlyCompleted: Boolean;
        RiskTitle: Text[100];
    
    local procedure GetStatusStyle(): Text
    begin
        case RiskMitigation.Status of
            RiskMitigation.Status::Completed:
                exit('Favorable');
            RiskMitigation.Status::On_Track:
                exit('Favorable');
            RiskMitigation.Status::At_Risk:
                exit('Ambiguous');
            RiskMitigation.Status::Off_Track:
                exit('Unfavorable');
            RiskMitigation.Status::Overdue:
                exit('Attention');
            else
                exit('None');
        end;
    end;
    
    local procedure GetRiskTitle(): Text[100]
    begin
        exit(RiskTitle);
    end;
    
    local procedure GetRiskInformation()
    begin
        if RiskRegister.Get(RiskMitigation."Risk ID") then
            RiskTitle := RiskRegister."Risk Title"
        else
            RiskTitle := '';
    end;
}