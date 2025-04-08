codeunit 50482 "Rest Handler"
{


    procedure CallService(RequestUrl: Text; RequestType: Enum "Http Requests Enum"; payload: Text; Username: Text; Password: Text; ApiKey: text): Text
    var
        Client: HttpClient;
        RequestHeaders: HttpHeaders;
        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        ResponseText: Text;
        contentHeaders: HttpHeaders;
        AuthString: Text;
        AuthText: Text;
    begin
        RequestHeaders := Client.DefaultRequestHeaders();

        // Add Basic Authentication
        if (Username <> '') and (Password <> '') then begin
            AuthString := StrSubstNo('%1:%2', Username, Password);
            AuthText := StrSubstNo('Basic %1', stringToBase64(AuthString));
            RequestHeaders.Add('Authorization', AuthText);
        end;

        case RequestType of
            RequestType::Get:
                begin
                    RequestMessage.SetRequestUri(RequestURL);
                    RequestMessage.Method := 'GET';
                end;
            RequestType::patch:
                begin
                    RequestContent.WriteFrom(payload);
                    RequestContent.GetHeaders(contentHeaders);
                    contentHeaders.Clear();
                    contentHeaders.Add('Content-Type', 'application/json-patch+json; charset=utf-8');
                    RequestMessage.Content := RequestContent;
                    RequestMessage.SetRequestUri(RequestURL);
                    RequestMessage.Method := 'PATCH';
                end;
            RequestType::post:
                begin
                    RequestContent.WriteFrom(payload);
                    RequestContent.GetHeaders(contentHeaders);
                    contentHeaders.Clear();
                    contentHeaders.Add('Content-Type', 'application/json; charset=utf-8');
                    RequestMessage.Content := RequestContent;
                    RequestMessage.SetRequestUri(RequestURL);
                    RequestMessage.Method := 'POST';
                end;
            RequestType::delete:
                begin
                    RequestMessage.SetRequestUri(RequestURL);
                    RequestMessage.Method := 'DELETE';
                end;
        end;
        Client.Send(RequestMessage, ResponseMessage);
        ResponseMessage.Content().ReadAs(ResponseText);
        exit(ResponseText);
    end;

    procedure stringToBase64(s: Text): Text
    var
        Base64: Codeunit "Base64 Convert";
    begin
        exit(Base64.ToBase64(s));
    end;
}

