codeunit 56261 "SMS Campaign Management"
{
    procedure SendCampaign(var SMSCampaignHeader: Record "SMS Campaign Header")
    var
        SMSCampaignLine: Record "SMS Campaign Line";
        Window: Dialog;
        TotalCount: Integer;
        ProcessedCount: Integer;
        SuccessCount: Integer;
        FailedCount: Integer;
    begin
        SMSCampaignHeader.TestField(Status, SMSCampaignHeader.Status::Released);
        SMSCampaignHeader.TestField("Message Text");
        
        SMSCampaignLine.SetRange("Campaign No.", SMSCampaignHeader."Campaign No.");
        SMSCampaignLine.SetRange(Selected, true);
        SMSCampaignLine.SetFilter("Phone Number", '<>%1', '');
        
        TotalCount := SMSCampaignLine.Count();
        
        if TotalCount = 0 then
            Error('No valid recipients selected for SMS campaign.');
            
        if not Confirm('Send SMS to %1 recipients?', false, TotalCount) then
            exit;
            
        SMSCampaignHeader.Status := SMSCampaignHeader.Status::"In Progress";
        SMSCampaignHeader.Modify(true);
        
        Window.Open('Sending SMS Campaign\' +
                   'Total Recipients: #1###########\' +
                   'Processed: #2###########\' +
                   'Success: #3###########\' +
                   'Failed: #4###########\' +
                   'Progress: @5@@@@@@@@@@');
        
        Window.Update(1, TotalCount);
        
        if SMSCampaignLine.FindSet() then begin
            SendBatchSMS(SMSCampaignLine, SMSCampaignHeader, Window, ProcessedCount, SuccessCount, FailedCount, TotalCount);
        end;
        
        Window.Close();
        
        SMSCampaignHeader.Status := SMSCampaignHeader.Status::Completed;
        SMSCampaignHeader."Sent Date" := CurrentDateTime;
        SMSCampaignHeader.Modify(true);
        
        Message('SMS Campaign completed.\Success: %1\Failed: %2', SuccessCount, FailedCount);
    end;

    local procedure SendBatchSMS(var SMSCampaignLine: Record "SMS Campaign Line"; SMSCampaignHeader: Record "SMS Campaign Header"; var Window: Dialog; var ProcessedCount: Integer; var SuccessCount: Integer; var FailedCount: Integer; TotalCount: Integer)
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        JsonObject: JsonObject;
        SmsArray: JsonArray;
        SmsItem: JsonObject;
        ResponseJson: JsonObject;
        JsonToken: JsonToken;
        ResponseText: Text;
        JsonText: Text;
        BatchSize: Integer;
        BatchCount: Integer;
        i: Integer;
        ScheduleDateTime: DateTime;
        FormattedDate: Text;
    begin
        BatchSize := 100;
        
        ScheduleDateTime := CreateDateTime(SMSCampaignHeader."Schedule Date", SMSCampaignHeader."Schedule Time");
        FormattedDate := Format(ScheduleDateTime, 0, '<Year4>-<Month,2>-<Day,2> <Hours24>:<Minutes,2>:<Seconds,2>');
        
        repeat
            Clear(JsonObject);
            Clear(SmsArray);
            BatchCount := 0;
            
            JsonObject.Add('email', 'info@appkings.co.ke');
            JsonObject.Add('sender', 'KaratinaUni');
            JsonObject.Add('schedule', FormattedDate);
            
            repeat
                ProcessedCount += 1;
                BatchCount += 1;
                
                Window.Update(2, ProcessedCount);
                Window.Update(3, SuccessCount);
                Window.Update(4, FailedCount);
                Window.Update(5, Round(ProcessedCount / TotalCount * 10000, 1));
                
                Clear(SmsItem);
                SmsItem.Add('msisdn', SMSCampaignLine."Phone Number");
                SmsItem.Add('message', SMSCampaignHeader."Message Text");
                SmsItem.Add('requestid', Format(SMSCampaignLine."Line No."));
                SmsArray.Add(SmsItem);
                
                SMSCampaignLine.Status := SMSCampaignLine.Status::Pending;
                SMSCampaignLine."Request ID" := Format(SMSCampaignLine."Line No.");
                SMSCampaignLine.Modify(true);
                
            until (SMSCampaignLine.Next() = 0) or (BatchCount >= BatchSize);
            
            JsonObject.Add('sms', SmsArray);
            JsonObject.WriteTo(JsonText);
            
            Clear(HttpRequestMessage);
            HttpRequestMessage.Method('POST');
            HttpRequestMessage.SetRequestUri('https://reseller.standardmedia.co.ke/api/sendmessages');
            
            Clear(HttpContent);
            HttpContent.WriteFrom(JsonText);
            
            if HttpContent.GetHeaders(HttpHeaders) then begin
                HttpHeaders.Remove('Content-Type');
                HttpHeaders.Add('Content-Type', 'application/json');
            end;
            
            HttpRequestMessage.Content := HttpContent;
            
            if HttpRequestMessage.GetHeaders(HttpHeaders) then begin
                HttpHeaders.Add('api_key', '7E765DCB0FA946A5B112856D201D5E2D');
            end;
            
            if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
                HttpResponseMessage.Content().ReadAs(ResponseText);
                
                if ResponseJson.ReadFrom(ResponseText) then
                    ProcessBatchResponse(ResponseJson, SMSCampaignHeader."Campaign No.", SuccessCount, FailedCount)
                else
                    MarkBatchAsFailed(SMSCampaignHeader."Campaign No.", BatchCount, FailedCount, 'Invalid response format');
            end else
                MarkBatchAsFailed(SMSCampaignHeader."Campaign No.", BatchCount, FailedCount, 'HTTP request failed');
                
        until SMSCampaignLine.Next() = 0;
    end;

    local procedure ProcessBatchResponse(ResponseJson: JsonObject; CampaignNo: Code[20]; var SuccessCount: Integer; var FailedCount: Integer)
    var
        SMSCampaignLine: Record "SMS Campaign Line";
        ResponseArray: JsonArray;
        ResponseItem: JsonToken;
        ItemObject: JsonObject;
        JsonToken: JsonToken;
        RequestId: Text;
        Status: Text;
        ErrorMsg: Text;
        i: Integer;
    begin
        if ResponseJson.Get('responses', JsonToken) then begin
            ResponseArray := JsonToken.AsArray();
            
            for i := 0 to ResponseArray.Count() - 1 do begin
                ResponseArray.Get(i, ResponseItem);
                ItemObject := ResponseItem.AsObject();
                
                if ItemObject.Get('requestid', JsonToken) then
                    RequestId := JsonToken.AsValue().AsText();
                    
                if ItemObject.Get('status', JsonToken) then
                    Status := JsonToken.AsValue().AsText();
                    
                if ItemObject.Get('error', JsonToken) then
                    ErrorMsg := JsonToken.AsValue().AsText();
                    
                SMSCampaignLine.SetRange("Campaign No.", CampaignNo);
                SMSCampaignLine.SetRange("Request ID", RequestId);
                
                if SMSCampaignLine.FindFirst() then begin
                    if Status = 'success' then begin
                        SMSCampaignLine.Status := SMSCampaignLine.Status::Sent;
                        SMSCampaignLine."Sent DateTime" := CurrentDateTime;
                        SMSCampaignLine."Response Code" := Status;
                        SuccessCount += 1;
                    end else begin
                        SMSCampaignLine.Status := SMSCampaignLine.Status::Failed;
                        SMSCampaignLine."Error Message" := CopyStr(ErrorMsg, 1, MaxStrLen(SMSCampaignLine."Error Message"));
                        SMSCampaignLine."Response Code" := Status;
                        FailedCount += 1;
                    end;
                    SMSCampaignLine.Modify(true);
                    
                    LogSMSToMaster(SMSCampaignLine, CampaignNo);
                end;
            end;
        end;
    end;

    local procedure MarkBatchAsFailed(CampaignNo: Code[20]; BatchCount: Integer; var FailedCount: Integer; ErrorMessage: Text)
    var
        SMSCampaignLine: Record "SMS Campaign Line";
    begin
        SMSCampaignLine.SetRange("Campaign No.", CampaignNo);
        SMSCampaignLine.SetRange(Status, SMSCampaignLine.Status::Pending);
        SMSCampaignLine.SetRange(Selected, true);
        
        if SMSCampaignLine.FindSet() then
            repeat
                SMSCampaignLine.Status := SMSCampaignLine.Status::Failed;
                SMSCampaignLine."Error Message" := CopyStr(ErrorMessage, 1, MaxStrLen(SMSCampaignLine."Error Message"));
                SMSCampaignLine.Modify(true);
                FailedCount += 1;
                
                LogSMSToMaster(SMSCampaignLine, CampaignNo);
            until (SMSCampaignLine.Next() = 0) or (FailedCount >= BatchCount);
    end;

    local procedure LogSMSToMaster(SMSCampaignLine: Record "SMS Campaign Line"; CampaignNo: Code[20])
    var
        GENSMSMaster: Record "GEN-SMS_Master";
        SMSCampaignHeader: Record "SMS Campaign Header";
    begin
        SMSCampaignHeader.Get(CampaignNo);
        
        GENSMSMaster.Init();
        GENSMSMaster.Receiver := SMSCampaignLine."Phone Number";
        GENSMSMaster.Msg := CopyStr(SMSCampaignHeader."Message Text", 1, MaxStrLen(GENSMSMaster.Msg));
        GENSMSMaster.Operator := 'AppKings';
        GENSMSMaster.sms_Type := 'Campaign';
        GENSMSMaster.Sender := 'KaratinaUni';
        GENSMSMaster.Code := CampaignNo;
        
        case SMSCampaignLine.Status of
            SMSCampaignLine.Status::Sent:
                GENSMSMaster.sms_Status := 'Sent';
            SMSCampaignLine.Status::Failed:
                GENSMSMaster.sms_Status := 'Failed';
            else
                GENSMSMaster.sms_Status := 'Pending';
        end;
        
        GENSMSMaster.senttime := CurrentDateTime;
        GENSMSMaster.Insert(true);
    end;
}