page 56266 "Custmer Bulk SMS"
{
    PageType = Card;
    Caption = 'Send Customer Bulk SMS';
    //SourceTable = Customer; 
    //SourceTable = SmsModel; 

    layout
    {
        area(content)
        {
            field(MessageText; MessageText) // Message input
            {
                Caption = 'SMS Message';
                ToolTip = 'Enter the message to be sent.';
                MultiLine = true;
                ShowMandatory = true;
            }

            field(ScheduleDateOnly; ScheduleDateOnly)
            {
                Caption = 'Schedule Date';
                ToolTip = 'Select the date.';
                ShowMandatory = true;
            }

            field(ScheduleTimeOnly; ScheduleTimeOnly)
            {
                Caption = 'Schedule Time';
                ToolTip = 'Enter the time (HH:MM:SS).';
                ShowMandatory = true;
            }
            field(CustomerType; CustomerType)
            {
                Caption = 'CustomerType';
                ToolTip = 'Select Customer Group to send sms to';
                OptionCaption = '--Select--,All,Students,Teaching-Staffs,non-Staff,Vendors,Suppliers';
                ShowMandatory = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendCustomerBulkSMS)
            {
                Caption = 'Send Bulk SMS';
                ToolTip = 'Send SMS to selected phone numbers.';
                Promoted = true;
                trigger OnAction()
                begin
                    SendCustomerSMS();
                end;
            }
        }
    }

    procedure SendCustomerSMS()
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
        case CustomerType of
            2:
                Customers.SetRange("Customer Posting Group", 'STUDENT');
            3:
                Customers.SetRange("Customer Posting Group", 'Teaching-Staffs');
            4:
                Customers.SetRange("Customer Posting Group", 'non-Staff');
            5:
                Customers.SetRange("Customer Posting Group", 'Vendors');
            6:
                Customers.SetRange("Customer Posting Group", 'Suppliers');
        // No filter applied if CustomerType is 0 ("--Select--") or 1 ("All")
        end;
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
        CustomerType: Option;
}