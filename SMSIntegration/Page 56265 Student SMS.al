page 56265 "Student Bulk SMS"
{
    PageType = Card;
    Caption = 'Send Bulk SMS Max';
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            field(MessageText; MessageText)
            {
                ApplicationArea = All;
                Caption = 'SMS Message';
                ToolTip = 'Enter the message to be sent.';
                MultiLine = true;
                Width = 90;
                ShowMandatory = true;
            }

            field(ScheduleDateOnly; ScheduleDateOnly)
            {
                ApplicationArea = All;
                Caption = 'Schedule Date';
                ToolTip = 'Select the date.';
                ShowMandatory = true;
            }

            field(ScheduleTimeOnly; ScheduleTimeOnly)
            {
                ApplicationArea = All;
                Caption = 'Schedule Time';
                ToolTip = 'Enter the time (HH:MM:SS).';
                ShowMandatory = true;
            }

            field(ProgramCode; ProgramCode)
            {
                ApplicationArea = All;
                Caption = 'Select Program';
                ToolTip = 'Select Program to send sms to';
                TableRelation = "ACA-Programme".Code;
                ShowMandatory = true;

                trigger OnValidate()
                begin
                    // Clear Stage when Program changes
                    //if ProgramCode <> xRec.ProgramCode then
                    StageCode := '';
                end;
            }

            field(StageCode; StageCode)
            {
                ApplicationArea = All;
                Caption = 'Select Stage';
                ToolTip = 'Select Stage to send sms to';
                TableRelation = "ACA-Programme Stages".Code;
                ShowMandatory = true;


                trigger OnValidate()
                var
                    ProgStage: Record "ACA-Programme Stages";
                begin
                    if StageCode <> '' then begin
                        ProgStage.Get(StageCode);
                        if ProgStage."Programme Code" <> ProgramCode then
                            Error('Stage %1 does not belong to Program %2', StageCode, ProgramCode);
                    end;
                end;
            }

            field(Streams; Streams)
            {
                ApplicationArea = All;
                Caption = 'Select Stream';
                ToolTip = 'Select Select Stream to send sms to';
                //TableRelation = Streams.Code;
                ShowMandatory = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendStudentBulkSMS)
            {
                ApplicationArea = All;
                Caption = 'Send Bulk SMS';
                ToolTip = 'Send SMS to selected phone numbers.';
                Promoted = true;
                Image = SendTo;

                trigger OnAction()
                begin
                    SendStudentSMS();
                end;
            }
        }
    }

    procedure SendStudentSMS()
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        JsonObject: JsonObject;
        SmsArray: JsonArray;
        SmsItem: JsonObject;
        HttpHeaders: HttpHeaders;
        ResponseText, JsonText : Text;
        Customers: Record Customer;
        PhoneList: List of [Text];
        i, BatchSize : Integer;
    begin
        BatchSize := 100;
        ScheduleDate := CreateDateTime(DMY2Date(Date2DMY(ScheduleDateOnly, 1), Date2DMY(ScheduleDateOnly, 2), Date2DMY(ScheduleDateOnly, 3)), ScheduleTimeOnly);
        FormattedDate := Format(ScheduleDate, 0, '<Year4>-<Month,2>-<Day,2> <Hours24>:<Minutes,2>:<Seconds,2>');

        Customers.Reset();
        Customers.SetRange("Phone No.", '<>');
        Customers.SetRange("Programme", ProgramCode);
        Customers.SetRange("Current Stage", StageCode);
        //Customers.SetRange(Stream, Streams);
        if Customers.FindSet() then begin
            repeat
                PhoneList.Add(Customers."Phone No.");
            until Customers.Next() = 0;
        end;

        JsonObject.Add('email', 'info@appkings.co.ke');
        JsonObject.Add('sender', 'KaratinaUni');
        JsonObject.Add('schedule', FormattedDate);

        Clear(SmsArray);

        i := 1;
        while i <= PhoneList.Count do begin
            Clear(SmsItem);
            SmsItem.Add('msisdn', PhoneList.Get(i));
            SmsItem.Add('message', MessageText);
            SmsItem.Add('requestid', Format(i));
            SmsArray.Add(SmsItem);
            i += 1;
        end;

        JsonObject.Add('sms', SmsArray);
        JsonObject.WriteTo(JsonText);
        HttpRequestMessage.Method('POST');
        HttpRequestMessage.SetRequestUri('https://reseller.standardmedia.co.ke/api/sendmessages');
        HttpContent.WriteFrom(JsonText);

        if HttpContent.GetHeaders(HttpHeaders) then begin
            HttpHeaders.Remove('Content-Type');
            HttpHeaders.Add('Content-Type', 'application/json');
        end;

        HttpRequestMessage.Content := HttpContent;

        if HttpRequestMessage.GetHeaders(HttpHeaders) then begin
            HttpHeaders.Add('api_key', '7E765DCB0FA946A5B112856D201D5E2D');
        end;

        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            HttpResponseMessage.Content().ReadAs(ResponseText);

        Message('Response: %1', ResponseText);
    end;

    var
        MessageText: Text;
        ScheduleDate: DateTime;
        FormattedDate: Text;
        ScheduleDateOnly: Date;
        ScheduleTimeOnly: Time;
        ProgramCode: Code[20];
        Streams: Code[20];
        StageCode: Code[20];
}