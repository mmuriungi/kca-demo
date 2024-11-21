page 52084 "Exam Paper Submission"
{
    ApplicationArea = All;
    Caption = 'Exam Paper Submission';
    PageType = List;
    SourceTable = "Unit Exam Paper Submission";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ToolTip = 'Specifies the value of the Programme Code field.', Comment = '%';
                }
                field("Programme Name"; Rec."Programme Name")
                {
                    ToolTip = 'Specifies the value of the Programme Name field.', Comment = '%';
                }
                field("Programme Option"; Rec."Programme Option")
                {
                    ToolTip = 'Specifies the value of the Programme Option field.', Comment = '%';
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ToolTip = 'Specifies the value of the Stage Code field.', Comment = '%';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Unit Code field.', Comment = '%';
                }
                field(Desription; Rec.Desription)
                {
                    ToolTip = 'Specifies the value of the Desription field.', Comment = '%';
                }
                field("Attachment Exists"; Rec."Attachment Exists")
                {
                    ToolTip = 'Specifies the value of the Attachment Exists field.', Comment = '%';
                }
                field("Lecture No."; Rec."Coordinator No.")
                {
                    ToolTip = 'Specifies the value of the Lecture No. field.', Comment = '%';
                }
                field("Lecture Name"; Rec."Coordinator Name")
                {
                    ToolTip = 'Specifies the value of the Lecture Name field.', Comment = '%';
                }

                field("Submission Date"; Rec."Submission Date")
                {
                    ToolTip = 'Specifies the value of the Submission Date field.', Comment = '%';
                }
                field("Submission Time"; Rec."Submission Time")
                {
                    ToolTip = 'Specifies the value of the Submission Time field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            }
        }
    }
}
