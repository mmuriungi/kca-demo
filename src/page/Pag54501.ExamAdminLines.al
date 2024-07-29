page 54501 "Exam Admin Lines"
{
    Caption = 'Exam Admin Lines';
    PageType = ListPart;
    SourceTable = "ExamAdmin Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Lecturer Hall"; Rec."Lecturer Hall")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecturer Hall field.', Comment = '%';
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Code field.', Comment = '%';
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course Name field.', Comment = '%';
                }
                field("No of Students"; Rec."No of Students")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No of Students field.', Comment = '%';
                }
                field("No of Invigilattors"; Rec."No of Invigilattors")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No of Invigilattors field.', Comment = '%';
                }
                field("Scheduled Start Time"; Rec."Scheduled Start Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scheduled Start Time field.', Comment = '%';
                }
                field("Actual Start Time"; Rec."Actual Start Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Start Time field.', Comment = '%';
                }
                field("Chief Invigillator Staff ID"; Rec."Chief Invigillator Staff ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Chief Invigillator Staff ID field.', Comment = '%';
                }
                field("Chief Invigillator's Name"; Rec."Chief Invigillator's Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Chief Invigillator''s Name field.', Comment = '%';
                }
                field("Remarks "; Rec."Remarks ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
            }
        }
    }
}
