page 50477 "HRM-Appraisal Goal Setting HS"
{
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HRM-Appraisal Goal Setting H";
    SourceTableView = WHERE(Status = CONST(Approved));

    layout
    {
        area(content)
        {
            group("Appraisee Information")
            {
                Caption = 'Appraisee Information';
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Importance = Promoted;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Importance = Promoted;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Importance = Promoted;
                }
                field("Overal Rating Desc"; Rec."Overal Rating Desc")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Supervisor; Rec.Supervisor)
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("SuperVisor Email"; Rec."SuperVisor Email")
                {
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    Importance = Promoted;
                }
                field("Appraisal Stage"; Rec."Appraisal Stage")
                {
                }
                field(Sent; Rec.Sent)
                {
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
            }
            group("Appraisal Ratings")
            {
                Caption = 'Appraisal Ratings';
                field("Total PTarget Score"; Rec."Total PTarget Score")
                {
                    Caption = 'Total PTarget Score';
                }
                field("Total Value Assessment Score"; Rec."Total Value Assessment Score")
                {
                    Caption = 'Total Value Assessment Score';
                }
                field("Total Score of Targets(Points)"; Rec."Total Score of Targets(Points)")
                {
                    Caption = 'Total Score of Targets(Points)';
                }
                field("Total Score of Targets(%)"; Rec."Total Score of Targets(%)")
                {
                    Caption = 'Total Score of Targets(%)';
                }
            }
            // part("Departmental Objectives";"HRM-Department Objectives")
            // {
            //     Caption = 'Departmental Objectives';
            //     SubPageLink = "Employee No"=FIELD("Employee No"),
            //                   "Appraisal Period"=FIELD("Appraisal Period"),
            //                   "Appraisal Type"=FIELD("Appraisal Type");
            // }
            part("Employee Performance Targets"; "HRM-Emp. Performance Target")
            {
                Caption = 'Employee Performance Targets';
            }
            // part("Employee Values assessment";"HRM-Emp. Values assesment")
            // {
            //     Caption = 'Employee Values assessment';
            // }
            part("Appraisal Other Details"; "HRM-Appraisal Other Details")
            {
                Caption = 'Appraisal Other Details';
            }
        }
        area(factboxes)
        {
            systempart(Control1000000002; Outlook)
            {
            }
            systempart(Control1000000003; Notes)
            {
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
                action("Send To Supervisor")
                {
                    Caption = 'Send To Supervisor';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //LinesExists;

                        if Confirm('Do you want to send this Appraisal Form to  your Supervisor?', false) = true then begin
                            Rec.Sent := 1;
                            Rec.Modify;
                            Message('%1', 'Process Completed')
                        end;
                    end;
                }
            }
        }
    }

    var
        HasLines: Boolean;
        Text19033494: Label 'Set your goals and objectives in line with your departments strategy.';
        "Goal Setting": Record "HRM-Appraisal Goal Setting L";
        HRAppraisalGoals: Record "HRM-Appraisal Goal Setting L";

    procedure LinesExists(): Boolean
    var
        HRAppraisalGoals: Record "PRL-Pension Details";
    begin
        /*HasLines:=FALSE;
        HRAppraisalGoals.RESET;
        HRAppraisalGoals.SETRANGE(HRAppraisalGoals."Appraisal No","Appraisal No");
        IF HRAppraisalGoals.FIND('-') THEN BEGIN
             HasLines:=TRUE;
             EXIT(HasLines);
          END;   */

    end;
}

