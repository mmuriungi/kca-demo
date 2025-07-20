page 52179032 "Audit Universe Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Audit Universe";
    Caption = 'Audit Universe Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the audit universe entry.';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the audit universe entry.';
                }
                field("Audit Area"; Rec."Audit Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the audit area type.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department name.';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the audit universe entry.';
                }
            }
            
            group("Risk Assessment")
            {
                Caption = 'Risk Assessment';
                
                field("Risk Rating"; Rec."Risk Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk rating.';
                }
                field("Risk Score"; Rec."Risk Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the calculated risk score.';
                }
                field("Business Impact"; Rec."Business Impact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the business impact level.';
                }
                field("Regulatory Requirements"; Rec."Regulatory Requirements")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if there are regulatory requirements.';
                }
            }
            
            group("Audit Planning")
            {
                Caption = 'Audit Planning';
                
                field("Audit Frequency"; Rec."Audit Frequency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how frequently this area should be audited.';
                }
                field("Last Audit Date"; Rec."Last Audit Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the last audit.';
                }
                field("Next Audit Date"; Rec."Next Audit Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the next planned audit.';
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budget amount for auditing this area.';
                }
                field("Budgeted Hours"; Rec."Budgeted Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budgeted hours for auditing this area.';
                }
            }
            
            group("Contact Information")
            {
                Caption = 'Contact Information';
                
                field("Primary Contact"; Rec."Primary Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the primary contact for this audit area.';
                }
                field("Primary Contact Name"; Rec."Primary Contact Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the primary contact.';
                }
            }
            
            group("Process Details")
            {
                Caption = 'Process Details';
                
                field("Process Description"; Rec."Process Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the process description.';
                    MultiLine = true;
                }
                field("Key Controls"; Rec."Key Controls")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the key controls for this area.';
                    MultiLine = true;
                }
            }
            
            group(Statistics)
            {
                Caption = 'Statistics';
                
                field("Project History"; Rec."Project History")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the number of historical audit projects.';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who created this record.';
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this record was created.';
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who last modified this record.';
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this record was last modified.';
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Create Audit")
            {
                ApplicationArea = All;
                Caption = 'Create Audit';
                Image = New;
                ToolTip = 'Create a new audit for this universe entry.';
                
                trigger OnAction()
                var
                    AuditHeader: Record "Audit Header";
                begin
                    AuditHeader.Init();
                    AuditHeader.Type := AuditHeader.Type::Audit;
                    AuditHeader.Description := 'Audit of ' + Rec.Description;
                    AuditHeader."Shortcut Dimension 1 Code" := Rec."Department Code";
                    AuditHeader.Insert(true);
                    Page.Run(Page::"Audit Card", AuditHeader);
                end;
            }
            action("Risk Assessment")
            {
                ApplicationArea = All;
                Caption = 'Risk Assessment';
                Image = Risks;
                ToolTip = 'Perform risk assessment for this audit area.';
                
                trigger OnAction()
                begin
                    Message('Risk assessment functionality will be implemented.');
                end;
            }
        }
        area(Navigation)
        {
            action("Related Audits")
            {
                ApplicationArea = All;
                Caption = 'Related Audits';
                Image = Navigate;
                ToolTip = 'View audits related to this audit universe entry.';
                
                trigger OnAction()
                var
                    AuditHeader: Record "Audit Header";
                begin
                    AuditHeader.SetRange(Type, AuditHeader.Type::Audit);
                    AuditHeader.SetRange("Shortcut Dimension 1 Code", Rec."Department Code");
                    Page.Run(Page::"Audit List", AuditHeader);
                end;
            }
        }
    }
}