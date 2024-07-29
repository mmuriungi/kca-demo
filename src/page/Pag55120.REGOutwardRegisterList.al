page 55120 "REG-Outward Register List"
{
    Caption = 'REG-Outward Register Card';
    PageType = List;
    SourceTable = "Outward Register B";
    CardPageId = "REG-Outward Register B";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                    ApplicationArea = All;
                }
                field("From File Index"; Rec."From File Index")
                {
                    ToolTip = 'Specifies the value of the From File Index field.';
                    ApplicationArea = All;
                }
                field("From File Name"; Rec."From File Name")
                {
                    ToolTip = 'Specifies the value of the From File Name field.';
                    ApplicationArea = All;
                }
                field("To Who"; Rec."To Who")
                {
                    ToolTip = 'Specifies the value of the To Who field.';
                    ApplicationArea = All;
                }
                field("File Index"; Rec."File Index")
                {
                    ToolTip = 'Specifies the value of the File Index field.';
                    ApplicationArea = All;
                    Caption = 'File To';
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the File Name field.';
                    ApplicationArea = All;
                }
                field("Date Sent"; Rec."Date Sent")
                {
                    ToolTip = 'Specifies the value of the Date Sent field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(EDMS)
            {
                ApplicationArea = All;
                Caption = 'Attach Folio';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                RunObject = Page "REG-Doc Attach Details";
                RunPageLink = "No." = field("File Index"), Closed = const(false), Archived = const(false);
            }
        }
    }
}
