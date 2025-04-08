page 50459 "Auditing Team"
{
    Caption = 'Auditing Team';
    PageType = ListPart;
    SourceTable = "Auditors List";

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
                field(Role; Role)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
