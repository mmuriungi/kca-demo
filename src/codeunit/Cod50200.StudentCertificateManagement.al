codeunit 50200 "Student Certificate Management"
{
    procedure CreateApplication(StudentNo: Code[20]; ApplicationType: Option)
    var
        CertApp: Record "Certificate Application";
    begin
        CertApp.Init();
        CertApp.Validate("Student No.", StudentNo);
        CertApp.Validate("Application Type", ApplicationType);
        CertApp.Validate("Application Date", Today);
        CertApp.Validate(Status, CertApp.Status::open);
        CertApp.Insert(true);

        SendApplicationConfirmation(CertApp);
    end;

    procedure ApproveApplication(var CertApp: Record "Certificate Application")
    begin
        CertApp.TestField(Status, CertApp.Status::Pending);
        CertApp.Validate(Status, CertApp.Status::Approved);
        CertApp.Modify(true);

        SendApprovalNotification(CertApp);
    end;

    procedure RejectApplication(var CertApp: Record "Certificate Application")
    begin
        CertApp.TestField(Status, CertApp.Status::Pending);
        CertApp.Validate(Status, CertApp.Status::Rejected);
        CertApp.Modify(true);

        SendRejectionNotification(CertApp);
    end;

    procedure CheckApplicantQualification(var CertApp: Record "Certificate Application")
    var
        Cust: Record Customer;
        ClearanceHeader: Record "ACA-Clearance Header";
    begin
        Cust.reset();
        cust.setrange("No.", CertApp."Student No.");
        if Cust.findfirst() then begin
            Cust.CalcFields(Balance);
            if Cust.Balance > 0 then
                Error('Student has a balance of %1. Please clear the balance before proceeding.', Cust.Balance);
        end else
            Error('Student not found.');
        ClearanceHeader.Reset();
        ClearanceHeader.SetRange("Student No.", CertApp."Student No.");
        ClearanceHeader.SetFilter(Status, '%1|%2', ClearanceHeader.Status::Cleared, ClearanceHeader.Status::Completed);
        if not ClearanceHeader.FindSet() then
            Error('Student has not cleared all requirements.');
    end;

    local procedure SendApplicationConfirmation(CertApp: Record "Certificate Application")
    var
        Student: Record Customer;
        BodyText: Text;
    begin
        if not Student.Get(CertApp."Student No.") then
            exit;

        case CertApp."Application Type" of
            CertApp."Application Type"::"New Certificate":
                BodyText := GetNewCertificateConfirmationText();
            CertApp."Application Type"::"Copy of Certificate":
                BodyText := GetCopyOfCertificateConfirmationText();
            CertApp."Application Type"::"Reissue Transcript":
                BodyText := GetReissueTranscriptConfirmationText();
            CertApp."Application Type"::"Special Examination":
                BodyText := GetSpecialExaminationConfirmationText();
        end;

        // Here you would implement the actual email sending logic
        // This is just a placeholder
        Message('Email sent to %1 with body: %2', Student."E-Mail", BodyText);
    end;

    local procedure SendApprovalNotification(CertApp: Record "Certificate Application")
    var
        Student: Record Customer;
        BodyText: Text;
    begin
        if not Student.Get(CertApp."Student No.") then
            exit;

        case CertApp."Application Type" of
            CertApp."Application Type"::"New Certificate":
                BodyText := 'Your certificate application has been approved. Please collect your certificate and official transcripts.';
            CertApp."Application Type"::"Copy of Certificate":
                BodyText := 'Your application for a copy of certificate has been approved. Please collect it after paying the prescribed fee.';
            CertApp."Application Type"::"Reissue Transcript":
                BodyText := 'Your application for reissuance of transcripts has been approved. You can collect them after 1 week.';
            CertApp."Application Type"::"Special Examination":
                BodyText := 'Your application for a special examination has been approved. Please check with your department for further instructions.';
        end;

        // Here you would implement the actual email sending logic
        // This is just a placeholder
        Message('Approval notification sent to %1 with body: %2', Student."E-Mail", BodyText);
    end;

    local procedure SendRejectionNotification(CertApp: Record "Certificate Application")
    var
        Student: Record Customer;
    begin
        if not Student.Get(CertApp."Student No.") then
            exit;

        // Here you would implement the actual email sending logic
        // This is just a placeholder
        Message('Rejection notification sent to %1: Your application has been rejected. Please contact the examinations office for more information.', Student."E-Mail");
    end;

    local procedure GetNewCertificateConfirmationText(): Text
    begin
        exit('Your application for a new certificate has been received. Please ensure you meet the following requirements:\' +
             '- Clearance from the University from the time of graduation\' +
             '- Return of graduation gown (please fill and download the form)\' +
             '- Provide your National ID before issuance\' +
             'Once these requirements are met, you will be provided with your certificate and official transcripts.');
    end;

    local procedure GetCopyOfCertificateConfirmationText(): Text
    begin
        exit('Your application for a copy of your certificate has been received. Please provide the following documents:\' +
             '- Police abstract\' +
             '- National ID\' +
             'You will be able to collect the copy of your certificate after payment of the prescribed fee.');
    end;

    local procedure GetReissueTranscriptConfirmationText(): Text
    begin
        exit('Your application for reissuance of transcripts has been received. Please note:\' +
             '- There is a prescribed fee for reissuance of transcripts. Please provide the receipt before reissuance.\' +
             '- You can pick up the transcripts after 1 week.\' +
             '- Request for replacement can only be done once.');
    end;

    local procedure GetSpecialExaminationConfirmationText(): Text
    begin
        exit('Your application for a special examination has been received. The application will be reviewed by the relevant departments. You will be notified of the outcome once the review process is complete.');
    end;
}