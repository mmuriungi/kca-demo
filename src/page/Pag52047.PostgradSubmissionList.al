page 52047 "Postgrad Submission List"
{
    ApplicationArea = All;
    Caption = 'Postgrad Submission List';
    PageType = List;
    SourceTable = "Student Submission";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.', Comment = '%';
                }
                field("Submission Type"; Rec."Submission Type")
                {
                    ToolTip = 'Specifies the value of the Submission Type field.', Comment = '%';
                }
                field("Submission Date"; Rec."Submission Date")
                {
                    ToolTip = 'Specifies the value of the Submission Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Document Link"; Rec."Document Link")
                {
                    ToolTip = 'Specifies the value of the Document Link field.', Comment = '%';
                }
            }
        }
    }
}
