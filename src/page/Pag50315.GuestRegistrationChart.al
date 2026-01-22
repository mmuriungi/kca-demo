// Page: Guest Registration Chart
page 50315 "Guest Registration Chart"
{
    PageType = CardPart;
    Caption = 'Guest Registrations';

    layout
    {
        area(content)
        {
            usercontrol(GuestRegistrationChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
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
        GuestRegistration: Record "Guest Registration";
        BusinessChartBuffer: Record "Business Chart Buffer" temporary;
        i: Integer;
    begin

    end;
}
