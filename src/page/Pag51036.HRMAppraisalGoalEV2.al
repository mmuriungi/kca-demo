page 51036 "HRM-Appraisal Goal EV 2"
{
    PageType = Document;
    SourceTable = "HRM-Appraisal Goal Setting H";
    SourceTableView = WHERE(Status = CONST(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Appraisal No"; Rec."Appraisal No")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Supervisor; Rec.Supervisor)
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Picture; Rec.Picture)
                {
                }
            }
            // part(SF;"PROC-Procurement Plan list")
            // {
            // }
            field(Control1102755019; '')
            {
                CaptionClass = Text19043501;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Send To Appraisee")
                {
                    Caption = 'Send To Appraisee';

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to send this Appraisal Form to  your Supervisor?', false) = true then begin
                            Rec.Status := 0;
                            Rec.Modify;
                            Message('%1', 'Process Completed')
                        end;
                    end;
                }
                action("Import Evaluation Areas")
                {
                    Caption = 'Import Evaluation Areas';

                    trigger OnAction()
                    begin
                        HRAppraisalEvaluations.Reset;
                        HRAppraisalEvaluations.SetRange(HRAppraisalEvaluations."Employee No", Rec."Employee No");
                        HRAppraisalEvaluations.SetRange(HRAppraisalEvaluations.Category, HRAppraisalEvaluations.Category::"EMPLOYEE PERFORMANCE FACTOR");
                        if HRAppraisalEvaluations.Find('-') then
                            HRAppraisalEvaluations.DeleteAll;

                        //COPY EVALUATION AREA FOR ONE EMPLOYEE
                        HRAppraisalEvaluationAreas.Reset;
                        HRAppraisalEvaluationAreas.SetRange
                        (HRAppraisalEvaluationAreas."Categorize As", HRAppraisalEvaluationAreas."Categorize As"::"EMPLOYEE PERFORMANCE FACTOR");
                        if HRAppraisalEvaluationAreas.Find('-') then
                            HRAppraisalEvaluationAreas.FindFirst;
                        begin
                            HRAppraisalEvaluations.Reset;
                            repeat
                                HRAppraisalEvaluations.Init;
                                HRAppraisalEvaluations."Employee No" := Rec."Employee No";
                                HRAppraisalEvaluations."Evaluation Code" := HRAppraisalEvaluationAreas.Code;
                                HRAppraisalEvaluations."Sub Category" := HRAppraisalEvaluationAreas."Sub Category";
                                HRAppraisalEvaluations.Group := HRAppraisalEvaluationAreas.Group;
                                HRAppraisalEvaluations.Category := HRAppraisalEvaluationAreas."Categorize As";
                                HRAppraisalEvaluations."Appraisal Period" := Rec."Appraisal Period";
                                HRAppraisalEvaluations."Line No" := HRAppraisalEvaluationAreas."Line No";
                                //HRAppraisalEvaluations."Line No":=HRAppraisalEvaluations."Line No"+1;
                                HRAppraisalEvaluations.Insert();
                            until HRAppraisalEvaluationAreas.Next = 0;
                            // HRAppraisalEvaluationAreas.FINDFIRST;
                        end;
                    end;
                }
            }
        }
    }

    var
        HRAppraisalEvaluationAreas: Record "HRM-Appraisal Evaluation Areas";
        HRAppraisalEvaluations: Record "HRM-Appraisal Evaluations";
        HRAppraisalEvaluationsF: Page "HRM-Appraisal Evaluation Lines";
        Text19043501: Label 'EMPLOYEE PERFORMANCE FACTORS ';
}

