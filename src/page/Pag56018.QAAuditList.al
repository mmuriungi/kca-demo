page 56018 "QA Audit List"
{
    ApplicationArea = All;
    Caption = 'QA Audit List';
    PageType = List;
    SourceTable = "QA Audit Header";
    UsageCategory = Lists;
    CardPageId = "QA  Audit Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Audit Header No."; Rec."Audit Header No.")
                {
                    ToolTip = 'Specifies the value of the Audit No. field.';
                    ApplicationArea = All;
                }
                field("Audit No."; Rec."Audit No.")
                {
                    ToolTip = 'Specifies the value of the Audit No. field.';
                    ApplicationArea = All;
                }
                field("Audit Criteria"; Rec."Audit Criteria")
                {
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                }
                field("Audit team leader"; Rec."Audit team leader")
                {
                    ToolTip = 'Specifies the value of the Audit Team Leader field.';
                    ApplicationArea = All;
                }
                field("Audit team leader Name"; Rec."Audit team leader Name")
                {
                    ToolTip = 'Specifies the value of the Audit team leader Name field.';
                    ApplicationArea = All;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
