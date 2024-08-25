page 50304 "Student Affairs Data Viz"
{
    PageType = Cardpart;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            usercontrol(ChartControl; BusinessChart)
            {
                ApplicationArea = All;

                trigger AddInReady()
                begin
                    LoadChartData();
                end;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RefreshChart)
            {
                ApplicationArea = All;
                Caption = 'Refresh Chart';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LoadChartData();
                    CurrPage.Update();
                end;
            }
        }
    }

    local procedure LoadChartData()
    var
        Student: Record Customer;
        ChartData: JsonArray;
        DataPoint: JsonObject;
    begin
        if Student.FindSet() then
            repeat
                Clear(DataPoint);
                DataPoint.Add('Name', Student.Name);
                DataPoint.Add('ClubEngagement', Student."Club Engagement Score");
                DataPoint.Add('LeaveUsage', Student."Leave Usage");
                DataPoint.Add('CounselingSessions', Student."Counseling Sessions");
                ChartData.Add(DataPoint);
            until Student.Next() = 0;

        SetChartProperties();
    end;

    local procedure SetChartProperties()
    var
        ChartProperties: JsonObject;
    begin
        ChartProperties.Add('type', 'bar');
        ChartProperties.Add('legendPosition', 'right');
        ChartProperties.Add('legendTitle', 'Metrics');
        ChartProperties.Add('xAxisTitle', 'Students');
        ChartProperties.Add('yAxisTitle', 'Score');
        CurrPage.ChartControl.update(ChartProperties);
    end;
}
