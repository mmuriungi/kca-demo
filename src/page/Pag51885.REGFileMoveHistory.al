page 51885 "REG-File Move History"
{
    ApplicationArea = All;
    Caption = 'REG-File Movement List';
    PageType = List;
    SourceTable = "REG-File Movement";
    UsageCategory = Administration;
    CardPageId = "REG-File Movement";
    SourceTableView = where("Folio Returned" = const(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("File Index"; Rec."File Index")
                {
                    ToolTip = 'Specifies the value of the File Index field.';
                    ApplicationArea = All;
                }
                field("Folio Number"; Rec."Folio Number")
                {
                    ToolTip = 'Specifies the value of the Folio Number field.';
                    ApplicationArea = All;
                }
                field("Send To"; Rec."Send To")
                {
                    ToolTip = 'Specifies the value of the Send To field.';
                    ApplicationArea = All;
                }
                field("Receiver Name"; Rec."Receiver Name")
                {
                    ToolTip = 'Specifies the value of the Receiver Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Date Sent"; Rec."Date Sent")
                {
                    ToolTip = 'Specifies the value of the Date Sent field.';
                    ApplicationArea = All;
                }
                field("Bring Up Date"; Rec."Bring Up Date")
                {
                    ToolTip = 'Specifies the value of the Bring Up Date field.';
                    ApplicationArea = All;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ToolTip = 'Specifies the value of the Return Date field.';
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                    ApplicationArea = All;
                }
                field("Folio Returned"; Rec."Folio Returned")
                {
                    ToolTip = 'Specifies the value of the Folio Returned field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("View File")
            {
                ApplicationArea = All;
                Caption = 'View Folio';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'View File, download, act on it, scan and upload back';

                RunObject = Page "REG-Doc Attach Details";

                RunPageLink = "No." = field("File Index");

                trigger OnAction()
                begin

                end;
            }
        }
    }
}
