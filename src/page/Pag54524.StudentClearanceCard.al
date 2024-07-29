page 54524 "Student Clearance Card"
{
    Caption = 'Student Clearance Card';
    PageType = Card;
    SourceTable = "Student Clerance";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Clearance No"; Rec."Clearance No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clearance No field.', Comment = '%';
                }
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No field.', Comment = '%';
                }
                field("Student Name "; Rec."Student Name ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }
                field(School; Rec.School)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School field.', Comment = '%';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.', Comment = '%';
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile No field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
