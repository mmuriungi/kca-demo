page 52151 "Document Setup"
{
    ApplicationArea = All;
    Caption = 'Document Setup';
    PageType = List;
    SourceTable = "ACA-New Stud. Doc. Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
                field("Document Code"; Rec."Document Code")
                {
                    ToolTip = 'Specifies the value of the Document Code field.', Comment = '%';
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ToolTip = 'Specifies the value of the Mandatory field.', Comment = '%';
                }
                field(Sequence; Rec.Sequence)
                {
                    ToolTip = 'Specifies the value of the Sequence field.', Comment = '%';
                }
                field("Report Caption"; Rec."Report Caption")
                {
                    ToolTip = 'Specifies the value of the Report Caption field.', Comment = '%';
                }
                field("Next Sequence"; Rec."Next Sequence")
                {
                    ToolTip = 'Specifies the value of the Next Sequence field.', Comment = '%';
                }
                field("Is Hostel"; Rec."Is Hostel")
                {
                    ToolTip = 'Specifies the value of the Is Hostel field.', Comment = '%';
                }
                field(Approvers; Rec.Approvers)
                {
                    ToolTip = 'Specifies the value of the Approvers field.', Comment = '%';
                }
                field("Final Stage"; Rec."Final Stage")
                {
                    ToolTip = 'Specifies the value of the Final Stage field.', Comment = '%';
                }
                field("First Stage"; Rec."First Stage")
                {
                    ToolTip = 'Specifies the value of the First Stage field.', Comment = '%';
                }
                field("Hide in Report"; Rec."Hide in Report")
                {
                    ToolTip = 'Specifies the value of the Hide in Report field.', Comment = '%';
                }
            }
        }
    }
}
