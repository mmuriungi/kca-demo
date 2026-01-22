page 51058 "Lect Load Items Part"
{
    PageType = ListPart;
    SourceTable = "ACA-Lecturers Units";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Student Allocation"; Rec."Student Allocation")
                {
                    ApplicationArea = All;
                }
                field(Stream; Rec.Stream)
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

