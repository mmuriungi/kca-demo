page 51700 "HMS-Cue"
{
    PageType = CardPart;
    SourceTable = "HMS-Cue";

    layout
    {
        area(content)
        {
            cuegroup("Registration Statistics")
            {
                Caption = 'Registration Statistics';
                field(Students; Rec.Students)
                {
                    Caption = 'Students';
                    DrillDownPageID = "HMS-Patient Student List";
                    ApplicationArea = All;


                }
                field(Employees; Rec.Employees)
                {
                    Caption = 'Employees';
                    DrillDownPageID = "HMS-Patient Employee List";
                    ApplicationArea = All;
                }
                // field(Dependants; Rec.Dependants)
                // {
                //     Caption = 'Dependants';
                //     DrillDownPageID = "HMS-Patient Relative List";
                //     ApplicationArea = All;
                // }
                field(InactiveEmp; Rec."Other Patients")
                {
                    Caption = 'Other Patients';
                    DrillDownPageID = "HMS-Patient Others List";
                    ApplicationArea = All;
                }


            }
        }
    }

    actions
    {
    }
    var
        StudentsCount: Integer;

    trigger OnOpenPage()
    begin
        StudentsCount := GetStudentsCount();
    end;

    procedure GetStudentsCount(): Integer
    var
        StudentRec: Record "HMS-Patient"; // Replace with your actual table name
    begin
        StudentRec.Reset();
        exit(StudentRec.Count);
    end;

}

