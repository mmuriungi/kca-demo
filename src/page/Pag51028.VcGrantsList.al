page 51028 "Vc Grants List"
{
    Caption = 'Vc Grants List';
    PageType = List;
    CardPageId = "Internal VC Grant";
    SourceTable = "Internal Vc Grants";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("PF No."; Rec."PF No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PF No. field.', Comment = '%';
                }
                field("Date Requested"; Rec."Date Requested")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Requested field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(Faculty; Rec.Faculty)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Faculty field.', Comment = '%';
                }
                field("Name of Researcher"; Rec."Name of Researcher")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name of Researcher field.', Comment = '%';
                }
                field("Research Title"; Rec."Research Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Research Title field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }

            }
        }
    }
}
