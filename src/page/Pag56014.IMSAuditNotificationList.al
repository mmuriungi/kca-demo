page 56014 "IMS Audit Notification List"
{
    ApplicationArea = All;
    Caption = 'IMS Audit Notification List';
    PageType = List;
    CardPageId = "IMS Audit Notification Form";
    SourceTable = "IMS Audit Notification Form";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Audit No."; Rec."Audit No.")
                {
                    ToolTip = 'Specifies the value of the Audit No. field.';
                    ApplicationArea = All;
                }
                field("Audit date:"; Rec."Audit date:")
                {
                    ToolTip = 'Specifies the value of the Audit date: field.';
                    ApplicationArea = All;
                }
                field("Centre to be audited"; Rec."Centre to be audited")
                {
                    ToolTip = 'Specifies the value of the Centre to be audited field.';
                    ApplicationArea = All;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                }
                field("Basis of audit"; Rec."Basis of audit")
                {
                    ToolTip = 'Specifies the value of the Basis of audit field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
