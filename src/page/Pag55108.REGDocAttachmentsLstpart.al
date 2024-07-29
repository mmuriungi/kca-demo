page 55108 "REG-DocAttachmentsLstpart"
{
    Caption = 'Document Attachments';
    PageType = ListPart;
    SourceTable = "REG-Doc Attachment";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Folio Number"; Rec."Folio Number")
                {
                    ToolTip = 'Specifies the value of the Folio Number field.';
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the filename of the attachment.';
                    ApplicationArea = All;
                }
                field("Attached By"; Rec."Attached By")
                {
                    ToolTip = 'Specifies the value of the Attached By field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    ToolTip = 'Specifies the date when the document was attached.';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}
