page 54473 "Help Desk"
{
    Caption = 'Help Desk';
    PageType = List;
    CardPageId = "Students Complain card";
    SourceTable = "Students Complain";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec.no)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the no field.', Comment = '%';
                }
                field("Student  No"; Rec."Student  No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student  No field.', Comment = '%';
                }
                field("student name"; Rec."student name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the student name field.', Comment = '%';
                }
                field("student complain "; Rec."student complain ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the student complain field.', Comment = '%';
                }
                field("completion  status"; Rec."completion  status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the completion  status field.', Comment = '%';
                }
                field("student comment"; Rec."student comment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the student comment field.', Comment = '%';
                }
                field("head of hostel comment"; Rec."head of hostel comment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the head of hostel comment field.', Comment = '%';
                }

            }
        }
    }
}
