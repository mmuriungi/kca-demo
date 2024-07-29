page 50990 "HRM-Intern&Attach  Card"
{
    PageType = Card;
    SourceTable = "HRM-Internships&Attachments";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Name; Rec.Name)
                {
                }
                field(Institution; Rec.Institution)
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field("Ref No"; Rec."Ref No")
                {
                }
                field("Year Of Study"; Rec."Year Of Study")
                {
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                }
                field(Age; Rec.Age)
                {
                    Visible = false;
                }
                field(Course; Rec.Course)
                {
                }
                field(Department; Rec.Department)
                {
                }
                field(Period; Rec.Period)
                {
                }
                field(Renewable; Rec.Renewable)
                {
                }
                field(Paid; Rec.Paid)
                {
                }
                field(Disability; Rec.Disability)
                {
                    Caption = 'P.W.D';
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Period Of Service"; Rec."Period Of Service")
                {

                }
                field("Contract Type"; Rec."Contract Type")
                {
                }
                field("-----------Duties Performed---------------------------"; '')
                {
                    Caption = 'Duties To Perform';
                }
                field("Role 1"; Rec."Role 1")
                {
                }
                field("Role 2"; Rec."Role 2")
                {
                }
                field("Role 3"; Rec."Role 3")
                {
                }
                field("Role 4"; Rec."Role 4")
                {
                }
                field("Role 5"; Rec."Role 5")
                {
                }
            }
        }
    }

    actions
    {
    }
}

