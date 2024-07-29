page  51220 "Appraisal Header"
{
    PageType = Document;
    SourceTable = "Appraisal Card";

    layout
    {
        area(content)
        {
            group("TO BE COMPLETED BY EMPLOYEE")
            {
                Caption = 'TO BE COMPLETED BY EMPLOYEE';
                field("Appraisal Code"; Rec."Appraisal Code")
                {
                }
                field("Staff No"; Rec."Staff No")
                {
                }
                field("Staff Name"; Rec."Staff Name")
                {
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
                field(Supervisor; Rec.Supervisor)
                {
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                }
                field("Current Department"; Rec."Current Department")
                {
                }
                field("Position Held Since"; Rec."Position Held Since")
                {
                    Caption = 'Date of First Appointment at Kabarak University';
                }
                field("Job Title"; Rec."Job Title")
                {
                    Caption = 'Present Designation';
                }
                field("No.of Children"; Rec."No.of Children")
                {
                }
                field("Work Rewarding"; Rec."Work Rewarding")
                {
                    Caption = '9. Do you fine your work Reqarding';
                }
                field(Text1; Rec.Text1)
                {
                    Caption = 'If No,Explain';
                    MultiLine = true;
                }
                field(Text2; Rec.Text2)
                {
                    Caption = '10. What do you consider to be your proffessional achievements during your contract period.Please list them in order of success/impact';
                    MultiLine = true;
                }
                field(Text3; Rec.Text3)
                {
                    Caption = '11.(a) Please List the challenges you have experienced during the period while performing your duties specifically in the following areas;(i)While dealing with students';
                    MultiLine = true;
                }
                field(Text4; Rec.Text4)
                {
                    Caption = '(ii) While dealing with staff you supervise';
                }
                field(Text5; Rec.Text5)
                {
                    Caption = '(iii) While dealing with  your supervisor';
                }
                field(Text6; Rec.Text6)
                {
                    Caption = '(iv)While dealing with collegues,both seniors and Juniors';
                    MultiLine = true;
                }
                field(Text7; Rec.Text7)
                {
                    Caption = '(b)Please list membership of  proffessional,Technical societies/Associations,boards,committes,etc to which you are registred/afflicted';
                    MultiLine = true;
                }
                field(Text8; Rec.Text8)
                {
                    Caption = '(c) Please List extra-Curicula activities to which you have been involved in the university';
                    MultiLine = true;
                }
                field(Text9; Rec.Text9)
                {
                    Caption = '(d) Please list the university committees/working parties you have been involved in during your Current  contract';
                    MultiLine = true;
                }
                field(Text10; Rec.Text10)
                {
                    Caption = '(e) Please list articles,publications or seminars/presentations made during the period ofcurrent contract';
                    MultiLine = true;
                }
                field(Text11; Rec.Text11)
                {
                    Caption = '(f)Please list any research activities in progress';
                    MultiLine = true;
                }
                field(Text12; Rec.Text12)
                {
                    Caption = '12. Have you been served a verbal or written warning/caution during the period of the present Contract.If yes give details';
                }
            }
            /* part("TO BE COMPLETED BY HOD"; "Performance Cascade List 5")
            {
                Caption = 'TO BE COMPLETED BY HOD';
                SubPageLink = "Workplan Code" = FIELD("Appraisal Code");
            } */
            group("HR COMMENTS & APPROVAL AREA")
            {
                Caption = 'HR COMMENTS & APPROVAL AREA';
            }
            field("Comments by HR"; Rec."Comments by HR")
            {
                MultiLine = false;
            }
            field("Approval by CEO"; Rec."Approval by VC/DVC")
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Send to Supervisor")
                {
                    Caption = 'Send to Supervisor';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        IF CONFIRM('Are you sure you want to send this appraisal form to you supervisor?') THEN BEGIN
                            Rec.Status := Rec.Status::Supervisor;
                            Rec.MODIFY;
                            MESSAGE('Appraisal  Number %1 has been to the supervisor for rating', Rec."Appraisal Code");
                        END;
                    end;
                }
            }
        }
    }
}

