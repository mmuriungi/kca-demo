page 52118 "HMS Sick Leave Cert. Card"
{
    PageType = Card;
    SourceTable = "HMS-Off Duty";
    Caption = 'Sick Leave Certificate';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Information';
                field("Certificate No."; Rec."Certificate No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Certificate No.';
                }
                field("Certificate Date"; Rec."Certificate Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = All;
                    Caption = 'Patient Type';
                }
                field("Treatment No."; Rec."Treatment No.")
                {
                    ApplicationArea = All;
                    Caption = 'Treatment No.';


                }
            }

            group("Patient Details")
            {
                Caption = 'Patient Details';
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    Caption = 'Title';
                }
                field("PF No."; Rec."PF No.")
                {
                    ApplicationArea = All;
                    Caption = 'PF No.';
                    Visible = PFNoVisible;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                    Visible = StudentNoVisible;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }
            }

            group("Leave Details")
            {
                Caption = 'Sick Leave Details';
                field("Sick Leave Duration"; Rec."Sick Leave Duration")
                {
                    ApplicationArea = All;
                    Caption = 'Duration';
                }
                field("Duration Unit"; Rec."Duration Unit")
                {
                    ApplicationArea = All;
                    Caption = 'Unit';
                }
                field("Off Duty Start Date"; Rec."Off Duty Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field("Review Date"; Rec."Review Date")
                {
                    ApplicationArea = All;
                    Caption = 'Review Date';
                }
                field("Illness Description"; Rec."Illness Description")
                {
                    ApplicationArea = All;
                    Caption = 'Illness/Condition';
                    MultiLine = true;
                }
                field("Off Duty Reason Reason"; Rec."Off Duty Reason Reason")
                {
                    ApplicationArea = All;
                    Caption = 'Additional Notes';
                    MultiLine = true;
                }
            }

            group("Authorization")
            {
                Caption = 'Authorization';
                field("Chief Medical Officer"; Rec."Chief Medical Officer")
                {
                    ApplicationArea = All;
                    Caption = 'Chief Medical Officer';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print Certificate")
            {
                Caption = 'Print Certificate';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SickLeaveRec: Record "HMS-Off Duty";
                begin
                    SickLeaveRec.Reset();
                    SickLeaveRec.SetRange("Certificate No.", Rec."Certificate No.");
                    if SickLeaveRec.FindFirst() then
                        Report.Run(Report::"HMS Sick Leave Certificate", true, false, SickLeaveRec);
                end;
            }

            action("Mark as Issued")
            {
                Caption = 'Mark as Issued';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm('Mark this certificate as issued?', false) then begin
                        Rec.Status := Rec.Status::Released;
                        Rec.Modify();
                        Message('Certificate has been marked as issued.');
                    end;
                end;
            }

            action("Send to Staff and MO")
            {
                Caption = 'Send Certificate to Staff';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SickLeaveRec: Record "HMS-Off Duty";
                    HMSSetup: Record "HMS-Setup";
                    Employee: Record "HRM-Employee C";
                    TempBlob: Codeunit "Temp Blob";
                    InStr: InStream;
                    OutStr: OutStream;
                    RecRef: RecordRef;
                    FileName: Text;
                    StaffEmail: Text[100];
                    MOEmail: Text[100];
                    EmailSubject: Text[250];
                    EmailBody: Text;
                    NotificationHandler: Codeunit "Notifications Handler";
                    RptB64: Text;
                    B64Converter: Codeunit "Base64 Convert";
                    PatientName: Text[100];
                begin
                    SickLeaveRec.Reset();
                    SickLeaveRec.SetRange("Certificate No.", Rec."Certificate No.");
                    if not SickLeaveRec.FindFirst() then
                        Error('Sick leave certificate record not found');

                    // Get staff email from HRM-Employee C table
                    if Rec."PF No." <> '' then begin
                        Employee.Reset();
                        Employee.SetRange("No.", Rec."PF No.");
                        if Employee.FindFirst() then
                            StaffEmail := Employee."E-Mail"
                        else
                            Error('Staff record not found for PF No: %1', Rec."PF No.");
                    end else
                        Error('PF No. is required to send email to staff');

                    if StaffEmail = '' then
                        Error('Staff email address is not available in employee record');

                    // Get Medical Officer email from HMS Setup for CC
                    if HMSSetup.Get() then
                        MOEmail := HMSSetup."Medical Officer Email";

                    // Generate the sick leave certificate report
                    TempBlob.CreateOutStream(OutStr);
                    RecRef.GetTable(SickLeaveRec);
                    if not REPORT.SaveAs(Report::"HMS Sick Leave Certificate", '', ReportFormat::Pdf, OutStr, RecRef) then
                        Error('Failed to generate sick leave certificate PDF');

                    // Prepare patient name
                    PatientName := Rec."Staff Name";

                    // Create email
                    EmailSubject := StrSubstNo('Sick Leave Certificate - %1', Rec."Certificate No.");
                    EmailBody := 'Dear ' + PatientName + ',<br><br>' +
                                'Your sick leave certificate has been issued:<br><br>' +
                                'Certificate No: ' + Rec."Certificate No." + '<br>' +
                                'Date Issued: ' + Format(Rec."Certificate Date") + '<br>' +
                                'Duration: ' + Format(Rec."Sick Leave Duration") + ' ' + Format(Rec."Duration Unit") + '<br>' +
                                'Start Date: ' + Format(Rec."Off Duty Start Date") + '<br><br>' +
                                'Please find the certificate attached.<br><br>' +
                                'Best regards,<br>' +
                                'Medical Services';

                    TempBlob.CreateInStream(InStr);
                    RptB64 := B64Converter.ToBase64(InStr);
                    FileName := StrSubstNo('SickLeave_Certificate_%1.pdf', Rec."Certificate No.");

                    // Send to staff with MO as CC
                    NotificationHandler.fnSendemail(PatientName, EmailSubject, EmailBody, StaffEmail, MOEmail, '', true, RptB64, FileName, 'pdf');

                    Message('Sick leave certificate has been sent to staff with copy to medical officer.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateVisibility();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Certificate Date" := Today;
        Rec."Created By" := UserId;
        Rec."Created Date" := CurrentDateTime;
        Rec.Status := Rec.Status::New;
    end;

    var
        PFNoVisible: Boolean;
        StudentNoVisible: Boolean;

    local procedure UpdateVisibility()
    begin
        PFNoVisible := Rec."Patient Type" = Rec."Patient Type"::Staff;
        StudentNoVisible := Rec."Patient Type" = Rec."Patient Type"::Student;
    end;
}