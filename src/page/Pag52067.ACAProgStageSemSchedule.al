page 52067 "ACA-Prog/Stage Sem. Schedule"
{
    ApplicationArea = All;
    Caption = 'ACA-Prog/Stage Sem. Schedule';
    PageType = List;
    SourceTable = "ACA-Prog/Stage Sem. Schedule";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Current Semester"; Rec."Current Semester")
                {
                    ToolTip = 'Specifies the value of the Current Semester field.', Comment = '%';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ToolTip = 'Specifies the value of the Stage Code field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
                field(AllowDeanEditing; Rec.AllowDeanEditing)
                {
                    ToolTip = 'Specifies the value of the Allow Dean Editing field.', Comment = '%';
                }
                field("Buffer Results"; Rec."Buffer Results")
                {
                    ToolTip = 'Specifies the value of the Buffer Results field.', Comment = '%';
                }
                field("BackLog Marks"; Rec."BackLog Marks")
                {
                    ToolTip = 'Specifies the value of the BackLog Marks field.', Comment = '%';
                }
                field("Ignore Editing Rule"; Rec."Ignore Editing Rule")
                {
                    ToolTip = 'Specifies the value of the Ignore Editing Rule field.', Comment = '%';
                }
                field("Evaluate Lecture"; Rec."Evaluate Lecture")
                {
                    ToolTip = 'Specifies the value of the Evaluate Lecture field.', Comment = '%';
                }
                field("Lock Exam Editting"; Rec."Lock Exam Editting")
                {
                    ToolTip = 'Specifies the value of the Lock Exam Editing field.', Comment = '%';
                }
                field("Lock CAT Editting"; Rec."Lock CAT Editting")
                {
                    ToolTip = 'Specifies the value of the Lock CAT Editing field.', Comment = '%';
                }
                field("Lock Lecturer Editing"; Rec."Lock Lecturer Editing")
                {
                    ToolTip = 'Specifies the value of the Lock Lecturer Editing field.', Comment = '%';
                }
                field("Mark entry Dealine"; Rec."Mark entry Dealine")
                {
                    ToolTip = 'Specifies the value of the Mark Entry Deadline field.', Comment = '%';
                }
                field("Marks Changeable"; Rec."Marks Changeable")
                {
                    ToolTip = 'Specifies the value of the Marks Changeable field.', Comment = '%';
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ToolTip = 'Specifies the value of the Programme Code field.', Comment = '%';
                }
                field("Programme Name"; Rec."Programme Name")
                {
                    ToolTip = 'Specifies the value of the Programme Name field.', Comment = '%';
                }
                field("Registration Deadline"; Rec."Registration Deadline")
                {
                    ToolTip = 'Specifies the value of the Registration Deadline field.', Comment = '%';
                }
                field("Released Results"; Rec."Released Results")
                {
                    ToolTip = 'Specifies the value of the Released Results field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
                field("SMS Results Semester"; Rec."SMS Results Semester")
                {
                    ToolTip = 'Specifies the value of the SMS Results Semester field.', Comment = '%';
                }
                field("Scheduled Stages Units"; Rec."Scheduled Stages Units")
                {
                    ToolTip = 'Specifies the value of the Scheduled Stages Units field.', Comment = '%';
                }
                field("Special Entry Deadline"; Rec."Special Entry Deadline")
                {
                    ToolTip = 'Specifies the value of the Special Entry Deadline field.', Comment = '%';
                }
                field("Supplementary Entry Deadline"; Rec."Supplementary Entry Deadline")
                {
                    ToolTip = 'Specifies the value of the Supplementary Entry Deadline field.', Comment = '%';
                }
            }
        }
    }
}
