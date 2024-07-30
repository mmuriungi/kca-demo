report 55401 "Audit Evaluation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/AuditEvaluationReport.rdl';

    dataset
    {
        dataitem(DataItem1; "Audit Asssessment Header")
        {
            RequestFilterFields = No, Department, Date, Status;
            column(No_AuditAsssessmentHeader; No)
            {
            }
            column(Date_AuditAsssessmentHeader; Date)
            {
            }
            column(Department_AuditAsssessmentHeader; Department)
            {
            }
            column(DepartmentName_AuditAsssessmentHeader; "Department Name")
            {
            }
            column(CurrentLocation_AuditAsssessmentHeader; "Current Location")
            {
            }
            column(Scope_AuditAsssessmentHeader; Scope)
            {
            }
            column(Process_AuditAsssessmentHeader; Process)
            {
            }
            column(CreatedBy_AuditAsssessmentHeader; "Created By")
            {
            }
            column(Modifiedon_AuditAsssessmentHeader; "Modified on")
            {
            }
            column(ModifiedBy_AuditAsssessmentHeader; "Modified By")
            {
            }
            column(AssessmentStartDate_AuditAsssessmentHeader; "Assessment Start Date")
            {
            }
            column(AssessmentEndDate_AuditAsssessmentHeader; "Assessment End Date")
            {
            }
            column(Asessor_AuditAsssessmentHeader; Asessor)
            {
            }
            column(AssessorName_AuditAsssessmentHeader; "Assessor Name")
            {
            }
            column(ReAssignAssessor_AuditAsssessmentHeader; "Re-Assign Assessor")
            {
            }
            column(ReAssignAssessorName_AuditAsssessmentHeader; "Re-Assign Assessor Name")
            {
            }
            column(Status_AuditAsssessmentHeader; Status)
            {
            }
            column(CompletionRemarks_AuditAsssessmentHeader; "Completion Remarks")
            {
            }
            column(ClosedOn_AuditAsssessmentHeader; "Closed On")
            {
            }
            column(Objective_AuditAsssessmentHeader; Objective)
            {
            }
            column(Remarks_AuditAsssessmentHeader; Remarks)
            {
            }
            column(Archived_AuditAsssessmentHeader; Archived)
            {
            }
            column(ExtDocumentNo_AuditAsssessmentHeader; "Ext. Document No")
            {
            }
            column(NoSeries_AuditAsssessmentHeader; "No Series")
            {
            }
            column(ArchivedOn_AuditAsssessmentHeader; "Archived On")
            {
            }
            column(ArchivedBy_AuditAsssessmentHeader; "Archived By")
            {
            }
            column(Name; CompanyInformation.Name)
            {
            }
            column(constituent; CompanyInformation."Address 2")
            {
            }
            column(city; CompanyInformation.City)
            {
            }
            column(address; CompanyInformation.Address)
            {
            }
            column(phone; CompanyInformation."Phone No.")
            {
            }
            column(picture; CompanyInformation.Picture)
            {
            }
            dataitem(DataItem34; "Audit Assessment Findings")
            {
                DataItemLink = "Risk Assessment Code" = FIELD(No);
                column(RiskAssessmentCode_AuditAssessmentFindings; "Risk Assessment Code")
                {
                }
                column(No_AuditAssessmentFindings; No)
                {
                }
                column(Findings_AuditAssessmentFindings; Findings)
                {
                }
                column(Risks_AuditAssessmentFindings; Risks)
                {
                }
                column(Recommendations_AuditAssessmentFindings; Recommendations)
                {
                }
                column(ActionsTaken_AuditAssessmentFindings; "Actions Taken")
                {
                }
                column(Remarks_AuditAssessmentFindings; Remarks)
                {
                }
                column(counter; counter)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    counter := counter + 1;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        counter := 0;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.RESET;
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        CompanyInformation: Record 79;
        counter: Integer;
}

