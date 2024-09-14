page 52043 "Contract Chart"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;

                trigger AddInReady()
                begin
                    CreateChart();
                end;
            }
        }
    }

    local procedure CreateChart()
    var
        Contract: Record "Project Header";
        BusinessChartBuffer: Record "Business Chart Buffer" temporary;
        i: Integer;
    begin
        BusinessChartBuffer.Initialize();
        BusinessChartBuffer.SetXAxis('Contract Type', BusinessChartBuffer."Data Type"::String);

        for i := 0 to 5 do begin
            Contract.SetRange("Contract Type", i);
            BusinessChartBuffer.AddMeasure(Format(Contract."Contract Type"), Contract.Count, BusinessChartBuffer."Data Type"::Integer, i);
        end;

        BusinessChartBuffer.Update(CurrPage.Chart);
    end;
}