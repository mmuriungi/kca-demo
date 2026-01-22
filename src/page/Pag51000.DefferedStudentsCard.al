page 51000 "Deffered Students Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = defferedStudents;

    layout
    {
        area(Content)
        {
            group("Student Details")
            {

                field(studentNo; Rec.studentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the studentNo field.';
                }
                field(studentName; Rec.studentName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the studentName field.';
                }
                field(Semster; Rec.Semeter)
                {
                    ApplicationArea = All;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                }
                field(stage; Rec.stage)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the stage field.';
                }
                field(programme; Rec.programme)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the programme field.';
                }
                field(Department; Rec.Department)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("E-mail"; Rec."E-mail")
                {
                    Editable = false;
                    ApplicationArea = All;
                }


            }
            group("Call off Reason")
            {
                field("Reason for Calling off"; Rec."Reason for Calling off")
                {
                    ApplicationArea = All;

                }
                field(deffermentReason; Rec.deffermentReason)
                {
                    Caption = 'If Other please specify';
                    ApplicationArea = All;
                }
            }
            group("Recommendation By The Relevant COD")
            {
                field("Recommendation COD"; Rec."Recommendation COD")
                {
                    ApplicationArea = All;
                }
            }
            group("Recommendation By The Relevant Dean")
            {
                field("Recommendation Dean"; Rec."Recommendation Dean")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    if Rec.Get() then
                        if Confirm('Do you want to Accept the Application?', true) = false then exit;
                    Rec.status := Rec.status::Approved;
                    Rec.Modify();
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    if Rec.Get() then
                        if Confirm('Do you want to Reject the Application?', true) = false then exit;
                    Rec.status := Rec.status::Cancelled;
                    Rec.Modify();
                end;
            }
        }
    }

}