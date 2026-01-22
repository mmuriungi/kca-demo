Report 50542 "ACA-Update Unit Exam Category"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/AcaUpdateExamCategory.rdl';

    dataset
    {
        dataitem(units; "ACA-Units/Subjects")
        {

            column(ProgrammeCode_units; "Programme Code")
            {
            }
            column(StageCode_units; "Stage Code")
            {
            }
            column(Code_units; "Code")
            {
            }
            column(Desription_units; Desription)
            {
            }
            column(CreditHours_units; "Credit Hours")
            {
            }

            trigger OnAfterGetRecord()
            begin
                units2.Reset();
                units2.SetRange("Code", "Code");
                units2.SetRange("Programme Code", "Programme Code");
                units2.SetRange("Stage Code", "Stage Code");
                if units2.Find('-') then begin
                    repeat
                        ACAProgramme.Reset();
                        ACAProgramme.SetRange(Code, units2."Programme Code");
                        if ACAProgramme.Find('-') then begin
                            If units2."Default Exam Category" = '' then begin
                                units2."Default Exam Category" := ACAProgramme."Exam Category";
                                units2.Validate("Default Exam Category");
                                units2.Modify();
                            end ELSE
                                units2.Validate("Default Exam Category");
                            units2.Modify();
                        end;

                    until units2.Next() = 0;
                end;
            end;
        }
    }
    var
        units2: Record "ACA-Units/Subjects";
        ACAProgramme: Record "ACA-Programme";
}