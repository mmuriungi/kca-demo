page 51643 "Hostel Stock Header Card"
{
    Caption = 'Hostel Stock Header Card';
    PageType = Card;
    SourceTable = "Stock Hostel Header";
    RefreshOnActivate = true;
    // SourceTableView = where(Posted = filter(false));

    layout
    {
        area(Content)
        {
            group(general)
            {


                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Date and Time"; Rec."Date and Time")
                {
                    Editable = false;

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date and Time field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }
            part("Quantity Line"; "hostel Stock Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post Stock")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = NewItemNonStock;
                trigger OnAction()
                begin

                    rec.AdjustHostel()
                end;
            }
        }
    }
}