page 52179104 "Legal Document Card"
{
    PageType = Card;
    SourceTable = "Legal Document";
    Caption = 'Legal Document Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document description.';
                    MultiLine = true;
                }
                field(Keywords; Rec.Keywords)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies keywords for searching.';
                }
            }
            
            group("Document Information")
            {
                Caption = 'Document Information';
                
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document date.';
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document expiry date.';
                }
                field("Review Date"; Rec."Review Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the review date.';
                }
                field("Reviewed By"; Rec."Reviewed By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who reviewed the document.';
                }
            }
            
            group("File Information")
            {
                Caption = 'File Information';
                
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the file name.';
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the file extension.';
                }
                field("File Size (KB)"; Rec."File Size (KB)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the file size in KB.';
                }
                field("File Path"; Rec."File Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the file path.';
                }
            }
            
            group("Version Control")
            {
                Caption = 'Version Control';
                
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
                field("Previous Version No."; Rec."Previous Version No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the previous version number.';
                }
            }
            
            group("Access Control")
            {
                Caption = 'Access Control';
                
                field("Access Level"; Rec."Access Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document access level.';
                }
                field("Is View Only"; Rec."Is View Only")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the document is view only.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approval status.';
                }
            }
            
            group(References)
            {
                Caption = 'References';
                
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
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Filed By"; Rec."Filed By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who filed the document.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the record.';
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was created.';
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who last modified the record.';
                    Editable = false;
                }
                field("Date Modified"; Rec."Date Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was last modified.';
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("View Document")
            {
                ApplicationArea = All;
                Caption = 'View Document';
                Image = View;
                ToolTip = 'View the document file.';
                
                trigger OnAction()
                begin
                    ViewDocument();
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
                    DownloadDocument();
                end;
            }
            action("Upload New Version")
            {
                ApplicationArea = All;
                Caption = 'Upload New Version';
                Image = Import;
                ToolTip = 'Upload a new version of this document.';
                
                trigger OnAction()
                begin
                    UploadNewVersion();
                end;
            }
            action("Approve Document")
            {
                ApplicationArea = All;
                Caption = 'Approve Document';
                Image = Approve;
                ToolTip = 'Approve this document.';
                
                trigger OnAction()
                begin
                    Rec."Approval Status" := Rec."Approval Status"::Approved;
                    Rec.Modify(true);
                    CurrPage.Update();
                    Message('Document %1 has been approved.', Rec."Document No.");
                end;
            }
        }
    }
    
    local procedure ViewDocument()
    begin
        Message('Document viewing functionality would be implemented here for: %1', Rec."File Name");
    end;
    
    local procedure DownloadDocument()
    begin
        Message('Document download functionality would be implemented here for: %1', Rec."File Name");
    end;
    
    local procedure UploadNewVersion()
    begin
        Message('New version upload functionality would be implemented here.');
    end;
}