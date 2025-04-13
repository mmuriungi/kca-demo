codeunit 50105 "DAQA Quiz Handler"
{
    procedure SubmitQuizAnswers(ProjectNo: Code[25]; surveyCode: Code[25]; quiZNo: Integer; boolAnswer: Boolean; TxtAnswer: text[2048]; NumberAnswer: Decimal;
     SubmitedByName: code[250]; submitedByEmail: Text[150]): Boolean
    var
        ProjectQuiz: Record "Project Quiz Answers";
    begin
        ProjectQuiz.Init();
        ProjectQuiz."Project No." := ProjectNo;
        ProjectQuiz."Quiz No." := quiZNo;
        ProjectQuiz.Validate("Quiz No.");
        ProjectQuiz."Boolean Answer" := boolAnswer;
        ProjectQuiz."Text Answer" := TxtAnswer;
        ProjectQuiz."Answered By" := SubmitedByname;
        ProjectQuiz."Answered By Email" := submitedByEmail;
        ProjectQuiz."Survey Code" := surveyCode;
        ProjectQuiz."Number Answer" := NumberAnswer;
        ProjectQuiz."Answered Date" := CurrentDateTime;
        exit(ProjectQuiz.Insert(true));
    end;

    procedure loadQuestions(projectNo: Code[25]; surveyNo: code[25]) Res: Text
    var
        jsonObject: JsonObject;
        Quiz: Record "Project Monitor Quiz";
        Recref: RecordRef;
        Jarray: JsonArray;
    begin

        Quiz.Reset();
        Quiz.SetRange("Project No.", projectNo);
        Quiz.SetRange("Survey Code", SurveyNo);
        Quiz.SetAutoCalcFields("Period From", "Period To");
        if Quiz.FindSet() then begin
            repeat
                Clear(jsonObject);
                jsonObject.Add('Project No.', Quiz."Project No.");
                jsonObject.Add('Quiz No.', Quiz."Quiz No.");
                jsonObject.Add('Question', Quiz.Question);
                jsonObject.Add('Requires Drill-Down', Quiz."Requires Drill-Down");
                jsonObject.Add('Question Type', Format(Quiz."Question Type"));
                jsonObject.Add('Question Category', Format(Quiz."Question Category"));
                jsonObject.Add('Survey Code', Quiz."Survey Code");
                jsonObject.Add('Period From', Quiz."Period From");
                jsonObject.Add('Period To', Quiz."Period To");
                Jarray.Add(jsonObject);
            until Quiz.Next() = 0;
            jarray.WriteTo(Res);
            exit(Res);
        end;
    end;

    procedure LoadDrillDowns(projectNo: Code[25]; SurveyNo: code[25]; quizId: Integer): Text
    var
        jsonObject: JsonObject;
        DrillQuiz: Record "Drill Down Answers";
        Jarray: JsonArray;
    begin
        DrillQuiz.Reset();
        DrillQuiz.SetRange("Project No.", projectNo);
        DrillQuiz.SetRange("Survey Code", SurveyNo);
        DrillQuiz.SetRange("Quiz No.", quizId);
        if DrillQuiz.FindSet() then begin
            repeat
                Clear(jsonObject);
                jsonObject.Add('Project No.', DrillQuiz."Project No.");
                jsonObject.Add('Quiz No.', DrillQuiz."Quiz No.");
                jsonObject.Add('Choice', DrillQuiz.Choice);
                jsonObject.Add('Survey Code', DrillQuiz."Survey Code");
                jsonObject.Add('Entry No', DrillQuiz."Entry No");
                Jarray.Add(jsonObject);
            until DrillQuiz.Next() = 0;
            exit(Format(Jarray));
        end;
    end;

    procedure FnloginCustomer(email: Text; password: text) res: Text
    var
        cust: Record Customer;
        JsonObject: JsonObject;
        Base64: Codeunit "Base64 Convert";
        Intstream: InStream;
        outstream: OutStream;
        templob: Codeunit "Temp Blob";
    begin
        cust.FindByEmail(cust, email);
        if cust.Password = password then begin
            JsonObject.Add('Name', cust.Name);
            templob.CreateOutStream(outstream);
            cust.Image.ExportStream(outstream);
            templob.CreateInStream(Intstream);
            JsonObject.Add('success', true);
            JsonObject.Add('image', Base64.ToBase64(Intstream));
            JsonObject.Add('email', cust."E-Mail");
            JsonObject.WriteTo(res);
            exit(res);
        end else begin
            JsonObject.Add('success', false);
            JsonObject.Add('message', 'Invalid email or password');
            JsonObject.WriteTo(res);
            exit(res);
        end;
    end;

    procedure IsSurveyfilledByEmail(email: Text; surveyCode: Code[25]): Boolean
    var
        ProjectQuiz: Record "Project Quiz Answers";
    begin
        ProjectQuiz.Reset();
        ProjectQuiz.SetRange("Answered By Email", email);
        ProjectQuiz.SetRange("Survey Code", surveyCode);
        exit(ProjectQuiz.FindFirst());
    end;

    procedure GetCustomer(No: Code[20]; var Cust: Record Customer)
    begin
        Cust.Get(No);
    end;

    procedure GetCustomerByEmail(Email: Text; var Cust: Record Customer)
    begin
        Cust.FindByEmail(Cust, Email);
    end;

    procedure GenerateOtpCode(Email: Text): Text
    var
        Cust: Record Customer;
        OtpCode: Text;
        Crypto: Codeunit "Cryptography Management";
    begin
        Cust.FindByEmail(Cust, Email);
        Cust."Otp Code" := Format(Random(999999));
        Cust."Otp Code Expiry" := CurrentDateTime + 300000;
        ModifyCustomer(Cust);
        SendOtpCode(Email, Cust."Otp Code");
        exit('Success');
    end;

    procedure SendOtpCode(EmailAddress: Text; OtpCode: Text)
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
    begin
        EmailMessage.Create(EmailAddress, 'Otp Code', 'Your Otp Code is ' + OtpCode + ' <br> and it will expire in 5 minutes', true);
        Email.Send(EmailMessage);
    end;

    procedure ResetCustomerPassword(Email: Text; NewPassword: Text; Otp: Code[20]): Boolean
    var
        Cust: Record Customer;
    begin
        Cust.FindByEmail(Cust, Email);
        if Cust."Otp Code" = Otp then begin
            Cust.Password := NewPassword;
            ModifyCustomer(Cust);
            exit(true)
        end
        else
            exit(false);
    end;

    procedure ModifyCustomer(var Cust: Record Customer)
    begin
        Cust.Modify();
    end;

    procedure GenerateGoogleChartsData(SurveyCode: Code[20]): Text
    var
        Questions: Record "Project Monitor Quiz";
        Answers: Record "Project Quiz Answers";
        JsonObject: JsonObject;
        QuestionArray: JsonArray;
        ChartData: JsonObject;
        DataArray: JsonArray;
        TempAnswerCount: Dictionary of [Text, Integer];
        AnswerValue: Text;
        RatingSum: Decimal;
        RatingCount: Integer;
        YesCount: Integer;
        NoCount: Integer;
    begin
        Questions.SetRange("Survey Code", SurveyCode);

        if Questions.FindSet() then
            repeat
                Clear(TempAnswerCount);
                Clear(DataArray);
                Clear(ChartData);
                ChartData.Add('questionNo', Questions."Quiz No.");
                ChartData.Add('question', Questions.Question);
                ChartData.Add('type', Format(Questions."Question Type"));

                case Questions."Question Type" of
                    Questions."Question Type"::"Single Choice",
                    Questions."Question Type"::"Multiple Choice":
                        begin
                            // Count frequency of each answer
                            Answers.SetRange("Survey Code", SurveyCode);
                            Answers.SetRange("Quiz No.", Questions."Quiz No.");
                            if Answers.FindSet() then
                                repeat
                                    AnswerValue := Answers."Text Answer";
                                    if TempAnswerCount.ContainsKey(AnswerValue) then
                                        TempAnswerCount.Set(AnswerValue, TempAnswerCount.Get(AnswerValue) + 1)
                                    else
                                        TempAnswerCount.Add(AnswerValue, 1);
                                until Answers.Next() = 0;

                            // Convert to JSON array
                            foreach AnswerValue in TempAnswerCount.Keys() do
                                AddDataPoint(DataArray, AnswerValue, TempAnswerCount.Get(AnswerValue));

                            ChartData.Add('chartType', 'PieChart');
                        end;

                    Questions."Question Type"::Rating:
                        begin
                            Clear(RatingSum);
                            Clear(RatingCount);
                            // Calculate rating distribution
                            Answers.SetRange("Survey Code", SurveyCode);
                            Answers.SetRange("Quiz No.", Questions."Quiz No.");
                            if Answers.FindSet() then
                                repeat
                                    RatingSum += Answers."Number Answer";
                                    RatingCount += 1;
                                    if TempAnswerCount.ContainsKey(Format(Answers."Number Answer")) then
                                        TempAnswerCount.Set(Format(Answers."Number Answer"), TempAnswerCount.Get(Format(Answers."Number Answer")) + 1)
                                    else
                                        TempAnswerCount.Add(Format(Answers."Number Answer"), 1);
                                until Answers.Next() = 0;

                            // Convert to JSON array
                            foreach AnswerValue in TempAnswerCount.Keys() do
                                AddDataPoint(DataArray, AnswerValue, TempAnswerCount.Get(AnswerValue));

                            ChartData.Add('chartType', 'ColumnChart');
                            if RatingCount > 0 then
                                ChartData.Add('average', RatingSum / RatingCount);
                        end;

                    Questions."Question Type"::"Yes/No":
                        begin
                            Clear(YesCount);
                            Clear(NoCount);
                            // Count Yes/No responses
                            Answers.SetRange("Survey Code", SurveyCode);
                            Answers.SetRange("Quiz No.", Questions."Quiz No.");
                            if Answers.FindSet() then
                                repeat
                                    if Answers."Boolean Answer" then
                                        YesCount += 1
                                    else
                                        NoCount += 1;
                                until Answers.Next() = 0;

                            AddDataPoint(DataArray, 'Yes', YesCount);
                            AddDataPoint(DataArray, 'No', NoCount);
                            ChartData.Add('chartType', 'PieChart');
                        end;

                    Questions."Question Type"::Number:
                        begin
                            // Create ranges for number responses
                            Answers.SetRange("Survey Code", SurveyCode);
                            Answers.SetRange("Quiz No.", Questions."Quiz No.");
                            if Answers.FindSet() then
                                repeat
                                    AnswerValue := GetNumberRange(Answers."Number Answer");
                                    if TempAnswerCount.ContainsKey(AnswerValue) then
                                        TempAnswerCount.Set(AnswerValue, TempAnswerCount.Get(AnswerValue) + 1)
                                    else
                                        TempAnswerCount.Add(AnswerValue, 1);
                                until Answers.Next() = 0;

                            foreach AnswerValue in TempAnswerCount.Keys() do
                                AddDataPoint(DataArray, AnswerValue, TempAnswerCount.Get(AnswerValue));

                            ChartData.Add('chartType', 'ColumnChart');
                        end;
                end;

                if DataArray.Count > 0 then begin
                    ChartData.Add('data', DataArray);
                    QuestionArray.Add(ChartData);
                end;
            until Questions.Next() = 0;

        JsonObject.Add('questions', QuestionArray);
        exit(Format(JsonObject));
    end;

    local procedure AddDataPoint(var DataArray: JsonArray; Label: Text; Value: Integer)
    var
        DataPoint: JsonObject;
    begin
        DataPoint.Add('label', Label);
        DataPoint.Add('value', Value);
        DataArray.Add(DataPoint);
    end;

    local procedure GetNumberRange(Value: Decimal): Text
    var
        RangeSize: Decimal;
        LowerBound: Decimal;
    begin
        RangeSize := 10;
        if RangeSize > 0 then
            LowerBound := ROUND(Value / RangeSize, 1, '<') * RangeSize;
        exit(StrSubstNo('%1-%2', LowerBound, LowerBound + RangeSize));
    end;

    procedure GetDashboardStatistics() Result: Text
    var
        JsonObject: JsonObject;
        Project: Record Job;
        Survey: Record "Survey Header";
        SurveyAnswers: Record "Project Quiz Answers";
        PendingReviews: Record "Project Quiz Answers";
        LastMonthCount: Integer;
        ThisWeekCount: Integer;
    begin
        // Total Projects
        Project.Reset();
        JsonObject.Add('totalProjects', Project.Count);

        // Projects growth from last month
        Project.SetFilter("Creation Date", '<%1', CalcDate('-1M', Today));
        LastMonthCount := Project.Count;
        if LastMonthCount > 0 then
            JsonObject.Add('projectGrowth', Round((Project.Count - LastMonthCount) / LastMonthCount * 100, 1));

        // Active Surveys
        Survey.Reset();
        Survey.SetRange(Status, Survey.Status::Published);
        JsonObject.Add('activeSurveys', Survey.Count);

        // New surveys this week
        Survey.Reset();
        Survey.SetFilter("Start Date", '>=%1', CalcDate('-7D', Today));
        JsonObject.Add('newSurveysThisWeek', Survey.Count);

        // Completed Surveys
        Survey.Reset();
        Survey.SetRange(Status, Survey.Status::Closed);
        JsonObject.Add('completedSurveys', Survey.Count);

        // Completion Rate
        Survey.Reset();
        ThisWeekCount := Survey.Count;
        if ThisWeekCount > 0 then
            JsonObject.Add('completionRate', Round(SurveyAnswers.Count / ThisWeekCount * 100, 1))
        else
            JsonObject.Add('completionRate', 0);

        // Recent Activity
        JsonObject.Add('recentActivity', GetRecentActivity());

        // Upcoming Deadlines
        JsonObject.Add('upcomingDeadlines', GetUpcomingDeadlines());

        // System Status
        JsonObject.Add('systemStatus', GetSystemStatus());

        JsonObject.WriteTo(Result);
        exit(Result);
    end;

    local procedure GetRecentActivity(): JsonArray
    var
        Activity: Record "Project Quiz Answers";
        JsonArray: JsonArray;
        JsonObject: JsonObject;
    begin
        Activity.Reset();
        Activity.SetCurrentKey("Answered Date");
        Activity.SetFilter("Answered Date", '>=%1', CreateDateTime(CalcDate('-7D', Today), 000000T));

        if Activity.FindSet() then
            repeat
                Clear(JsonObject);
                JsonObject.Add('type', 'Survey Answer');
                JsonObject.Add('description', Activity.Question);
                JsonObject.Add('project', Activity."Project No.");
                JsonObject.Add('timestamp', Activity."Answered Date");
                JsonArray.Add(JsonObject);
            until Activity.Next() = 0;

        exit(JsonArray);
    end;

    local procedure GetUpcomingDeadlines(): JsonArray
    var
        Survey: Record "Survey Header";
        JsonArray: JsonArray;
        JsonObject: JsonObject;
    begin
        Survey.Reset();
        Survey.SetCurrentKey("End Date");
        Survey.SetFilter("End Date", '>=%1', Today);
        Survey.SetFilter("End Date", '<=%1', CalcDate('<+7D>', Today));

        if Survey.FindSet() then
            repeat
                Clear(JsonObject);
                JsonObject.Add('type', 'Survey Completion');
                JsonObject.Add('project', Survey."Project No.");
                JsonObject.Add('dueDate', Survey."End Date");
                if Survey."End Date" <> 0D then
                    JsonObject.Add('daysLeft', Survey."End Date" - Today);
                JsonArray.Add(JsonObject);
            until Survey.Next() = 0;

        exit(JsonArray);
    end;

    local procedure GetSystemStatus(): JsonObject
    var
        JsonObject: JsonObject;
        CompanyInfo: Record "Company Information";
        LastBackup: DateTime;
    begin
        CompanyInfo.Get();

        // You'll need to implement actual system monitoring logic
        JsonObject.Add('systemUptime', 99.9);
        JsonObject.Add('lastBackup', CurrentDateTime);  // Replace with actual backup timestamp
        JsonObject.Add('status', 'Operational');

        exit(JsonObject);
    end;

    procedure CloseSurvey(var Survey: Record "Survey Header")
    begin
        Survey.Status := Survey.Status::Closed;
    end;

    procedure PublishSurvey(var Survey: Record "Survey Header")
    begin
        Survey.Status := Survey.Status::Published;
    end;

    procedure ModifySurvey(var Survey: Record "Survey Header")
    begin
        Survey.Modify();
    end;
}
