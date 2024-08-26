// Codeunit: Security Management
codeunit 50018 "Security Management"

{
    procedure RegisterGuest(visitorName: Text[100]; reasonForVisit: Text[250]; vehiclePlateNumber: Code[20]; isStaff: Boolean): Integer
    var
        GuestReg: Record "Guest Registration";
    begin
        GuestReg.Init();
        GuestReg."Visitor Name" := visitorName;
        GuestReg."Reason for Visit" := reasonForVisit;
        GuestReg."Time In" := CurrentDateTime;
        GuestReg."Vehicle Plate Number" := vehiclePlateNumber;
        GuestReg."Is Staff" := isStaff;
        GuestReg.Insert(true);
        exit(GuestReg."Entry No.");
    end;

    procedure RecordIncident(accusedName: Text[100]; victimName: Text[100]; natureOfCase: Text[250]; category: Option Internal,Police; accusedType: Option Student,Staff): Code[20]
    var
        IncidentRep: Record "Incident Report";
    begin
        IncidentRep.Init();
        IncidentRep."Case No." := GetNextCaseNumber();
        IncidentRep."Accused Name" := accusedName;
        IncidentRep."Victim/Reporting Party" := victimName;
        IncidentRep."Nature of Case" := natureOfCase;
        IncidentRep.Category := category;
        IncidentRep."Accused Type" := accusedType;
        IncidentRep.Status := IncidentRep.Status::Open;
        IncidentRep.Insert(true);
        exit(IncidentRep."Case No.");
    end;

    local procedure GetNextCaseNumber(): Code[20]
    var
        IncidentRep: Record "Incident Report";
        LastCaseNo: Integer;
    begin
        IncidentRep.SetCurrentKey("Case No.");
        if IncidentRep.FindLast() then begin
            Evaluate(LastCaseNo, IncidentRep."Case No.");
            exit(Format(LastCaseNo + 1, 5));
        end else
            exit('00001');
    end;

    procedure RecordDailyOccurrence(description: Text[250]; recordedBy: Code[50]): Integer
    var
        DailyOB: Record "Daily Occurrence Book";
    begin
        DailyOB.Init();
        DailyOB.Date := Today;
        DailyOB.Time := Time;
        DailyOB.Description := description;
        DailyOB."Recorded By" := recordedBy;
        DailyOB.Insert(true);
        exit(DailyOB."Entry No.");
    end;

    [ServiceEnabled]
    procedure RegisterGuestWebService(visitorName: Text[100]; reasonForVisit: Text[250]; vehiclePlateNumber: Code[20]; isStaff: Boolean): Text
    var
        EntryNo: Integer;
    begin
        EntryNo := RegisterGuest(visitorName, reasonForVisit, vehiclePlateNumber, isStaff);
        exit(Format(EntryNo));
    end;

    [ServiceEnabled]
    procedure RecordIncidentWebService(accusedName: Text[100]; victimName: Text[100]; natureOfCase: Text[250]; category: Text; accusedType: Text): Text
    var
        CaseNo: Code[20];
        CategoryOption: Option Internal,Police;
        AccusedTypeOption: Option Student,Staff;
    begin
        Evaluate(CategoryOption, category);
        Evaluate(AccusedTypeOption, accusedType);
        CaseNo := RecordIncident(accusedName, victimName, natureOfCase, CategoryOption, AccusedTypeOption);
        exit(CaseNo);
    end;

    [ServiceEnabled]
    procedure RecordDailyOccurrenceWebService(description: Text[250]; recordedBy: Code[50]): Text
    var
        EntryNo: Integer;
    begin
        EntryNo := RecordDailyOccurrence(description, recordedBy);
        exit(Format(EntryNo));
    end;
}