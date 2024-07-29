page 54243 "Casual Employees."
{
    CardPageID = "Casual Employees Card.";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Casual Employees.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Casual No"; Rec."Casual No")
                {
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
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Task  Description"; Rec."Task  Description")
                {
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
            }
        }
    }

    actions
    {
    }
}

