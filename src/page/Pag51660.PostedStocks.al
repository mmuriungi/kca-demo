page 51660 "Posted Stocks"
{
    PageType = List;
    SourceTable = "POS Stock Header";
    CardPageId = "POS Stock Header Card";
    SourceTableView = where(Posted = filter(true));
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }
        }
    }

}