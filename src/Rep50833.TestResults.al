report 50833 TestResults
{
    Caption = 'TestResults';
    ProcessingOnly=true;
    ApplicationArea=all;
    UsageCategory=Tasks;
    dataset
    {
        dataitem("Company Information";"Company Information")
        {
            trigger OnAfterGetRecord()
            var
            WebPortals: Codeunit webportals;
            begin
                /*
                 <web:programz>P101</web:programz>
            <web:studNoz>P101/1366G/19</web:studNoz>
            <web:semesterz>SEM2 24/25</web:semesterz>
            <web:unitz>COM 450</web:unitz>
            <web:scorez>72</web:scorez>
            <web:examTypez>EXAM</web:examTypez>
            <web:userNamez>0395</web:userNamez>
            <web:lecturerNamez>Vancy Jebichii Kebut</web:lecturerNamez>
                */
                WebPortals.InsertExamResults('P101','P101/1366G/19','SEM2 24/25','COM 450',72,'EXAM','0395','Vancy Jebichii Kebut');
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
