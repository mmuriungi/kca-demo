page 52179025 "CRM Marketing Template Card"
{
    PageType = Card;
    Caption = 'Marketing Template Card';
    SourceTable = "CRM Marketing Template";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("General")
            {
                Caption = 'General';
                
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
            }
            
            group("Template Content")
            {
                Caption = 'Content';
                
                field("Subject"; Rec."Subject")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the subject line for this template.';
                }
                field("HTML Content"; Rec."HTML Content")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the content is in HTML format.';
                }
                field("Content Text"; ContentText)
                {
                    ApplicationArea = All;
                    Caption = 'Content';
                    ToolTip = 'The content of the marketing template.';
                    MultiLine = true;
                    
                    trigger OnValidate()
                    begin
                        Rec.SetContentFromText(ContentText);
                    end;
                }
                field("Personalization Fields"; Rec."Personalization Fields")
                {
                    ApplicationArea = All;
                    ToolTip = 'Comma-separated list of fields that can be personalized in this template.';
                    MultiLine = true;
                }
            }
            
            group("Settings")
            {
                Caption = 'Settings';
                
                field("Tags"; Rec."Tags")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tags to help categorize and search for this template.';
                }
                field("GDPR Compliant"; Rec."GDPR Compliant")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this template is GDPR compliant.';
                }
                field("Unsubscribe Link Required"; Rec."Unsubscribe Link Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether an unsubscribe link is required in this template.';
                }
                field("Approval Required"; Rec."Approval Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this template requires approval before use.';
                }
            }
            
            group("Approval")
            {
                Caption = 'Approval';
                
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the current approval status of this template.';
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who approved this template.';
                    Editable = false;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this template was approved.';
                    Editable = false;
                }
            }
            
            group("Usage Statistics")
            {
                Caption = 'Usage Statistics';
                
                field("Usage Count"; Rec."Usage Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows how many times this template has been used.';
                    Editable = false;
                }
                field("Last Used Date"; Rec."Last Used Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this template was last used.';
                    Editable = false;
                }
            }
            
            group("Audit")
            {
                Caption = 'Audit Information';
                
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who created this template.';
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this template was created.';
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who last modified this template.';
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this template was last modified.';
                    Editable = false;
                }
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Additional notes about this template.';
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Preview Template")
            {
                ApplicationArea = All;
                Caption = 'Preview';
                Image = View;
                ToolTip = 'Preview how this template will look.';
                
                trigger OnAction()
                begin
                    if ContentText <> '' then
                        Message('Template Preview:\n\nSubject: %1\n\nContent:\n%2', Rec.Subject, ContentText)
                    else
                        Message('Template content is empty.');
                end;
            }
            
            action("Test Send")
            {
                ApplicationArea = All;
                Caption = 'Test Send';
                Image = TestReport;
                ToolTip = 'Send a test version of this template.';
                
                trigger OnAction()
                begin
                    Message('Test send functionality would be implemented here.');
                end;
            }
            
            action("Request Approval")
            {
                ApplicationArea = All;
                Caption = 'Request Approval';
                Image = Approval;
                ToolTip = 'Submit this template for approval.';
                Enabled = (Rec."Approval Status" = Rec."Approval Status"::Pending) and Rec."Approval Required";
                
                trigger OnAction()
                begin
                    Rec."Approval Status" := Rec."Approval Status"::"Pending Review";
                    Rec.Modify();
                    Message('Template submitted for approval.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ContentText := Rec.GetContentAsText();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ContentText := '';
    end;

    var
        ContentText: Text;
}