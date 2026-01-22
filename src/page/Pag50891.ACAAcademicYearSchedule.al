/// <summary>
/// Page ACA-Academic Year Schedule (ID 68840).
/// </summary>
page 50891 "ACA-Academic Year Schedule"
{
    PageType = ListPart;
    SourceTable = "ACA-Academic Year Schedule";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Description of Intake/Semester"; Rec."Description of Intake/Semester")
                {
                    ApplicationArea = All;
                }
                field(Intake; Rec.Intake)
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
                field("Is Current"; Rec."Is Current")
                {
                    ApplicationArea = All;
                }
                field("Registration Deadline"; Rec."Registration Deadline")
                {
                    ApplicationArea = All;
                }
                field("Allow View of Results"; Rec."Allow View of Results")
                {
                    ApplicationArea = All;
                }
                field("Marks Caprture Begin Date"; Rec."Marks Caprture Begin Date")
                {
                    ApplicationArea = All;
                }
                field("Marks Caprture End Date"; Rec."Marks Caprture End Date")
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

