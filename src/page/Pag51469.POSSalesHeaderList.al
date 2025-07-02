page 51469 "POS Sales Header List Legacy"
{
    PageType = List;
    SourceTable = "POS Sales Header Legacy";
    CardPageId = "POS Sales Header Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = order(descending);

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
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Description field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cashier field.';
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