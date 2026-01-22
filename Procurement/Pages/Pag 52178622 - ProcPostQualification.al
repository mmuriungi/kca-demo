page 52178622 "Proc-Post Qualification"
{
    Caption = 'Proc-Post Qualification';
    PageType = Card;
    SourceTable = "Proc-Post Qualification";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement Method field.';
                }
                field("Date Conducted"; Rec."Date Conducted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Conducted field.';
                }
            }
            group(Brief)
            {

                field(Findings; Rec.Findings)
                {
                    ShowCaption = false;
                    MultiLine = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Findings field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Attachments")
            {
                ApplicationArea = all;

                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    RecRef: RecordRef;
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
    }
}
