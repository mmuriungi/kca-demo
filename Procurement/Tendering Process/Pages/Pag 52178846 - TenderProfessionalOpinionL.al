page 52178846 "Tender Professional OpinionL"
{
    PageType = List;
    CardPageId = "Tender Professional OpinionC";
    SourceTable = "Tender Professional Opinion";
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Tender No"; Rec."Tender No")
                {
                    ToolTip = 'Specifies the value of the Tender No field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Opinion One"; Rec."Opinion One")
                {
                    ToolTip = 'Specifies the value of the Opinion One field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Opinion Two"; Rec."Opinion Two")
                {
                    ToolTip = 'Specifies the value of the Opinion Two field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Opinion Three"; Rec."Opinion Three")
                {
                    ToolTip = 'Specifies the value of the Opinion Three field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Opinion Four"; Rec."Opinion Four")
                {
                    ToolTip = 'Specifies the value of the Opinion Four field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Recommended Biddder"; Rec."Recommended Biddder")
                {
                    ToolTip = 'Specifies the value of the Recommended Biddder field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bid No."; Rec."Bid No.")
                {
                    ToolTip = 'Specifies the value of the Bid No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}