controladdin Charts
{
    StartupScript = 'DAQA\charts\script.js';
    Scripts = 'DAQA\charts\script.js', 'https://www.gstatic.com/charts/loader.js';
    HorizontalStretch = true;
    VerticalStretch = true;

    event ControlReady();
    procedure GenerateChart(Data: JsonArray);
}