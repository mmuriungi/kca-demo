page 50669 prPCAMassLines
{
    PageType = ListPart;
    SourceTable = prMassPCALines;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = All;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                }
                field(Membership; Rec.Membership)
                {
                    ApplicationArea = All;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = All;
                }
                field("Salary Grade"; objemp."Salary Grade")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(AutoFill)
            {
                Caption = 'AutoFill';
                ApplicationArea = All;
            }
        }
    }

    var
        objLines: Record prMassPCALines;
        SalaryGrades: Record "HRM-Salary Grades";
        objemp: Record "HRM-Employee C";
}

