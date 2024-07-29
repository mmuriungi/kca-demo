page 56011 "IMS Audit Notification Form"
{
    Caption = 'IMS Audit Notification Form';
    PageType = Card;
    SourceTable = "IMS Audit Notification Form";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Audit No."; Rec."Audit No.")
                {
                    ToolTip = 'Specifies the value of the Audit No. field.';
                    ApplicationArea = All;
                    Caption = 'Audit No.';
                }
                field("Audit date:"; Rec."Audit date:")
                {
                    ToolTip = 'Specifies the value of the Audit date: field.';
                    ApplicationArea = All;
                    Caption = 'Audit date';
                }
                field("Basis of audit"; Rec."Basis of audit")
                {
                    ToolTip = 'Specifies the value of the Basis of audit field.';
                    ApplicationArea = All;
                    Caption = 'Basis of audit';
                    MultiLine = true;
                }
                field("Centre to be audited"; Rec."Centre to be audited")
                {
                    ToolTip = 'Specifies the value of the Centre to be audited field.';
                    ApplicationArea = All;
                    Caption = 'Centre to be audited';
                }
                field("Purpose of audit"; Rec."Purpose of audit")
                {
                    ToolTip = 'Specifies the value of the Purpose of audit field.';
                    ApplicationArea = All;
                    Caption = 'Purpose of audit';
                    MultiLine = true;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                    Caption = 'Region Name';
                }
                field("Scope of the audit"; Rec."Scope of the audit")
                {
                    ToolTip = 'Specifies the value of the Scope of the audit field.';
                    ApplicationArea = All;
                    Caption = 'Scope of the audit';
                    MultiLine = true;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)


        {
            action("QA-Audit Team")
            {
                Caption = 'QA Audit Team';
                Image = List;
                ApplicationArea = All;
                RunObject = Page "QA Audit Team";
                RunPageLink = "Audit No." = FIELD("Audit No.");
            }
        }
    }
}
