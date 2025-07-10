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
                /*
                 <web:programz>P101</web:programz> B103
            <web:studNoz>P101/1366G/19</web:studNoz> B103/0163G/21
            <web:semesterz>SEM2 24/25</web:semesterz> SEM2 24/25
            <web:unitz>COM 450</web:unitz>PPM 427
            <web:scorez>72</web:scorez>0
            <web:examTypez>EXAM</web:examTypez>CAT
            <web:userNamez>0395</web:userNamez>0266
            <web:lecturerNamez>Vancy Jebichii Kebut</web:lecturerNamez>
                */
                WebPortals.InsertExamResults('P101', 'P101/1366G/19', 'SEM2 24/25', 'COM 450', 72, 'EXAM', '0395', 'Vancy Jebichii Kebut');
                /*
                TEST PARAMS

Student P107/4589G/23
programme P107
stage Y1S1
Unit MAT 115
Score 40
Lec 0584
Sem SEM1 23/24
                */
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
