page 52178621 "Proc-Intention To Award"
{
    Caption = 'Proc-Intention To Award';
    PageType = Card;
    SourceTable = "Proc-Intention To Award";
    PromotedActionCategories = 'New,Process,Report,Attachments,Send Mails';
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
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement Method field.';
                }
                field("Bidder No"; Rec."Bidder No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bidder No field.';
                }
                field("Supplier No"; Rec."Supplier No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier No field.';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field.';
                }
                field("Supplier Email"; Rec."Supplier Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Email field.';
                }
                field("Standstill End"; Rec."Standstill End")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Standstill End field.';
                }
                field("Tender Amount"; Rec."Tender Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Amount field.';
                }
            }
            group("Tenderer's Representative")
            {

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No field.';
                }
            }
            part("Recommended Bidder(s)"; "Proc Bidder Quoted Amounts")
            {
                ApplicationArea = all;
                SubPageLink = "Document No" = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Intention To Award Report")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    Pheader: Record "Purchase Header";
                begin
                    Pheader.Reset();
                    Pheader.SetRange("Request for Quote No.", rec."No.");
                    report.run(report::"Intention To Award", True, True, Pheader)
                end;
            }
            action("Regret Letter")
            {
                ApplicationArea = all;
                Image = ViewOrder;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    Pheader: Record "Purchase Header";
                begin
                    Pheader.Reset();
                    Pheader.SetRange("Request for Quote No.", rec."No.");
                    report.run(report::"Regret Letter", True, True, Pheader)
                end;
            }
            action("Attachments")
            {
                ApplicationArea = all;

                Image = Attach;
                Promoted = true;
                PromotedCategory = category4;
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
            action("Send Intention To Award")
            {
                ApplicationArea = all;
                Image = SendEmailPDF;
                Promoted = true;
                PromotedCategory = category5;
                trigger OnAction()
                begin
                    ProcProcess.SendIntentionToAwardAttachemnt(rec."No.");
                end;
            }
            action("Send Regret Letters")
            {
                ApplicationArea = all;
                Image = SendEmailPDF;
                Promoted = true;
                PromotedCategory = category5;
                trigger OnAction()
                begin
                    ProcProcess.SendRegretLetterAttachemnt(REC."No.");
                end;
            }
        }
    }
    var

        ProcProcess: Codeunit "Procurement Process";
}
