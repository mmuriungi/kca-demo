codeunit 50082 "Email Notification Codeunit"
{
    procedure SendExpiryNotifications(PharmacyStockHeader: Record "Pharmacy Stock Header")
    var
        // SmtpMailSetup: Record "O365 Email Setup";
        SmtpMessage: Codeunit "Email Message";
        EmailBody: Text;
        ExpiryDate: Date;
        EmailMessage: Codeunit "Email Message";
        Rec: Record "Pharmacy Stock Header";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;

    begin
        // Check if SMTP Mail Setup is configured
        // if not SmtpMailSetup.Get() then
        //     Error('SMTP Mail Setup is not configured.');

        // Set the expiry date range
        ExpiryDate := Today() + 5;
        Rec.SetRange("Expiry Date", Today(), ExpiryDate);

        // Build the email body
        EmailBody := 'The following items are approaching expiry:';
        if Rec.FindSet() then begin
            repeat
                EmailBody += 'No.: ' + Rec."No." + ', Description: ' + Rec.Description + ', Expiry Date: ' + Format(Rec."Expiry Date");
            until Rec.Next() = 0;
        end else
            EmailBody += 'No items are approaching expiry.';

        // Send the email
        EmailMessage.Create(Recipients, Subject, Body, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;
}
