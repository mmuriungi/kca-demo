codeunit 54233 "Payment API Manager"
{
    procedure SendPaymentRequest(DocNo: Code[20]; PhoneNo: Text[20]; Amount: Decimal; serviceCode: Code[20]): Boolean
    var
        Client: HttpClient;
        RequestMsg: HttpRequestMessage;
        ResponseMsg: HttpResponseMessage;
        Content: HttpContent;
        Headers: HttpHeaders;
        JsonObject: JsonObject;
        JsonText: Text;
        ResponseText: Text;
        InvoiceNo: Text;
        StatusCode: Text;
    begin
        JsonObject.Add('docNo', DocNo);
        JsonObject.Add('phoneNo', PhoneNo);
        JsonObject.Add('amount', Amount);
        JsonObject.Add('serviceID', serviceCode);

        JsonObject.WriteTo(JsonText);
        Content.WriteFrom(JsonText);
        Content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/json');

        RequestMsg.Content := Content;
        RequestMsg.SetRequestUri('https://api.karu.ac.ke/api/b2b/generateEcitizenInvoice');
        RequestMsg.Method := 'POST';

        if Client.Send(RequestMsg, ResponseMsg) then begin
            if ResponseMsg.IsSuccessStatusCode() then begin
                ResponseMsg.Content().ReadAs(ResponseText);
                if ProcessPaymentResponse(ResponseText, InvoiceNo, StatusCode) then begin
                    if InvoiceNo = '' then Error(StatusCode);
                    PostTransactionToBC(DocNo, InvoiceNo, Amount);
                    Message('STK Push Sent Successfully. Invoice Number is: %1', InvoiceNo);
                    exit(true);
                end else begin
                    Error('Failed to process API response: %1', ResponseText);
                end;
            end else begin
                ResponseMsg.Content().ReadAs(ResponseText);
                Error('API call failed with status %1: %2', ResponseMsg.HttpStatusCode(), ResponseText);
            end;
        end else begin
            Error('Failed to send HTTP request to payment API');
        end;

        exit(false);
    end;

    procedure RefreshPayment(var PosHeader: Record "POS Sales Header")
    var
        pflow: Record "PesaFlow Integration";
    begin
        pflow.Reset();
        pflow.SetRange(CustomerRefNo, PosHeader."No.");
        if pflow.FindFirst() then begin
            PosHeader."M-Pesa Transaction Number" := pflow.PaymentRefID;
            PosHeader."Amount Paid" := pflow.PaidAmount;
            PosHeader.Modify();
        end
    end;

    local procedure ProcessPaymentResponse(ResponseText: Text; var InvoiceNo: Text; var status: Text): Boolean
    var
        ResponseJson: JsonObject;
        InvoiceToken: JsonToken;
        StatusToken: JsonToken;

    begin
        if not ResponseJson.ReadFrom(ResponseText) then
            exit(false);
        if ResponseJson.Get('invoiceno', InvoiceToken) then
            InvoiceNo := InvoiceToken.AsValue().AsText()
        else if ResponseJson.Get('querystatus', StatusToken) then
            status := StatusToken.AsValue().AsText()
        else
            exit(false);
        exit(true);
    end;

    local procedure PostTransactionToBC(DocNo: Code[20]; InvoiceNo: Text; Amount: Decimal)
    var
        posHeader: Record "POS Sales Header";
    begin
        posHeader.Reset();
        posHeader.SetRange("No.", DocNo);
        IF posHeader.Find('-') then begin
            posHeader."Ecitizen Invoice No" := InvoiceNo;
            posHeader.Modify();
        end;
    end;
}




