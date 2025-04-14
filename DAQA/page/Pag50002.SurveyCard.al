page 52051 "Survey Card"
{
    Caption = 'Survey Card';
    PageType = Card;
    SourceTable = "Survey Header";
    PromotedActionCategories = 'New,Process,Report,Questions,Answers,Charts,Instructions,Controls';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Survey Code"; Rec."Survey Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Code field.', Comment = '%';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update();
                    end;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action(ShowSurveyQuestions)
            {
                ApplicationArea = All;
                Caption = 'Show Survey Questions';
                Promoted = true;
                PromotedCategory = Category4;
                Image = QuestionaireSetup;
                RunObject = page "Project Monitor Quiz";
                RunPageLink = "Survey Code" = field("Survey Code"), "Semester Code" = field("Semester Code");
            }
            action("Generate Quiz Excel")
            {
                ApplicationArea = All;
                Caption = 'Generate Questions Excel';
                Promoted = true;
                PromotedCategory = Category4;
                Image = ExportToExcel;
                trigger OnAction()
                var
                    CsvHandler: Codeunit "DAQA Csv Handler";
                    Questions: Record "Project Monitor Quiz";
                    recref: RecordRef;
                    FieldRef: array[20] of FieldRef;
                    FileName: Text[250];
                    DrillDownAnswers: Record "Drill Down Answers";
                    ExcelBuffer: Record "Excel Buffer" temporary;
                begin
                    Questions.Reset();
                    Questions.SetRange("Survey Code", Rec."Survey Code");
                    Questions.SetRange("Semester Code", Rec."Semester Code");
                    if not Questions.FindSet() then begin
                        Questions.Init();
                        Questions."Survey Code" := Rec."Survey Code";
                        Questions."Semester Code" := Rec."Semester Code";
                        Questions.Insert(true);
                    end;
                    recref.GetTable(Questions);
                    FieldRef[1] := recref.Field(Questions.FieldNo("Semester Code"));
                    FieldRef[2] := recref.Field(Questions.FieldNo("Survey Code"));
                    FieldRef[3] := recref.Field(Questions.FieldNo("Quiz No."));
                    FieldRef[4] := recref.Field(Questions.FieldNo("Question"));
                    FieldRef[5] := recref.Field(Questions.FieldNo("Question Type"));
                    FieldRef[6] := recref.Field(Questions.FieldNo("Question Category"));
                    FieldRef[7] := recref.Field(Questions.FieldNo("Requires Drill-Down"));
                    FieldRef[8] := recref.Field(Questions.FieldNo("Mandatory"));
                    FieldRef[9] := recref.Field(Questions.FieldNo("Activates Question"));
                    FieldRef[10] := recref.Field(Questions.FieldNo("Activates Based On Answer"));
                    FieldRef[11] := recref.Field(Questions.FieldNo("Activates Based On Value"));
                    FileName := 'Survey ' + Rec."Survey Code";
                    CsvHandler.ExportExcelFile(FileName, RecRef, FieldRef, 11, ExcelBuffer, 'Questions Setup', 1);

                    //Sasa tuexport drill down answers
                    Clear(recref);
                    Clear(FieldRef);
                    DrillDownAnswers.Reset();
                    DrillDownAnswers.SetRange("Survey Code", Rec."Survey Code");
                    DrillDownAnswers.SetRange("Semester Code", Rec."Semester Code");
                    if not DrillDownAnswers.FindSet() then begin
                        DrillDownAnswers.Init();
                        DrillDownAnswers."Survey Code" := Rec."Survey Code";
                        DrillDownAnswers."Semester Code" := Rec."Semester Code";
                        DrillDownAnswers.Insert(true);
                    end;

                    recref.GetTable(DrillDownAnswers);
                    FieldRef[1] := recref.Field(DrillDownAnswers.FieldNo("Semester Code"));
                    FieldRef[2] := recref.Field(DrillDownAnswers.FieldNo("Survey Code"));
                    FieldRef[3] := recref.Field(DrillDownAnswers.FieldNo("Entry No"));
                    FieldRef[4] := recref.Field(DrillDownAnswers.FieldNo("Quiz No."));
                    FieldRef[5] := recref.Field(DrillDownAnswers.FieldNo("Choice"));

                    CsvHandler.ExportExcelFile(FileName, RecRef, FieldRef, 5, ExcelBuffer, 'Drill Down Answers', 2);
                    CsvHandler.downloadFromExelBuffer(ExcelBuffer, FileName);
                    Message('Excel file has been generated with two sheets,\ One for questions and the other for drill down answers.\ Fill in and upload the file to import the questionnaire setup.');
                end;
            }
            action("Import Excel")
            {
                ApplicationArea = All;
                Caption = 'Import Questions';
                Promoted = true;
                PromotedCategory = Category4;
                Image = ImportExcel;
                trigger OnAction()
                var
                    CsvHandler: Codeunit "DAQA Csv Handler";
                    Questions: Record "Project Monitor Quiz";
                    recref: array[20] of RecordRef;
                    FieldRef: array[20] of FieldRef;
                    FileName: Text[250];
                    DrillDownAnswers: Record "Drill Down Answers";
                    ExcelBuffer: Record "Excel Buffer" temporary;
                    Fields: Dictionary of [Integer, List of [Integer]];
                    ArrSheetName: array[20] of Text;
                    fieldlist: List of [Integer];
                begin
                    recref[1].GetTable(Questions);
                    recref[2].GetTable(DrillDownAnswers);
                    ArrSheetName[1] := 'Questions Setup';
                    ArrSheetName[2] := 'Drill Down Answers';
                    fieldlist.Add(Questions.FieldNo("Semester Code"));
                    fieldlist.Add(Questions.FieldNo("Survey Code"));
                    fieldlist.Add(Questions.FieldNo("Quiz No."));
                    fieldlist.Add(Questions.FieldNo("Question"));
                    fieldlist.Add(Questions.FieldNo("Question Type"));
                    fieldlist.Add(Questions.FieldNo("Question Category"));
                    fieldlist.Add(Questions.FieldNo("Requires Drill-Down"));
                    fieldlist.Add(Questions.FieldNo("Mandatory"));
                    fieldlist.Add(Questions.FieldNo("Activates Question"));
                    fieldlist.Add(Questions.FieldNo("Activates Based On Answer"));
                    fieldlist.Add(Questions.FieldNo("Activates Based On Value"));
                    Fields.Add(1, fieldlist);
                    Clear(fieldlist);
                    fieldlist.Add(DrillDownAnswers.FieldNo("Semester Code"));
                    fieldlist.Add(DrillDownAnswers.FieldNo("Survey Code"));
                    fieldlist.Add(DrillDownAnswers.FieldNo("Entry No"));
                    fieldlist.Add(DrillDownAnswers.FieldNo("Quiz No."));
                    fieldlist.Add(DrillDownAnswers.FieldNo("Choice"));
                    Fields.Add(2, fieldlist);
                    CsvHandler.importFromExcel(recref, ArrSheetName, 2, Fields);
                end;
            }
            action("Export Answers")
            {
                ApplicationArea = All;
                Caption = 'Export Answers';
                Promoted = true;
                PromotedCategory = Category5;
                Image = AnalysisView;
                trigger OnAction()
                var
                    CsvHandler: Codeunit "DAQA Csv Handler";
                    ExcelBuffer: Record "Excel Buffer" temporary;
                begin
                    CsvHandler.ExportQuestionsAndAnswers(ExcelBuffer, Rec."Survey Code" + ' Survey Answers', Rec."Survey Code");
                    CsvHandler.downloadFromExelBuffer(ExcelBuffer, Rec."Survey Code" + ' Survey Answers');
                end;
            }
            action("Show Charts")
            {
                ApplicationArea = All;
                Caption = 'Show Charts';
                Promoted = true;
                PromotedCategory = Category6;
                Image = ShowChart;
                RunObject = page "Survey Charts";
                RunPageLink = "Survey Code" = field("Survey Code");
            }
            action("Publish Survey")
            {
                ApplicationArea = All;
                Caption = 'Publish Survey';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    SurveyHandler: Codeunit "DAQA Quiz Handler";
                    ConfirmManagement: Codeunit "Confirm Management";
                    Text001: Text;
                begin
                    Text001 := StrSubstNo('Are you sure you want to publish the survey %1?', Rec."Survey Code");
                    if not ConfirmManagement.GetResponseOrDefault(Text001, true) then
                        exit;
                    SurveyHandler.PublishSurvey(Rec);
                    SurveyHandler.ModifySurvey(Rec);
                end;
            }
            action("Close Survey")
            {
                ApplicationArea = All;
                Caption = 'Close Survey';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    SurveyHandler: Codeunit "DAQA Quiz Handler";
                    ConfirmManagement: Codeunit "Confirm Management";
                    Text001: Text;
                begin
                    Text001 := StrSubstNo('Are you sure you want to close the survey %1?', Rec."Survey Code");
                    if not ConfirmManagement.GetResponseOrDefault(Text001, true) then
                        exit;
                    SurveyHandler.CloseSurvey(Rec);
                    SurveyHandler.ModifySurvey(Rec);
                end;
            }
        }
        area(Navigation)
        {
            action("Survey Student Groups")
            {
                ApplicationArea = All;
                Caption = 'Survey Student Groups';
                Promoted = true;
                PromotedCategory = Category4;
                Image = Group;
                RunObject = page "Survey Student Groups";
                RunPageLink = "Survey Code" = field("Survey Code");
            }
            action(Instructions)
            {
                ApplicationArea = All;
                Caption = 'Instructions';
                Promoted = true;
                PromotedCategory = Category7;
                Image = GiroPlus;
                RunObject = page "Questionnaire Instructions";
                RunPageLink = "Survey Code" = field("Survey Code");
            }
        }
    }
}
