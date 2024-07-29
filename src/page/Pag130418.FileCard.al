//was page 130418 "File Card"
page 55101 "File Card"
{
    PageType = Card;
    SourceTable = "File Cabinet";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Section Number"; Rec."Section Number")
                {
                    Caption = 'Section/Division';
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;

                }
                field(Abbrev; Rec.Abbrev)
                {
                    Caption = 'Abbreviation';
                    ApplicationArea = All;
                }
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;

                }
                field("File Subject"; Rec."File Subject")
                {
                    ApplicationArea = All;

                }
                field("File Index"; Rec."File Index")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(EDMS)
            {
                ApplicationArea = All;
                Caption = 'EDMS Documents';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page 1173;
                    RecRef: RecordRef;
                begin
                    RecRef.GETTABLE(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RUNMODAL;
                end;
            }
        }
    }
}

