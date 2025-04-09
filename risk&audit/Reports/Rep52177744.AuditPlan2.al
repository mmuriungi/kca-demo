report 50813 "Audit Plan 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/AuditPlan2.rdl';
    Caption = 'Audit Plan';

    dataset
    {
        dataitem("Audit Header"; "Audit Header")
        {
            DataItemTableView = WHERE(Type = FILTER("Audit Program"));
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyPinNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(Govermentseal; '')
            {

            }
            column(CompanyISONo; CompanyInfo."Registration No.")
            {
            }

            column(No_AuditHeader; "Audit Header"."No.")
            {
            }
            column(ShortcutDimension1Code; "Audit Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; GetDepartmentName("Audit Header"."Shortcut Dimension 2 Code"))
            {
            }
            column(AuditPeriod; "Audit Header"."Audit Period")
            {
            }
            column(Type; "Audit Header".Type)
            {
            }
            column(DepartmentName; "Audit Header"."Department Name")
            {
            }
            column(AuditStatus; "Audit Header"."Document Status")
            {
            }
            dataitem("Audit Lines"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Audit Line Type", "Audit Code", "Line No.") ORDER(Ascending);
                column(AuditType; "Audit Lines"."Audit Type")
                {
                }
                column(Item___Key_Annual_output; "Item & Key Annual output")
                { }
                column(Audit_Objectives; "Audit Objectives")
                { }
                column(Core_Activities; "Core Activities")
                { }
                column(Means_of_verification; "Means of verification")
                { }
                column(Work_Dates; "Work Dates")
                { }
                column(Expected_Report; "Expected Report")
                { }
                column(Reporting_Date; "Reporting Date")
                { }
                column(Responsibility; Responsibility)
                { }
                column(Description; DNotesText)
                {
                }
                column(AuditTypeDescription; "Audit Lines"."Audit Type Description")
                {
                }
                column(StartDate; "Audit Lines"."Start Date")
                {
                }
                column(EndDate; "Audit Lines"."End Date")
                {
                }
                column(RiskRating; "Audit Lines"."Assessment Rating")
                {
                }
                column(Document_No_; "Document No.")
                { }

                trigger OnAfterGetRecord()
                begin

                    
                    DNotesText := "Audit Lines".Description;
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

    trigger OnPreReport()
    begin

        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        ;
    end;

    var
        CompanyInfo: Record "Company Information";
        Instr: InStream;
        DNotes: BigText;
        DNotesText: Text;
        OutStr: OutStream;
        AuditLine: Record "Audit Lines";
        DimensionVal: Record "Dimension Value";
        AuditFile: Text[250];

    local procedure GetDepartmentName(DeptCode: Code[20]): Text[150]
    begin
        DimensionVal.Reset;
        DimensionVal.SetRange(Code, DeptCode);
        if DimensionVal.Find('-') then
            exit(DimensionVal.Name);
    end;
}

