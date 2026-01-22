page 52179117 "Audit Projects List"
{
    ApplicationArea = All;
    Caption = 'Audit Projects';
    PageType = List;
    SourceTable = Projects;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Code field.';
                }
                field("Project Description"; Rec."Project Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Description field.';
                }
                field("Project Manager"; Rec."Project Manager")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Manager field.';
                }
                field("Project Manager Name"; Rec."Project Manager Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Manager Name field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Date Time Created"; Rec."Date Time Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Time Created field.';
                }
            }
        }
    }
}