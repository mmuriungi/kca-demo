page 50946 "Exam Res. List"
{
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ACA-Exam Results";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Exam; Rec.Exam)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the value of the Academic Year field.';
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Specifies the value of the Semester field.';
                    ApplicationArea = All;
                }
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                    ApplicationArea = All;
                }
                field("Lecturer Names"; Rec."Lecturer Names")
                {
                    ToolTip = 'Specifies the value of the Lecturer Names field.';
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field(Contribution; Rec.Contribution)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field("Last Modified by"; Rec."Last Modified by")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Modified by field.';
                }
                field("Date Last Modified"; Rec."Date Last Modified")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Last Modified field.';
                }
                field("Time Last Modified"; Rec."Time Last Modified")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Last Modified field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // action(DeleteMark)
            // {
            //     Caption = 'Delete Mark';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //     begin

            //     end;
            // }
        }
    }
}

