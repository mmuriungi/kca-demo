// Page: Equipment Usage Chart
page 52021 "Equipment Usage Chart"
{
    PageType = CardPart;
    Caption = 'Equipment Usage by Game';

    layout
    {
        area(content)
        {
            usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;

                trigger AddInReady()
                begin
                    IsChartAddInReady := true;
                    UpdateData();
                end;

                trigger Refresh()
                begin
                    IsChartAddInReady := true;
                end;
            }
        }
    }

    var
        BusinessChartBuffer: Record "Business Chart Buffer" temporary;
        IsChartAddInReady: Boolean;

    trigger OnAfterGetRecord()
    begin
        UpdateData();
    end;

    local procedure UpdateData()
    begin
        if not IsChartAddInReady then
            exit;

        BusinessChartBuffer.Initialize();
        PopulateData();
        BusinessChartBuffer.Update(CurrPage.BusinessChart);
    end;

    local procedure PopulateData()
    var
        Game: Record Game;
        EquipmentIssuance: Record "Equipment Issuance";
        i: Integer;
    begin
        BusinessChartBuffer.SetXAxis('Game', BusinessChartBuffer."Data Type"::String);
        BusinessChartBuffer.AddMeasure('Usage Count', 1, BusinessChartBuffer."Data Type"::Integer, BusinessChartBuffer."Chart Type"::Column);
        if Game.FindSet() then
            repeat
                i += 1;
                EquipmentIssuance.SetRange("Game Code", Game.Code);
                BusinessChartBuffer.AddColumn(Game.Name);
                BusinessChartBuffer.SetValue('Equpment Count', i, EquipmentIssuance.Count);
            until Game.Next() = 0;
    end;
}
