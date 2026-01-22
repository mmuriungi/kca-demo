page 50475 "HRM-Appraisal Goal Setting H"
{
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HRM-Appraisal Goal Setting H";
    SourceTableView = WHERE(Sent = FILTER("At Appraisee"));

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
                }
                field("Total Value Assessment Score"; Rec."Total Value Assessment Score")
                {
                }
                field("Total Score of Targets(Points)"; Rec."Total Score of Targets(Points)")
                {
                }
                field("Total Score of Targets(%)"; Rec."Total Score of Targets(%)")
                {
                }
            }
            // part("Departmental Objectives";"HRM-Department Objectives")
            // {
            //     Caption = 'Departmental Objectives';
            //     SubPageLink = "Employee No"=FIELD("Employee No"),
            //                   "Appraisal Period"=FIELD("Appraisal Period"),
            //                   "Appraisal Type"=FIELD("Appraisal Type");
            // }
            // part(Control1102755015;"HRM-Emp. Performance Target")
            // {
            // }
            // part(Control1102755017;"HRM-Emp. Values assesment")
            // {
            // }
            part(Control1102755018; "HRM-Appraisal Other Details")
            {
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
          END;
         */

    end;
}

