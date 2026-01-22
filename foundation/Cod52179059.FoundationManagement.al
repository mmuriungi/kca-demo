codeunit 52179059 "Foundation Management"
{
    procedure CreateDonationFromDonor(Donor: Record "Foundation Donor")
    var
        Donation: Record "Foundation Donation";
        DonationCard: Page "Foundation Donation Card";
    begin
        Donation.Init();
        Donation.Validate("Donor No.", Donor."No.");
        DonationCard.SetRecord(Donation);
        DonationCard.RunModal();
    end;

    procedure CreatePledgeFromDonor(Donor: Record "Foundation Donor")
    var
        Pledge: Record "Foundation Pledge";
    begin
        Pledge.Init();
        Pledge.Validate("Donor No.", Donor."No.");
        Pledge.Insert(true);
        Message('Pledge %1 created for donor %2', Pledge."No.", Donor.Name);
    end;

    procedure SendThankYouLetter(Donor: Record "Foundation Donor")
    var
        FoundationSetup: Record "Foundation Setup";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
    begin
        if Donor.Email = '' then
            Error('Donor %1 does not have an email address.', Donor.Name);

        FoundationSetup.Get();
        Subject := StrSubstNo('Thank You from Appkings Solutions Foundation');
        Body := StrSubstNo('Dear %1,\n\nThank you for your generous support of Appkings Solutions.\n\nBest regards,\nFoundation Team', Donor.Name);

        EmailMessage.Create(Donor.Email, Subject, Body);
        Email.Send(EmailMessage);

        Message('Thank you email sent to %1', Donor.Name);
    end;

    procedure PrintTaxCertificate(Donor: Record "Foundation Donor")
    var
        Donation: Record "Foundation Donation";
    begin
        Donation.SetRange("Donor No.", Donor."No.");
        Donation.SetRange("Tax Deductible", true);
        if Donation.IsEmpty then
            Error('No tax deductible donations found for donor %1', Donor.Name);

        Message('Tax certificate printed for donor %1', Donor.Name);
    end;

    procedure PostDonation(var Donation: Record "Foundation Donation")
    var
        GenJnlLine: Record "Gen. Journal Line";
        GLAccount: Record "G/L Account";
        FoundationSetup: Record "Foundation Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DocumentNo: Code[20];
    begin
        if Donation.Posted then
            Error('Donation %1 is already posted.', Donation."No.");

        Donation.TestField(Amount);
        Donation.TestField("Donation Date");
        Donation.TestField("Donor No.");

        FoundationSetup.Get();

        if Donation."GL Account No." = '' then begin
            Donation."GL Account No." := FoundationSetup."Default Donation GL Account";
            Donation.Modify();
        end;

        GLAccount.Get(Donation."GL Account No.");
        GLAccount.TestField(Blocked, false);

        DocumentNo := NoSeriesMgt.GetNextNo('GENJNL', WorkDate(), false);

        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := 'GENERAL';
        GenJnlLine."Journal Batch Name" := 'DEFAULT';
        GenJnlLine."Line No." := 10000;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
        GenJnlLine."Document No." := DocumentNo;
        GenJnlLine."Posting Date" := Donation."Donation Date";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := Donation."GL Account No.";
        GenJnlLine.Description := StrSubstNo('Donation from %1', Donation."Donor Name");
        GenJnlLine.Amount := Donation.Amount;
        GenJnlLine.Insert();

        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJnlLine);

        Donation.Posted := true;
        Donation."Posted Date" := Today;
        Donation."Posted By" := UserId;
        Donation.Status := Donation.Status::Received;
        Donation.Modify();

        Message('Donation %1 posted successfully.', Donation."No.");
    end;

    procedure PostDonationBatch()
    var
        Donation: Record "Foundation Donation";
        PostedCount: Integer;
    begin
        Donation.SetRange(Posted, false);
        Donation.SetRange(Status, Donation.Status::Pending);

        if Donation.FindSet() then
            repeat
                PostDonation(Donation);
                PostedCount += 1;
            until Donation.Next() = 0;

        Message('%1 donations posted successfully.', PostedCount);
    end;

    procedure GenerateDonationReceipt(Donation: Record "Foundation Donation")
    begin
        Message('Donation receipt generated for %1 - Amount: %2', Donation."Donor Name", Donation.Amount);
    end;

    procedure SendDonationAcknowledgment(Donation: Record "Foundation Donation")
    var
        Donor: Record "Foundation Donor";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
    begin
        Donor.Get(Donation."Donor No.");

        if Donor.Email = '' then
            Error('Donor %1 does not have an email address.', Donor.Name);

        Subject := StrSubstNo('Donation Acknowledgment - %1', Donation."No.");
        Body := StrSubstNo('Dear %1,\n\nThank you for your generous donation of %2 on %3.\n\nBest regards,\nFoundation Team',
            Donor.Name, Donation.Amount, Donation."Donation Date");

        EmailMessage.Create(Donor.Email, Subject, Body);
        Email.Send(EmailMessage);

        Donation."Acknowledgment Sent" := true;
        Donation."Acknowledgment Date" := Today;
        Donation.Modify();

        Message('Acknowledgment sent to %1', Donor.Name);
    end;

    procedure IssueTaxCertificate(var Donation: Record "Foundation Donation")
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if not Donation."Tax Deductible" then
            Error('Donation %1 is not tax deductible.', Donation."No.");

        if Donation."Tax Certificate Issued" then
            Error('Tax certificate already issued for donation %1.', Donation."No.");

        Donation."Tax Certificate No." := NoSeriesMgt.GetNextNo('TAXCERT', WorkDate(), false);
        Donation."Tax Certificate Date" := Today;
        Donation."Tax Certificate Issued" := true;
        Donation.Modify();

        Message('Tax certificate %1 issued for donation %2.', Donation."Tax Certificate No.", Donation."No.");
    end;

    procedure ImportDonors()
    var
        DonorImport: XmlPort "Foundation Donor Import";
        InStream: InStream;
        FileName: Text;
        Processed, Inserted, Skipped : Integer;
    begin
        if not UploadIntoStream('Select Donor Import File', '', 'Text Files (*.txt)|*.txt|CSV Files (*.csv)|*.csv|All Files (*.*)|*.*', FileName, InStream) then
            exit;

        DonorImport.SetSource(InStream);
        DonorImport.Import();
        DonorImport.GetImportStatistics(Processed, Inserted, Skipped);

        Message('Donor import completed.\nProcessed: %1\nInserted: %2\nSkipped: %3', Processed, Inserted, Skipped);
    end;

    procedure ExportDonors()
    var
        DonorExport: XmlPort "Foundation Donor Export";
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        ExportedCount: Integer;
    begin
        TempBlob.CreateOutStream(OutStream);
        DonorExport.SetDestination(OutStream);
        DonorExport.Export();
        ExportedCount := DonorExport.GetExportStatistics();

        FileName := 'Foundation_Donors_' + Format(Today, 0, '<Year4><Month,2><Day,2>') + '.txt';
        DownloadFromStream(TempBlob.CreateInStream(), 'Export Donors', '', 'Text Files (*.txt)|*.txt', FileName);

        Message('Exported %1 donor records to file: %2', ExportedCount, FileName);
    end;

    procedure UpdateDonorRecognitionLevels()
    var
        Donor: Record "Foundation Donor";
        FoundationSetup: Record "Foundation Setup";
        UpdatedCount: Integer;
    begin
        FoundationSetup.Get();

        if Donor.FindSet() then
            repeat
                Donor.CalcFields("Total Donations");

                case true of
                    Donor."Total Donations" >= FoundationSetup."Diamond Level Amount":
                        Donor."Recognition Level" := Donor."Recognition Level"::Diamond;
                    Donor."Total Donations" >= FoundationSetup."Platinum Level Amount":
                        Donor."Recognition Level" := Donor."Recognition Level"::Platinum;
                    Donor."Total Donations" >= FoundationSetup."Gold Level Amount":
                        Donor."Recognition Level" := Donor."Recognition Level"::Gold;
                    Donor."Total Donations" >= FoundationSetup."Silver Level Amount":
                        Donor."Recognition Level" := Donor."Recognition Level"::Silver;
                    Donor."Total Donations" >= FoundationSetup."Bronze Level Amount":
                        Donor."Recognition Level" := Donor."Recognition Level"::Bronze;
                    else
                        Donor."Recognition Level" := Donor."Recognition Level"::" ";
                end;

                if Donor."Total Donations" >= FoundationSetup."Min. Major Donor Amount" then
                    Donor."Donor Category" := Donor."Donor Category"::Major
                else if Donor."Total Donations" > 0 then
                    Donor."Donor Category" := Donor."Donor Category"::Regular
                else
                    Donor."Donor Category" := Donor."Donor Category"::Prospect;

                Donor.Modify();
                UpdatedCount += 1;
            until Donor.Next() = 0;

        Message('%1 donor recognition levels updated.', UpdatedCount);
    end;
}