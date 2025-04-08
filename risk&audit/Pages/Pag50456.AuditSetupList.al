page 50456 "Audit Setup List"
{
    ApplicationArea = All;
    Caption = 'Audit Setup List';
    PageType = List;
    CardPageId = "Audit Setup";
    SourceTable = "Audit Setup";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Audit Nos."; Rec."Audit Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Audit Nos. field.', Comment = '%';
                }
                field("Project Nos."; Rec."Project Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Nos. field.', Comment = '%';
                }
                field("Compliance Nos."; Rec."Compliance Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Compliance Nos. field.', Comment = '%';
                }
                field("Audit Report Nos."; Rec."Audit Report Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Audit Report Nos. field.', Comment = '%';
                }
                field("Audit Workplan Nos."; Rec."Audit Workplan Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Audit Workplan Nos. field.', Comment = '%';
                }
                field("Audit Program Nos."; Rec."Audit Program Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Audit Program Nos. field.', Comment = '%';
                }
                field("Audit Record Requisition Nos."; Rec."Audit Record Requisition Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Audit Record Requisition Nos. field.', Comment = '%';
                }
                field("Audit Plan Nos."; Rec."Audit Plan Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Audit Plan Nos. field.', Comment = '%';
                }
                field("Organazation Workplan No."; Rec."Organazation Workplan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Organazation Workplan No. field.', Comment = '%';
                }
                field("Incident Reporting Nos."; Rec."Incident Reporting Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incident Reporting Nos. field.', Comment = '%';
                }
                field("Department Workplan No."; Rec."Department Workplan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Workplan No. field.', Comment = '%';
                }
            }
        }
    }
}
