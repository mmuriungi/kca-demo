report 50816 "Audit Program"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/AuditProgram.rdl';
    Caption = 'Audit Program';

    dataset
    {
        dataitem("Audit Header"; "Audit Header")
        {
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompAddr2; CompanyInfo."Address 2")
            {
            }
            column(Audit_Period; "Audit Period")
            { }
            column(CompCity; CompanyInfo.City)
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(No_AuditHeader; "Audit Header"."No.")
            {
            }
            column(Date_AuditHeader; "Audit Header".Date)
            {
            }
            column(Introduction; Introduction)
            { }
            column(BackGround; BackGround)
            { }
            column(Audit_Approach; "Audit Approach")
            { }
            column(Description_AuditHeader; "Audit Header".Description)
            {
            }
            column(ShortcutDimension1Code; "Audit Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; AuditMgt.GetDimensionValue("Audit Header"."Shortcut Dimension 2 Code"))
            {
            }
            column(CreatedBy_AuditHeader; AuditMgt.GetEmployeeName("Audit Header"."Created By"))
            {
            }
            column(AuditFirm_AuditHeader; "Audit Header"."Audit Firm")
            {
            }
            column(AuditManager_AuditHeader; "Audit Header"."Audit Manager")
            {
            }
            dataitem("Audit Lines"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Audit Line Type", "Audit Code", "Line No.") ORDER(Ascending);
                column(AuditDescription2; "Audit Lines"."Audit Description")
                {
                }
                column(WorkPlanRef; "Audit Lines"."WorkPlan Ref")
                {
                }
                column(DoneBy; "Audit Lines"."Done By")
                {
                }
                column(Date; "Audit Lines".Date)
                {
                }
                column(AuditLineType; "Audit Lines"."Audit Line Type")
                {
                }
                column(AuditDescription; DNotesText)
                {
                }
                column(Auditor_AuditLines; "Audit Lines".Auditor)
                {
                }
                column(AuditorName_AuditLines; "Audit Lines"."Auditor Name")
                {
                }
                column(Approver; GetUserNameFromUserID(Approver[1]))
                {
                }
                column(ProgramScope_AuditLines; DNotesText)
                {
                }
                column(Review_AuditLines; "Audit Lines".Review)
                {
                }
                column(Review_Scope_No; "Audit Lines"."Review Scope No.")
                {
                }
                column(Procedures_Prepared_By; "Audit Lines"."Procedure Prepared By.")
                {
                }
                column(ReviewProcedure_AuditLines; DNotesTextReviewProcedure)
                {
                }
                column(Objective; Objective)
                { }
                column(Scope; Scope)
                { }
                column(Auditor; Auditor)
                { }
                column(Auditor_Name; "Auditor Name")
                { }


                trigger OnAfterGetRecord()
                begin
                    DNotesText := '';
                    DNotesText := "Audit Lines".Description;
                    DNotesTextReviewProcedure := '';
                    DNotesTextReviewProcedure := "Audit Lines"."Review Procedure Blob";
                end;
            }
            dataitem("Risk Exposure"; "Risk Exposure")
            {
                DataItemLink = "No." = FIELD("No.");
                column(Risk_Exposure; "Risk Exposure")
                { }
                column(Risk_Exposure_Description; "Risk Exposure Description")
                { }
            }
            dataitem("Activities & Deliverables"; "Activities & Deliverables")
            {
                DataItemLink = "No." = FIELD("No.");
                column(Activities_And_Deliverables; "Activities And Deliverables")
                { }
                column(Prelimary_Dates; "Prelimary Dates")
                { }

            }
            trigger OnAfterGetRecord()
            begin

                ApprovalEntry.RESET;
                ApprovalEntry.SETCURRENTKEY("Document No.", "Sequence No.");
                ApprovalEntry.SETRANGE("Document No.", "Audit Header"."No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                IF ApprovalEntry.FIND('-') THEN BEGIN
                    REPEAT
                        CASE TRUE OF
                            ApprovalEntry."Sequence No." = 1:
                                BEGIN
                                    Approver[1] := ApprovalEntry."Last Modified By User ID";
                                END;
                            ApprovalEntry."Sequence No." = 2:
                                BEGIN
                                    Approver[2] := ApprovalEntry."Last Modified By User ID";
                                END;
                        END;
                    UNTIL ApprovalEntry.NEXT = 0;
                END;
            end;
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

    trigger OnPreReport()
    begin

        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Instr: InStream;
        DNotes: BigText;
        DNotesText: Text;
        OutStr: OutStream;
        AuditLine: Record "Audit Lines";
        AuditMgt: Codeunit "Internal Audit Management";
        ApprovalEntry: Record "Approval Entry";
        Approver: array[100] of Code[50];
        UserSetup: Record "User Setup";
        Employee: Record "HRM-Employee C";
        DNotesReviewProcedure: BigText;
        InstrReviewProcedure: InStream;
        DNotesTextReviewProcedure: Text;
        OutStrReviewProcedure: OutStream;

    local procedure GetUserNameFromUserID(UserName: Code[50]): Text
    begin
        IF UserSetup.GET(UserName) THEN BEGIN
            IF Employee.GET(UserSetup."Employee No.") THEN
                EXIT(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
        END;
    end;
}

