page 54431 "Chairman Assesment Card"
{
    Caption = 'Chairman Assesment Card';
    PageType = Card;
    SourceTable = "Complaint Affair";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field("Complaint Date"; Rec."Complaint Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Complaint Date field.';
                }
                field("Complaint Origin"; Rec."Complaint Origin")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Complaint Origin field.';
                }
                field("Complaint Status"; Rec."Complaint Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Complaint Status field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Chairman Comments"; Rec."Chairman Comments")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Chairman Comments field.';
                }
                // field("Divison Comments"; Rec."Divison Comments")
                // {
                //     ApplicationArea = All;
                //     MultiLine = true;
                //     ToolTip = 'Specifies the value of the Divison Comments field.';
                // }
                field(Incharge; Rec.Incharge)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incharge field.';
                }
                field("Complainant Channel"; Rec."Complainant Channel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Complainant Channel field.';
                }
                field("Complainant Contact"; Rec."Complainant Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Complainant Contact field.';
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Complaint Document Attachemnt';
                SubPageLink = "Table ID" = CONST(52429),
                              "No." = FIELD("No.");
            }
            systempart(Link; Links)
            {
                ApplicationArea = RecordLinks;
                Caption = 'Complaint Link';
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
                Caption = 'Complaint Notes';
            }
        }
    }
    actions
    {

        area(Processing)
        {
            group(Process)
            {
                action("Send To Committiee")
                {
                    ApplicationArea = Suite;
                    Caption = 'Send To Committiee';
                    Image = SendEmailPDFNoAttach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send Notification To the committiee';
                    trigger OnAction()
                    var
                    // Committiee: Record "Committee Members Line";
                    begin
                        Rec.Incharge := Rec.Incharge::"Complaint Committiee";
                        Rec.Modify();
                        // Body := StrSubstNo('Dear Complaints Committiee  <br> Kindly review the complaint No. %1 in the system', Rec."No.");
                        // EmailMessage.Create(Recipients, 'Complaint Alert', Body, true);
                        // Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    end;
                }
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        //DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }

            }
        }

    }

    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Created By" := UserId;
        rec."Creation Date" := Today;
    end;

    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
}
