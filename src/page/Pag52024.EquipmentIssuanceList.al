page 52024 "Equipment Issuance List"
{
    ApplicationArea = All;
    Caption = 'Equipment Issuance List';
    PageType = List;
    SourceTable = "Equipment Issuance";
    CardPageId = "Equipment Issuance";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.', Comment = '%';
                }
                field("Game Code"; Rec."Game Code")
                {
                    ToolTip = 'Specifies the value of the Game Code field.', Comment = '%';
                }
                field("Game Name"; Rec."Game Name")
                {
                    ToolTip = 'Specifies the value of the Game Name field.', Comment = '%';
                }
                field("Receipient No."; Rec."Receipient No.")
                {
                    ToolTip = 'Specifies the value of the Receipient No. field.', Comment = '%';
                }
                field("Receipient Name"; Rec."Receipient Name")
                {
                    ToolTip = 'Specifies the value of the Receipient Name field.', Comment = '%';
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ToolTip = 'Specifies the value of the Issue Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Return Date"; Rec."Return Date")
                {
                    ToolTip = 'Specifies the value of the Return Date field.', Comment = '%';
                }
                field("User Type"; Rec."User Type")
                {
                    ToolTip = 'Specifies the value of the User Type field.', Comment = '%';
                }
            }
        }
    }
}
