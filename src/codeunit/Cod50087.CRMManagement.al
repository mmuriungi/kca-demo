// Codeunit: CRM Management
codeunit 50087 "CRM Management"
{
    procedure CreateEvent(EventName: Text[100]; EventDate: Date; EventTime: Time; Location: Text[100]; Description: Text[250]; Category: Option Conference,Social,"Public Forum","Public Lecture"): Code[20]
    var
        CRMEvent: Record "CRM Event";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CRMSetup: Record "CRM Setup";
    begin
        CRMSetup.Get();
        CRMSetup.TestField("Event Nos.");

        CRMEvent.Init();
        CRMEvent."No." := NoSeriesMgt.GetNextNo(CRMSetup."Event Nos.", WorkDate(), true);
        CRMEvent.Name := EventName;
        CRMEvent.Date := EventDate;
        CRMEvent.Time := EventTime;
        CRMEvent.Location := Location;
        CRMEvent.Description := Description;
        CRMEvent.Category := Category;
        CRMEvent.Insert(true);

        exit(CRMEvent."No.");
    end;

    procedure RegisterAttendee(EventNo: Code[20]; AttendeeNo: Code[20])
    var
        EventAttendee: Record "Event Attendee";
    begin
        EventAttendee.Init();
        EventAttendee."Event No." := EventNo;
        EventAttendee."Attendee No." := AttendeeNo;
        EventAttendee."Registration Date" := WorkDate();
        EventAttendee.Insert(true);

        SendConfirmationEmail(EventNo, AttendeeNo);
    end;

    procedure CheckInAttendee(EventNo: Code[20]; AttendeeNo: Code[20])
    var
        EventAttendee: Record "Event Attendee";
    begin
        EventAttendee.Get(EventNo, AttendeeNo);
        EventAttendee."Checked In" := true;
        EventAttendee."Check-in Time" := CurrentDateTime;
        EventAttendee.Modify(true);
    end;

    procedure RecordDonation(DonorNo: Code[20]; Amount: Decimal; CampaignCode: Code[20]): Code[20]
    var
        Donation: Record Donation;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CRMSetup: Record "CRM Setup";
    begin
        CRMSetup.Get();
        CRMSetup.TestField("Donation Nos.");

        Donation.Init();
        Donation."No." := NoSeriesMgt.GetNextNo(CRMSetup."Donation Nos.", WorkDate(), true);
        Donation."Donor No." := DonorNo;
        Donation."Donation Date" := WorkDate();
        Donation.Amount := Amount;
        Donation."Campaign Code" := CampaignCode;
        Donation.Insert(true);

        UpdateAlumniEngagement(DonorNo);

        exit(Donation."No.");
    end;

    procedure RecordEventFeedback(EventNo: Code[20]; AttendeeNo: Code[20]; Rating: Integer; Comment: Text[250])
    var
        EventFeedback: Record "Event Feedback";
    begin
        EventFeedback.Init();
        EventFeedback."Event No." := EventNo;
        EventFeedback."Attendee No." := AttendeeNo;
        EventFeedback.Rating := Rating;
        EventFeedback.Comment := Comment;
        EventFeedback."Feedback Date" := WorkDate();
        EventFeedback.Insert(true);
    end;

    local procedure SendConfirmationEmail(EventNo: Code[20]; AttendeeNo: Code[20])
    var
        CRMEvent: Record "CRM Event";
        Contact: Record Contact;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
    begin
        CRMEvent.Get(EventNo);
        Contact.Get(AttendeeNo);

        Subject := 'Event Registration Confirmation: ' + CRMEvent.Name;
        Body := StrSubstNo('Dear %1,\n\nThank you for registering for %2.\n\nEvent Details:\nDate: %3\nTime: %4\nLocation: %5\n\nWe look forward to seeing you there!',
                           Contact.Name, CRMEvent.Name, Format(CRMEvent.Date), Format(CRMEvent.Time), CRMEvent.Location);

        EmailMessage.Create(Contact."E-Mail", Subject, Body);
        Email.Send(EmailMessage);
    end;

    local procedure UpdateAlumniEngagement(AlumniNo: Code[20])
    var
        Alumni: Record customer;
    begin
        if Alumni.Get(AlumniNo) then begin
            Alumni."Last Engagement Date" := WorkDate();
            Alumni.Modify(true);
        end;
    end;
}
