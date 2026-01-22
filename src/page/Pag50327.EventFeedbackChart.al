// Page: Event Feedback Chart
page 50327 "Event Feedback Chart"
{
    PageType = CardPart;
    Caption = 'Event Feedback';

    layout
    {
        area(content)
        {
            usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;

                trigger AddInReady()
                begin
                    UpdateChart();
                end;

                trigger Refresh()
                begin
                    UpdateChart();
                end;
            }
        }
    }

    local procedure UpdateChart()
    var
        EventFeedback: Record "Event Feedback";
        BusinessChartBuffer: Record "Business Chart Buffer" temporary;
        i: Integer;
    begin
        BusinessChartBuffer.Initialize();
        BusinessChartBuffer.SetXAxis('Rating', BusinessChartBuffer."Data Type"::String);
        // BusinessChartBuffer.SetYAxis('Count', BusinessChartBuffer."Data Type"::Integer);

        for i := 1 to 5 do begin
            EventFeedback.SetRange(Rating, i);
            //BusinessChartBuffer.AddMeasure(Format(i), EventFeedback.Count);
        end;

        BusinessChartBuffer.Update(CurrPage.Chart);
    end;
}
