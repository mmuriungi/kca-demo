page 51025 "DRE extension Request"
{
    Caption = 'DRE extension Request';
    PageType = Card;
    SourceTable = "Extension Services";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Requested Date"; Rec."Requested Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Date field.', Comment = '%';
                }
                field("Requested Staff ID"; Rec."Requested Staff ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Staff ID field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Faculty; Rec.Faculty)
                {
                    ApplicationArea = All;
                }
                field("Service Requested"; Rec."Service Requested")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Requested field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
            part(extensionLinw; ExtensionLines)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Attachments1)
            {
                ApplicationArea = All;
                Caption = 'Attendance List/Trainning Material';

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    DocumentAttachment: Page "Document Attachment Custom";
                begin
                    Clear(DocumentAttachment);
                    RecRef.GETTABLE(Rec);
                    DocumentAttachment.OpenForRecReference(RecRef);
                    DocumentAttachment.RUNMODAL;
                end;
            }
        }
    }
}
