page 50155 "FIN-Asset Transfer List"
{
    ApplicationArea = All;
    Caption = 'Asset Transfer List';
    PageType = List;
    CardPageId = "FIN-Asset Transfer Card";
    SourceTable = "FIN-Asset Transfer Header";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Asset No"; Rec."Asset No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Asset No field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Current Location"; Rec."Current Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Location field.';
                }
                field("Current User"; Rec."Current User")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current User field.';
                }
                field("New User"; Rec."New User")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the New User field.';
                }
                field("Reason 2 for Transfer"; Rec."Reason 2 for Transfer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason 2 for Transfer field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        rec.SetFilter("Created By", '%1', UserId);
    end;
}
