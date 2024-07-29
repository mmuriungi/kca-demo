page 54244 "Casual Employees Card."
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Casual Employees.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Casual No"; Rec."Casual No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Full  Name"; Rec."Full  Name")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("D O B"; Rec."D O B")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Revenue Division"; Rec."Revenue Division")
                {
                    ApplicationArea = All;
                }
                field("Division Name"; Rec."Division Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No of Hours"; Rec."No of Hours")
                {
                    ApplicationArea = All;
                }
                field("No of Days"; Rec."No of Days")
                {
                    ApplicationArea = All;
                }
                field("No of Days value"; Rec."No of Days value")
                {
                    ApplicationArea = All;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                }
            }
            group("Occupation Code")
            {
                field("Task Code"; Rec."Task Code")
                {
                    Caption = 'Occupation Code';
                    ApplicationArea = All;
                }
                field("Task  Description"; Rec."Task  Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Rate Per Month"; Rec."Rate Per Month")
                {
                    ApplicationArea = All;
                }
                field("Rate per Day"; Rec."Rate per Day")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

