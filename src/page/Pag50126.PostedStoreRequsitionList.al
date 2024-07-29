page 50126 "Posted Store Requsition List"
{
    ApplicationArea = All;
    Caption = 'Posted Store Requsition List';
    PageType = List;
    CardPageId = "Posted Store Requisition";
    SourceTable = "PROC-Store Requistion Header";
    UsageCategory = History;
    SourceTableView = WHERE(Status = FILTER(Posted));
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Issue Date"; Rec."Issue Date")
                {
                    ToolTip = 'Specifies the value of the Issue Date field.';
                    ApplicationArea = All;
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                    ToolTip = 'Specifies the value of the Issuing Store field.';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Request Description"; Rec."Request Description")
                {
                    ToolTip = 'Specifies the value of the Request Description field.';
                    ApplicationArea = All;
                }
                field("Request date"; Rec."Request date")
                {
                    ToolTip = 'Specifies the value of the Request date field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
