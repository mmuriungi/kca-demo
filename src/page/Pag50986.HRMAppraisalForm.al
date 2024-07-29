page 50986 "HRM-Appraisal Form"
{
    PageType = Document;
    SourceTable = "HRM-Employee Appraisals";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee.""First Name"" + ' ' + Employee.""Middle Name"" + ' ' + Employee.""Last Name"""; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
                {
                    Caption = 'Names';
                }
                field("Employee.""Department Code"""; Employee."Department Code")
                {
                    Caption = 'Department';
                }
                field("Employee.""Date Of Join"""; Employee."Date Of Join")
                {
                    Caption = 'Date Employed';
                }
                field("Employee.Position"; Employee.Position)
                {
                    Caption = 'Job Position';
                }
                field("Employee.""Job Title"""; Employee."Job Title")
                {
                    Caption = 'Job Title';
                }
                field("Jobs.Grade"; Jobs.Grade)
                {
                    Caption = 'Grade';
                }
                field("Jobs.Objective"; Jobs.Objective)
                {
                    Caption = 'Job Objective/Function';
                }
                field("Job ID"; Rec."Job ID")
                {
                }
                field("No. Supervised (Directly)"; Rec."No. Supervised (Directly)")
                {
                }
                field("No. Supervised (In-Directly)"; Rec."No. Supervised (In-Directly)")
                {
                }
            }
            // part(Control1102755005;"HRM-Key Responsibil Subform")
            // {
            //     SubPageLink = "Job ID"=FIELD("Job ID");
            // }
        }
    }

    actions
    {
        area(processing)
        {
            action("Next Page   >>")
            {
                Caption = 'Next Page   >>';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if EmployeeApp.Get(Rec."Employee No", Rec."Appraisal Type", Rec."Appraisal Period") then
                        PAGE.RunModal(39005893, EmployeeApp);
                end;
            }
        }
    }

    var
        Employee: Record "HRM-Employee C";
        Jobs: Record "HRM-Company Jobs";
        EmployeeApp: Record "HRM-Employee Appraisals";
        Text19035248: Label 'Key Responsibilities';
}

