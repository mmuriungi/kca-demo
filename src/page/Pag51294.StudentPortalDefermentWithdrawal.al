page 50076 "Student Portal Def/Withdrawal"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Student Deferment/Withdrawal";
    SourceTableTemporary = true;
    Caption = 'Student Portal Deferment/Withdrawal';
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group(StudentInfo)
            {
                Caption = 'Student Information';
                field(StudentNo; StudentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                    Editable = false;
                }
                field(StudentName; StudentName)
                {
                    ApplicationArea = All;
                    Caption = 'Student Name';
                    Editable = false;
                }
                field(CurrentStatus; CurrentStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Current Status';
                    Editable = false;
                }
            }
            group(RequestInfo)
            {
                Caption = 'Request Information';
                Visible = not ViewingRequests;
                field(RequestType; RequestType)
                {
                    ApplicationArea = All;
                    Caption = 'Request Type';
                    OptionCaption = 'Deferment,Withdrawal';
                }
                field(AcademicYear; AcademicYear)
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Caption = 'Semester';
                    Editable = false;
                }
                field(ProgrammeCode; ProgrammeCode)
                {
                    ApplicationArea = All;
                    Caption = 'Programme Code';
                    Editable = false;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                    Caption = 'Stage';
                    Editable = false;
                }
                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                    Visible = RequestType = RequestType::Deferment;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Caption = 'Reason';
                    MultiLine = true;
                }
            }
            part(RequestsList; "Student Portal Def/Withd List")
            {
                ApplicationArea = All;
                Caption = 'My Requests';
                SubPageLink = "Student No." = field("Student No.");
                UpdatePropagation = Both;
                Visible = ViewingRequests;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SubmitRequest)
            {
                ApplicationArea = All;
                Caption = 'Submit Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = not ViewingRequests;

                trigger OnAction()
                var
                    WebPortals: Codeunit webportals;
                    Result: Text;
                begin
                    if RequestType = RequestType::Deferment then
                        Result := WebPortals.CreateStudentDefermentRequest(
                            StudentNo, StartDate, EndDate, AcademicYear, Rec.Semester, ProgrammeCode, Rec.Stage, Rec.Reason)
                    else
                        Result := WebPortals.CreateStudentWithdrawalRequest(
                            StudentNo, StartDate, AcademicYear, Rec.Semester, ProgrammeCode, Rec.Stage, Rec.Reason);

                    Message(Result);
                    CurrPage.Update(false);
                end;
            }
            action(ViewRequests)
            {
                ApplicationArea = All;
                Caption = 'View My Requests';
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = not ViewingRequests;

                trigger OnAction()
                begin
                    ViewingRequests := true;
                    CurrPage.Update(false);
                end;
            }
            action(NewRequest)
            {
                ApplicationArea = All;
                Caption = 'New Request';
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = ViewingRequests;

                trigger OnAction()
                begin
                    ViewingRequests := false;
                    ClearRequestFields();
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        WebPortals: Codeunit webportals;
        Customer: Record Customer;
        YearSemesterInfo: Text;
        ProgrammeStageInfo: Text;
        StatusInfo: Text;
        YearSemesterParts: List of [Text];
        ProgrammeStageParts: List of [Text];
    begin
        // Set default student information (in a real scenario, this would be the logged-in student)
        StudentNo := ''; // This would be set from the login context
        if StudentNo = '' then
            StudentNo := 'STD001'; // For testing purposes

        if Customer.Get(StudentNo) then
            StudentName := Customer.Name;

        // Get current academic year and semester
        YearSemesterInfo := WebPortals.GetCurrentAcademicYearAndSemester();
        YearSemesterParts := YearSemesterInfo.Split('::');
        if YearSemesterParts.Count >= 2 then begin
            AcademicYear := YearSemesterParts.Get(1);
            Rec.Semester := YearSemesterParts.Get(2);
        end;

        // Get student's programme and stage
        ProgrammeStageInfo := WebPortals.GetStudentProgrammeAndStage(StudentNo);
        ProgrammeStageParts := ProgrammeStageInfo.Split('::');
        if ProgrammeStageParts.Count >= 2 then begin
            ProgrammeCode := ProgrammeStageParts.Get(1);
            Rec.Stage := ProgrammeStageParts.Get(2);
        end;

        // Get student's current status
        StatusInfo := WebPortals.GetStudentStatusInfo(StudentNo);
        CurrentStatus := StatusInfo;

        // Default to viewing the form, not the list
        ViewingRequests := false;
    end;

    local procedure ClearRequestFields()
    begin
        RequestType := RequestType::Deferment;
        StartDate := 0D;
        EndDate := 0D;
        Rec.Reason := '';
    end;

    var
        StudentNo: Code[20];
        StudentName: Text[100];
        CurrentStatus: Text;
        RequestType: Option Deferment,Withdrawal;
        AcademicYear: Code[20];
        Semester: Code[20];
        ProgrammeCode: Code[20];
        Stage: Code[20];
        StartDate: Date;
        EndDate: Date;
        Reason: Text[250];
        ViewingRequests: Boolean;
}
