page 51466 "POS Setup"
{
    PageType = Card;
    SourceTable = "POS Setup";
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt No. field.';
                }
                field("Pos Items Series"; Rec."Pos Items Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pos Items Series field.';
                }
                field("Sales No."; Rec."Sales No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales No. field.';
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Stock Adjustment"; Rec."Stock Adjustment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stock Adjustment field.';
                }
                field("Bank Account"; Rec."Students Cashbook")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Account field.';
                }
                field("Sales Acount"; Rec."Students Sales Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Acount field.';
                }
                field("Staff Cashbook"; Rec."Staff Cashbook")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Cashbook field.';
                }
                field("Staff Sales Account"; Rec."Staff Sales Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Sales Account field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic, Suite;
                }
            }

        }
    }
}