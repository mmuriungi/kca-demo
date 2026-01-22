page 51588 "Trip Schedule Card"
{
    Caption = 'Trip Schedule Card';
    PageType = Card;
    SourceTable = "Trip Schedule";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    Editable = false;
                }
                field("Transport Requisition No."; Rec."Transport Requisition No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Requisition No. field.';
                }
                field("Vehicle Reg No"; Rec."Vehicle Reg No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Reg No field.';
                }
                field("Driver Code "; Rec."Driver Code ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Code field.';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Destination field.';
                }
                field("No Of Days"; Rec."No Of Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No Of Days field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DSA Amount field.';
                    Caption = 'DSA Amount';
                }
                field("Fuel Amount"; Rec."Fuel Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fuel Amount field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created Date field.';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("View Transport Requisition")
            {
                Caption = 'View Transport Requisition';
                Image = ViewSourceDocumentLine;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TransportReq: Record "FLT-Transport Requisition";
                begin
                    if TransportReq.Get(Rec."Transport Requisition No.") then
                        PAGE.Run(PAGE::"FLT-Transport Req.", TransportReq);
                end;
            }
            action(Attachments2)
            {
                ApplicationArea = All;
                Caption = 'Applicant Attachments';
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;

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
