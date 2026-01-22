report 50833 TestResults
{
    Caption = 'TestResults';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = Tasks;
    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            trigger OnAfterGetRecord()
            var
                WebPortals: Codeunit webportals;
            begin

                //WebPortals.InsertExamResults('P101', 'P101/1366G/19', 'SEM2 24/25', 'COM 450', 72, 'EXAM', '0395', 'Vancy Jebichii Kebut');

                //StudNo: Code[20]; LectNo: Code[20]; Marks: Decimal; UnitCode: Code[20]
                WebPortals.SubmitSpecialAndSupplementary('P107/4589G/23', '0584', 40, 'MAT 115')
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
