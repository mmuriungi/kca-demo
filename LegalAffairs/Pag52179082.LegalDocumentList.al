page 52179082 "Legal Document List"
{
    PageType = List;
    SourceTable = "Legal Document";
    Caption = 'Legal Document List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Legal Document Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number.';
                }
                field("Document Title"; Rec."Document Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document title.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document type.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document date.';
                }
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related case number.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related contract number.';
                }
                field("Access Level"; Rec."Access Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document access level.';
                    StyleExpr = AccessLevelStyle;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approval status.';
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document expiry date.';
                    StyleExpr = ExpiryStyle;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the version number.';
                }
                field("Is Latest Version"; Rec."Is Latest Version")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this is the latest version.';
                }
                field("Filed By"; Rec."Filed By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who filed the document.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("New Document")
            {
                ApplicationArea = All;
                Caption = 'New Document';
                Image = New;
                ToolTip = 'Create a new legal document.';
                RunPageMode = Create;
                RunObject = page "Legal Document Card";
            }
            action("View Document")
            {
                ApplicationArea = All;
                Caption = 'View Document';
                Image = View;
                ToolTip = 'View the document file.';
                
                trigger OnAction()
                begin
                    Message('Document viewing functionality would be implemented here for: %1', Rec."File Name");
                end;
            }
            action("Download Document")
            {
                ApplicationArea = All;
                Caption = 'Download Document';
                Image = Export;
                ToolTip = 'Download the document file.';
                
                trigger OnAction()
                begin
                    Message('Document download functionality would be implemented here for: %1', Rec."File Name");
                end;
            }
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;
    
    local procedure SetStyles()
    begin
        AccessLevelStyle := 'Standard';
        ExpiryStyle := 'Standard';
        
        case Rec."Access Level" of
            Rec."Access Level"::Confidential, Rec."Access Level"::"Highly Confidential":
                AccessLevelStyle := 'Attention';
        end;
        
        if (Rec."Expiry Date" <> 0D) and (Rec."Expiry Date" <= Today + 30) then
            ExpiryStyle := 'Unfavorable';
    end;
    
    var
        AccessLevelStyle: Text;
        ExpiryStyle: Text;
}