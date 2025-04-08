page 50458 Auditors
{
    ApplicationArea = All;
    Caption = 'Auditors';
    PageType = List;
    SourceTable = "Auditors List";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Auditor No"; Rec."Auditor No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auditor No field.', Comment = '%';
                }
                field("Auditor Name"; Rec."Auditor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auditor Name field.', Comment = '%';
                }
                field("Auditor Email"; Rec."Auditor Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auditor Email field.', Comment = '%';
                }
            }
        }
    }
}
