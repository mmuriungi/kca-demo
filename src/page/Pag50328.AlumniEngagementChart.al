// Page: Alumni Engagement Chart
page 50328 "Alumni Engagement Chart"
{
    PageType = CardPart;
    Caption = 'Alumni Engagement';

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
        Alumni: Record Customer;
        BusinessChartBuffer: Record "Business Chart Buffer" temporary;
    begin
        BusinessChartBuffer.Initialize();
        BusinessChartBuffer.SetXAxis('Engagement Type', BusinessChartBuffer."Data Type"::String);
        //BusinessChartBuffer.SetYAxis('Count', BusinessChartBuffer."Data Type"::Integer);

        Alumni.SetRange("Last Engagement Date", CalcDate('<-CY>', WorkDate()), CalcDate('<CY>', WorkDate()));
        BusinessChartBuffer.AddMeasure('Engaged Alumni', '', 2, Alumni.Count);

        Alumni.SetFilter("Total Donations", '>0');
        BusinessChartBuffer.AddMeasure('Donors', '', 1, Alumni.Count);

        BusinessChartBuffer.Update(CurrPage.Chart);
    end;
}
