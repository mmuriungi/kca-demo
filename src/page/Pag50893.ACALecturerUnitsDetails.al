page 50893 "ACA-Lecturer Units Details"
{
    PageType = List;
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
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("No. Of Hours"; Rec."No. Of Hours")
                {
                    ApplicationArea = All;
                }
                field("No. Of Hours Contracted"; Rec."No. Of Hours Contracted")
                {
                    ApplicationArea = All;
                }
                field("Available From"; Rec."Available From")
                {
                    ApplicationArea = All;
                }
                field("Available To"; Rec."Available To")
                {
                    ApplicationArea = All;
                }
                field("Time Table Hours"; Rec."Time Table Hours")
                {
                    ApplicationArea = All;
                }
                field("Unit Students Count"; Rec."Unit Students Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Allocation"; Rec."Student Allocation")
                {
                    ApplicationArea = All;
                }
                field("Required Equipment";Rec."Required Equipment")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var
        Allocations: Record "ACA-Lecturers Units";
    begin
        Allocations.Reset();
        Allocations.SetRange(Semester, 'SEM1 24/25');
        Allocations.SetRange("Student Allocation", 0);
        Allocations.SetAutoCalcFields("Unit Students Count");
        Allocations.SetFilter("Unit Students Count", '>%1', 0);
        if Allocations.FindSet() then begin
            Allocations.ModifyAll("Student Allocation", Allocations."Unit Students Count");
        end;
    end;
}

