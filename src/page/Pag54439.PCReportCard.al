page 54439 "PC Report Card"
{
    Caption = 'PC Report Card';
    PageType = Card;
    SourceTable = "PC Reports";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Department; Rec.Department)
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Department Name"; Rec."Department Name")
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Incharge; Rec.Incharge)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incharge field.';
                    Editable = false;
                }
                field("Plan Year"; Rec."Plan Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Plan Year field.';
                }
                field(Quarter; Rec.Quarter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quarter field.';
                }

            }
        }



    }
    actions
    {
        area(Processing)
        {
            action("Upload File")
            {
                ApplicationArea = All;
                Promoted = true;
                Caption = 'Upload PC Report';
                PromotedCategory = Category8;
                Image = Attachments;
                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }

    }
}

