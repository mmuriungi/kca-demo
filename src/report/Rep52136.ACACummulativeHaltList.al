report 52136 "ACA-Cummulative Halt List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ACA-Cummulative Halt List.rdl';

    dataset
    {
        dataitem(ExamCoregcs; "ACA-Exam. Course Registration")
        {
            DataItemTableView = SORTING(Programme, "Programme Option", "Student Number", "Category Order") ORDER(Ascending);
            RequestFilterFields = "Academic Year", "School Code", "Year of Study";
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompMail; CompanyInformation."E-Mail" + '/' + CompanyInformation."Home Page")
            {
            }
            column(CompAddress; CompanyInformation.Address + ',' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City)
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(Prog; ExamCoregcs.Programme)
            {
            }
            column(YoS; ExamCoregcs."Year of Study")
            {
            }
            column(AcadYear; ExamCoregcs."Academic Year")
            {
            }
            column(SchCode; ExamCoregcs."School Code")
            {
            }
            column(StudentNo; ExamCoregcs."Student Number")
            {
            }
            column(StudName; ExamCoregcs."Student Name")
            {
            }
            column(SchName; ExamCoregcs."School Name")
            {
            }
            column(Class; ExamCoregcs.Classification)
            {
            }
            column(ProgName; ExamCoregcs."Programme Name")
            {
            }
            column(Filters; Filters)
            {
            }
            column(seq; ACACummResitSerial."Cumm. Resit Serial")
            {
            }
            dataitem(CummResits; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("Student Number");
                DataItemTableView = WHERE("Processed Marks" = FILTER(true), Passed = FILTER(false));
                column(UnitCode; CummResits.Unit)
                {
                }
                column(UnitDesc; CummResits.Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if StudNos <> CummResits."Student No." then begin
                        StudNos := CummResits."Student No.";
                        seq += 1;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ExamCoregcs.CalcFields("Resit Exists");
                if (ExamCoregcs."Cumm Attained Units" < ExamCoregcs."Cumm. Required Stage Units") then
                    ExamCoregcs."Cummulative Fails" := ExamCoregcs."Cummulative Fails" +
                    (ExamCoregcs."Cumm. Required Stage Units" - ExamCoregcs."Cumm Attained Units");

                if (ExamCoregcs."Cummulative Fails" > 3) then begin
                    ACACummResitSerial.Reset;
                    ACACummResitSerial.SetRange("User ID", UserId);
                    ACACummResitSerial.SetRange("Academic Year", ExamCoregcs.GetFilter("Academic Year"));
                    ACACummResitSerial.SetRange(YoS, Format(YosInteger));
                    ACACummResitSerial.SetRange("School Code", ExamCoregcs.GetFilter("School Code"));
                    ACACummResitSerial.SetRange("Stuent No.", ExamCoregcs."Student Number");
                    if ACACummResitSerial.Find('-') then;
                end else
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                Clear(Filters);
                Clear(YosInteger);
                Clear(seq);
                Filters := ExamCoregcs.GetFilters;
                if Evaluate(YosInteger, ExamCoregcs.GetFilter("Year of Study")) then;
                ACACummResitSerial.Reset;
                ACACummResitSerial.SetRange("User ID", UserId);
                if ACACummResitSerial.Find('-') then ACACummResitSerial.DeleteAll;

                Clear(seq);
                ACAExamCourseRegistration.Reset;
                ACAExamCourseRegistration.SetRange("Academic Year", ExamCoregcs.GetFilter("Academic Year"));
                ACAExamCourseRegistration.SetRange("School Code", ExamCoregcs.GetFilter("School Code"));
                ACAExamCourseRegistration.SetRange("Year of Study", YosInteger);
                if ACAExamCourseRegistration.Find('-') then begin
                    repeat
                    begin
                        ACAExamCourseRegistration.CalcFields("Resit Exists");
                        if (ACAExamCourseRegistration."Cumm Attained Units" < ACAExamCourseRegistration."Cumm. Required Stage Units") then
                            ACAExamCourseRegistration."Cummulative Fails" := ACAExamCourseRegistration."Cummulative Fails" +
                            (ACAExamCourseRegistration."Cumm. Required Stage Units" - ACAExamCourseRegistration."Cumm Attained Units");

                        if (ACAExamCourseRegistration."Cummulative Fails" > 3) then begin
                            ACACummResitSerial.Init;
                            ACACummResitSerial."Stuent No." := ACAExamCourseRegistration."Student Number";
                            ACACummResitSerial."School Code" := ExamCoregcs.GetFilter("School Code");
                            ACACummResitSerial."Academic Year" := ExamCoregcs.GetFilter("Academic Year");
                            ACACummResitSerial.YoS := Format(YosInteger);
                            ACACummResitSerial.Programme := ACAExamCourseRegistration.Programme;
                            ACACummResitSerial."User ID" := UserId;
                            if ACACummResitSerial.Insert then;
                        end;
                    end;
                    until ACAExamCourseRegistration.Next = 0;
                end;


                ACACummResitSerial.Reset;
                ACACummResitSerial.SetRange("User ID", UserId);
                ACACummResitSerial.SetRange("Academic Year", ExamCoregcs.GetFilter("Academic Year"));
                ACACummResitSerial.SetRange(YoS, ExamCoregcs.GetFilter("Year of Study"));
                ACACummResitSerial.SetRange("School Code", ExamCoregcs.GetFilter("School Code"));
                ACACummResitSerial.SetCurrentKey(Programme, "Stuent No.");
                if ACACummResitSerial.Find('-') then begin
                    repeat
                    begin
                        seq := seq + 1;
                        ACACummResitSerial."Cumm. Resit Serial" := seq;
                        ACACummResitSerial.Modify;
                    end;
                    until ACACummResitSerial.Next = 0;
                end;
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

    trigger OnInitReport()
    begin
        CompanyInformation.Reset;
        if CompanyInformation.Find('-') then CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        Filters: Text[1024];
        ACAExamCourseRegistration: Record "ACA-Exam. Course Registration";
        seq: Integer;
        StudNos: Code[20];
        ACACummResitSerial: Record "ACA-Cumm. Resit Serial";
        YosInteger: Integer;
}

