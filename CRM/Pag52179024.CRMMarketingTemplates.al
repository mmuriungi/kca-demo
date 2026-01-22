page 52179024 "CRM Marketing Templates"
{
    PageType = List;
    Caption = 'Marketing Templates';
    SourceTable = "CRM Marketing Template";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Template Code"; Rec."Template Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the template code.';
                }
                field("Template Name"; Rec."Template Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the marketing template.';
                }
                field("Template Type"; Rec."Template Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of marketing template.';
                }
                field("Category"; Rec."Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the category of this template.';
                }
                field("Subject"; Rec."Subject")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the subject line for this template.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the language code for this template.';
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this template is active.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approval status of this template.';
                    StyleExpr = ApprovalStatusStyle;
                }
                field("Usage Count"; Rec."Usage Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows how many times this template has been used.';
                }
                field("Last Used Date"; Rec."Last Used Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this template was last used.';
                }
                field("GDPR Compliant"; Rec."GDPR Compliant")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this template is GDPR compliant.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who created this template.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this template was created.';
                }
            }
        }
        area(factboxes)
        {
            part("Template Statistics"; "CRM Dashboard FactBox")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Edit Template")
            {
                ApplicationArea = All;
                Caption = 'Edit Template';
                Image = Edit;
                ToolTip = 'Edit the content of this marketing template.';
                
                trigger OnAction()
                begin
                    Page.Run(Page::"CRM Marketing Template Card", Rec);
                end;
            }
            
            action("Preview Template")
            {
                ApplicationArea = All;
                Caption = 'Preview Template';
                Image = View;
                ToolTip = 'Preview how this template will look.';
                
                trigger OnAction()
                var
                    ContentText: Text;
                begin
                    ContentText := Rec.GetContentAsText();
                    if ContentText <> '' then
                        Message('Template Preview:\n\nSubject: %1\n\nContent:\n%2', Rec.Subject, ContentText)
                    else
                        Message('Template content is empty.');
                end;
            }
            
            action("Duplicate Template")
            {
                ApplicationArea = All;
                Caption = 'Duplicate Template';
                Image = Copy;
                ToolTip = 'Create a copy of this template.';
                
                trigger OnAction()
                var
                    NewTemplate: Record "CRM Marketing Template";
                    NewCode: Code[20];
                begin
                    NewCode := Rec."Template Code" + '-COPY';
                    NewTemplate := Rec;
                    NewTemplate."Template Code" := NewCode;
                    NewTemplate."Template Name" := Rec."Template Name" + ' (Copy)';
                    NewTemplate."Usage Count" := 0;
                    NewTemplate."Last Used Date" := 0DT;
                    NewTemplate."Approval Status" := NewTemplate."Approval Status"::Pending;
                    NewTemplate.Insert();
                    Message('Template duplicated with code: %1', NewCode);
                end;
            }
            
            action("Request Approval")
            {
                ApplicationArea = All;
                Caption = 'Request Approval';
                Image = Approval;
                ToolTip = 'Submit this template for approval.';
                Enabled = ApprovalActionEnabled;
                
                trigger OnAction()
                begin
                    if Rec."Approval Status" = Rec."Approval Status"::Pending then begin
                        Rec."Approval Status" := Rec."Approval Status"::"Pending Review";
                        Rec.Modify();
                        Message('Template submitted for approval.');
                    end;
                end;
            }
            
            action("Approve Template")
            {
                ApplicationArea = All;
                Caption = 'Approve Template';
                Image = Approve;
                ToolTip = 'Approve this marketing template.';
                Enabled = CanApprove;
                
                trigger OnAction()
                begin
                    if Confirm('Approve template "%1"?', true, Rec."Template Name") then begin
                        Rec."Approval Status" := Rec."Approval Status"::Approved;
                        Rec."Approved By" := UserId;
                        Rec."Approved Date" := CurrentDateTime;
                        Rec.Modify();
                        Message('Template approved successfully.');
                    end;
                end;
            }
        }
        
        area(creation)
        {
            action("New Template")
            {
                ApplicationArea = All;
                Caption = 'New Template';
                Image = New;
                ToolTip = 'Create a new marketing template.';
                RunObject = Page "CRM Marketing Template Card";
                RunPageMode = Create;
            }
        }
        
        area(reporting)
        {
            action("Template Usage Report")
            {
                ApplicationArea = All;
                Caption = 'Template Usage Report';
                Image = Report;
                ToolTip = 'Generate template usage analytics report.';
                
                trigger OnAction()
                begin
                    Message('Template usage report would be generated here.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetApprovalStatusStyle();
        SetActionVisibility();
    end;

    local procedure SetApprovalStatusStyle()
    begin
        case Rec."Approval Status" of
            Rec."Approval Status"::Pending:
                ApprovalStatusStyle := 'Standard';
            Rec."Approval Status"::"Pending Review":
                ApprovalStatusStyle := 'Attention';
            Rec."Approval Status"::Approved:
                ApprovalStatusStyle := 'Favorable';
            Rec."Approval Status"::Rejected:
                ApprovalStatusStyle := 'Unfavorable';
            else
                ApprovalStatusStyle := 'Standard';
        end;
    end;

    local procedure SetActionVisibility()
    begin
        ApprovalActionEnabled := (Rec."Approval Status" = Rec."Approval Status"::Pending) and Rec."Approval Required";
        CanApprove := (Rec."Approval Status" = Rec."Approval Status"::"Pending Review") and (Rec."Created By" <> UserId);
    end;

    var
        ApprovalStatusStyle: Text;
        ApprovalActionEnabled: Boolean;
        CanApprove: Boolean;
}