page 50643 "HRM-Emp. Categories"
{
    Caption = 'Employee Categories';
    DataCaptionFields = "Code";
    PageType = List;
    Editable = true;
    SourceTable = "HRM-Employee Categories";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Retirement Age"; Rec."Retirement Age")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Salary Grades")
            {
                action(SalGrades)
                {
                    ApplicationArea = all;
                    Caption = 'Salary Grades';
                    Image = StepInto;
                    Promoted = true;
                    RunObject = Page "HRM-Job_Salary Grade/Steps";
                    RunPageLink = "Employee Category" = FIELD(Code);
                }
            }

        }
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Increament';
                action("Increament Register")
                {
                    ApplicationArea = all;
                    Caption = 'Increament Register';
                    Image = Registered;
                    Promoted = true;
                    RunObject = Page "HRM-Salary Increament Register";
                }
                action("Un-Affected Employees")
                {
                    ApplicationArea = all;
                    Caption = 'Un-Affected Employees';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HRM-Unaffected Sal. Increament";
                }
                separator(History)
                {
                    Caption = 'History';
                }
                action(PostIncreament)
                {
                    ApplicationArea = all;
                    Caption = 'Post Salary Inrements';
                    Image = PostDocument;
                    Promoted = true;

                    trigger OnAction()
                    begin

                        Message('Please go through the Increment register \and ensure that the increaments are right before posting.');
                        if Confirm('Are you sure you want to post salary increaments?', false) = false then exit;
                        postReverse.postRegister();
                    end;
                }
                action(ReverseIncreament)
                {
                    ApplicationArea = all;
                    Caption = 'Reverse Salary Increments';
                    Image = ReverseRegister;
                    Promoted = true;

                    trigger OnAction()
                    begin

                        if Confirm('Reverse salary Increment postings?', false) = false then exit;
                        postReverse.ReverseInrementPosting();
                    end;
                }
                separator(Setup)
                {
                    Caption = 'Setup';
                }
                action("Salary Grade Setup")
                {
                    Caption = 'Salary Grade Setup';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HRM-Salary Grades List";
                }
            }
        }
        area(reporting)
        {
            action(Register)
            {
                Caption = 'Register';
                Image = Register;
                Promoted = true;
                RunObject = Report "HRM-Salary Increament Register";
            }
        }
    }

    var
        salGrades: Record "HRM-Job_Salary grade/steps";
        salGrades2: Record "HRM-Job_Salary grade/steps";
        salincregister: Record "HRM-Salary Increament Register";
        salincUnaffected: Record "HRM-UnAffected Sal. Increament";
        employees: Record "HRM-Employee C";
        salaryCate: Record "HRM-Employee Categories";
        EmplMonth: Integer;
        salaStepsAmount: Record "HRM-Auto Inreament Sal. Steps";
        salaStepsAmount2: Record "HRM-Auto Inreament Sal. Steps";
        empSalaryCard: Record "PRL-Salary Card";
        unaffectedEmployees: Record "HRM-UnAffected Sal. Increament";
        salbasic: Decimal;
        salgrade: Code[20];
        salcat: Code[50];
        empcat: Record "HRM-Employee Categories";
        // empgrade: Record "HRM-Job Sal. grade/steps";
        postReverse: Codeunit "Post Salary Increments";
}

