codeunit 50068 "Estates Management"
{
    var
        ApprovalEntries: Record "Approval Entry";
        Repair: Record "Repair Request";
        MaintenanceRequest: Record "Maintenance Request";
        MaintenanceScheduleLine: Record "Maintenance Schedule Line";
        maintenancelines: record "maintenance request lines";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EstateSetup: Record "Estates Setup";


    procedure ValidateEmail(Email: Text)
    var
        MailManagement: Codeunit "Mail Management";
        IsHandled: Boolean;
    begin
        if Email = '' then
            exit else
            MailManagement.CheckValidEmailAddresses(Email);
    end;

    procedure NotifyOfficers(DocNo: Code[20])
    var
        Recipients: List of [Text];
        Body: Text;
        Subject: Text;
        NoOfficerErr: Label 'Sorry %1, no officer to notify';
        Message: Label 'Greetings, <br> <br> This is to notify you about the Maintenance Schedule No. %1 created on %2 that has been assigned to you by the %4 <br> <br> Please <a href="%3"> log in </a> and provide your actions.<br><br> Regards EMBU Estates';
    begin
        EstateSetup.Get();
        EstateSetup.TestField("Maintenance Schedule Subject");
        EstateSetup.TestField("Maintenance Schedule Link");
        MaintenanceScheduleLine.Reset();
        MaintenanceScheduleLine.SetRange("Request No.", DocNo);
        if MaintenanceScheduleLine.FindFirst() then begin
            repeat
                Recipients.Add(MaintenanceScheduleLine."E-Mail");
            until MaintenanceScheduleLine.Next() = 0;
        end else
            Error(NoOfficerErr);
        Subject := EstateSetup."Maintenance Schedule Subject";
        Body := StrSubstNo(Message, DocNo, MaintenanceRequest."Request Date", EstateSetup."Maintenance Schedule Link", UserId);
        EmailMessage.Create(Recipients, Subject, Body, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        repeat
            MaintenanceScheduleLine.Notified := true;
            MaintenanceScheduleLine.Modify();
        until MaintenanceScheduleLine.Next() = 0;
        MaintenanceRequest.Reset();
        Message('Notifications sent successfully');
    end;

    procedure PopulateMaintenanceRequest(MaintenanceNo: Code[20])
    var
        RepairConfMsg: Label 'This action will populate approved the maintenance requests.\Do you wish to proceed?';
        Dialog: Dialog;
        NoReqErr: Label 'Sorry %1, Approved Requests does not exist';
        DialogMsg: Label 'Populating Repair Request No.: #1 \Request Description: #2 \Expected Start Date: #3 \Expected End Date: #4 ';
        SuccessMsg: Label 'Repair request(s) populated successfully';
    begin
        if Confirm(RepairConfMsg) then begin
            MaintenanceRequest.Reset();
            MaintenanceRequest.SetRange(Status, MaintenanceRequest.Status::Approved);
            Dialog.Open(StrSubstNo(DialogMsg, MaintenanceRequest."No.", MaintenanceRequest."Maintenance Description", MaintenanceRequest."Start Date", MaintenanceRequest."End Date"));
            if MaintenanceRequest.FindFirst() then begin
                repeat
                    MaintenanceScheduleLine.Init();
                    MaintenanceScheduleLine."Maintence No." := MaintenanceNo;
                    MaintenanceScheduleLine."Request No." := MaintenanceRequest."No.";
                    MaintenanceScheduleLine.Validate("Request No.");
                    MaintenanceScheduleLine."Request Description" := MaintenanceRequest."maintenance Requests";
                    MaintenanceScheduleLine."Facility Description" := MaintenanceRequest."Facility Description";
                    MaintenanceScheduleLine."Maintenance Description" := MaintenanceRequest."Maintenance Description";
                    MaintenanceScheduleLine."Requester Name" := MaintenanceRequest."Requester Name";
                    MaintenanceScheduleLine."Department Code" := MaintenanceRequest."Department Code";
                    MaintenanceScheduleLine.Department := MaintenanceRequest.Department;
                    MaintenanceScheduleLine."Estimated Cost" := MaintenanceRequest."Estimated Cost";
                    MaintenanceScheduleLine."Maintenance Year" := MaintenanceRequest."Maintenance Year";
                    MaintenanceScheduleLine."Maintenance Period" := MaintenanceRequest."Maintenance Period";
                    MaintenanceScheduleLine.AssignedMo := MaintenanceRequest.AssignedMo;
                    
                    MaintenanceScheduleLine.Insert();
                    MaintenanceRequest.Status := MaintenanceRequest.Status::Scheduled;
                    MaintenanceRequest."Scheduled Date" := Today;
                    MaintenanceRequest.Modify();
                    Dialog.Update();
                until MaintenanceRequest.Next() = 0;
                Message(DialogMsg);
            end else
                Error(NoReqErr, UserId);
            Dialog.Close();
        end else
            exit;
    end;

    procedure PopulateRepairRequest(MaintenanceNo: Code[20])
    var
        RepairRequest: Record "Repair Request";
        maintSchedule: Record "Maintenance Schedule Line";
        Dialog: Dialog;
        SuccessMsg: Label 'Repair request(s) populated successfully';
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        MaintenanceScheduleLine.Reset();
        MaintenanceScheduleLine.SetRange("Request No.", MaintenanceNo);
        MaintenanceScheduleLine.SetRange("Repair Request Generated", false);
        if MaintenanceScheduleLine.Find('-') then begin
            RepairRequest.Init();
            EstateSetup.Reset();
            EstateSetup.SetRange("Repair No.", 'RR');
            IF EstateSetup.Find('-') then begin
                RepairRequest."No." := NoSeriesMgt.GetNextNo(EstateSetup."Repair No.", 0D, TRUE);
            end;
            RepairRequest.Status := RepairRequest.Status::Open;
            RepairRequest."Repair Description" := MaintenanceScheduleLine."Request Description";
            RepairRequest.Insert();
            MaintenanceScheduleLine."Repair Request Generated" := true;
            MaintenanceScheduleLine.Modify();
        end;
        Message(SuccessMsg);

    end;

    procedure IsMaintenanceOfficer(DocNo: Code[20]; UserName: Code[20]): Boolean
    var
        NotApproverErr: Label 'Sorry %1, you must be Head of Estates to assign the Maintenance Officer';
    begin
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Document No.", DocNo);
        ApprovalEntries.SetRange("Approver ID", UserName);
        if ApprovalEntries.FindFirst() then
            exit(true) else
            Error(NotApproverErr, UserName);
    end;

    procedure IsOpen(DocNo: Code[20]): Boolean
    var
        DocNotOpen: Label 'Sorry, repair request no.:%1 must not be open';
    begin
        Repair.Reset();
        if Repair.Get(DocNo) then
            if Repair.Status = Repair.Status::Open then
                Error(DocNotOpen, DocNo) else
                exit(true);
    end;
}
