page 52178623 "Proc-Opening Minutes"
{
    Caption = 'Proc-Opening Minutes';
    PageType = Card;
    SourceTable = "Proc-Opening Minutes";

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
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Minutes No"; Rec."Minutes No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minutes No field.';
                }
            }
        }
    }
    actions
    {

        area(processing)
        {


            action("Attachment")
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
