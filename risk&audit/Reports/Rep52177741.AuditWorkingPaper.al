report 50817 "Audit Working Paper"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/AuditWorkingPaper.rdlc';

    dataset
    {
        dataitem("Audit Header"; "Audit Header")
        {
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompCity; CompanyInfo.City)
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
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
            column(No_AuditHeader; "Audit Header"."No.")
            {
            }
            column(Date_AuditHeader; "Audit Header".Date)
            {
            }
            column(CreatedBy_AuditHeader; "Audit Header"."Created By")
            {
            }
            column(Status_AuditHeader; "Audit Header".Status)
            {
            }
            column(CutOffPeriod_AuditHeader; "Audit Header"."Cut-Off Period")
            {
            }
            column(ReviewedBy_AuditHeader; "Audit Header"."Reviewed By")
            {
            }
            column(AuditManager_AuditHeader; "Audit Header"."Audit Manager")
            {
            }
            column(AuditFirm_AuditHeader; "Audit Header"."Audit Firm")
            {
            }
            column(ShortcutDimension2Code_AuditHeader; "Audit Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Title_AuditHeader; "Audit Header".Title)
            {
            }
            column(DateCompleted; "Audit Header"."Date Completed")
            {
            }
            column(DateReviewed; "Audit Header"."Date Reviewed")
            {
            }
            dataitem("Audit Lines"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Audit Line Type", "Audit Code", "Line No.") ORDER(Ascending);
                column(AuditDescription_AuditLines; DNotesText)
                {
                }
                column(AuditLineType; "Audit Lines"."Audit Line Type")
                {
                }
                column(Comment; "Audit Lines".Comment)
                {
                }
                column(DifferencesExplained; "Audit Lines"."Differences Explained")
                {
                }
                column(ReportsReviewed; "Audit Lines"."Reports Reviewed")
                {
                }
                column(Description_AuditHeader; "Audit Lines"."Description 2")
                {
                }
                column(Image_AuditLines; AuditLine.Image)
                {
                }
                column(AuditWorkingDescription_AuditLines; DNotesTextD2)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DNotesText := "Audit Lines".Description;
                    DNotesTextD2 := "Audit Lines"."Description 2 Blob";
                    //End of Conversion

                    AuditLine.Reset;
                    AuditLine.SetRange("Document No.", "Audit Header"."No.");
                    if AuditLine.Find('-') then begin
                        AuditLine.CalcFields(Image);
                    end;
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
        CompanyInfo.CalcFields(Picture/* , "Reports Header", "Reports Footer" */);
        ;
        "Audit Lines".CalcFields(Image);
    end;

    var
        CompanyInfo: Record "Company Information";
        Instr: InStream;
        DNotes: BigText;
        DNotesText: Text;
        OutStr: OutStream;
        AuditLine: Record "Audit Lines";
        InstrD2: InStream;
        DNotesD2: BigText;
        DNotesTextD2: Text;
        OutStrD2: OutStream;
}

