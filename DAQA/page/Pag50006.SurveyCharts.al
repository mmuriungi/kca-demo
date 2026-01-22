page 52055 "Survey Charts"
{
    Caption = 'Survey Charts';
    PageType = Card;

    SourceTable = "Survey Header";

    layout
    {
        area(Content)
        {

            usercontrol(Chart; Charts)
            {
                ApplicationArea = all;


                trigger ControlReady()
                var
                    Customer: Record Customer;
                    Data: JsonArray;
                    JsonA: JsonArray;
                    ProjHandler: Codeunit "DAQA Quiz Handler";
                    JsonString: Text;
                    Json: JsonObject;
                    JsonToken: JsonToken;
                begin
                    JsonString := ProjHandler.GenerateGoogleChartsData(Rec."Survey Code");
                    Json.ReadFrom(JsonString);
                    Json.Get('questions', JsonToken);
                    JsonA := JsonToken.AsArray();
                    CurrPage.Chart.GenerateChart(JsonA);
                end;
            }
        }
    }
}
