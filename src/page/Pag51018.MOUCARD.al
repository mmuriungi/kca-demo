page 51018 "MOU CARD"
{
    Caption = 'MOU CARD';
    PageType = Card;
    SourceTable = "MOU lists";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(validity; Rec.validity)
                {
                    ApplicationArea = All;
                    Caption = 'Validity(In Years)';
                }
                field("MOU expiry Date"; Rec."MOU expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the MOU expiry Date field.';
                }
                field("Mou Description"; Rec."Mou Description")
                {
                    ApplicationArea = All;
                    Multiline = True;
                    ToolTip = 'Specifies the value of the Mou Description field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }

            }
            part(obj; "MoU Objectives")
            {
                SubPageLink = No = field(No);
                ApplicationArea = All;
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
                Caption = 'Attachments';

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
            action("MOU (JIC)")
            {
                ApplicationArea = All;
                RunObject = Page "MOU JIC";
                RunPageLink = No = field(No);
            }
        }
    }
}
