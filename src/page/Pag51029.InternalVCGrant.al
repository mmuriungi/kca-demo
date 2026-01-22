page 51029 "Internal VC Grant"
{
    Caption = 'Internal VC Grant';
    PageType = Card;
    SourceTable = "Internal Vc Grants";

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
                field("PF No."; Rec."PF No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PF No. field.', Comment = '%';
                }
                field("Date Requested"; Rec."Date Requested")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Requested field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Faculty; Rec.Faculty)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Faculty field.', Comment = '%';
                }
                field("Name of Researcher"; Rec."Name of Researcher")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name of Researcher field.', Comment = '%';
                }
                field("Research Title"; Rec."Research Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Research Title field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }

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
                Caption = 'Meeting Minutes(Other Attachments)';

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
