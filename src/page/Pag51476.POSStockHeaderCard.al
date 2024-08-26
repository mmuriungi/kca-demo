page 51476 "POS Stock Header Card"
{
    PageType = Card;
    SourceTable = "POS Stock Header";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(Content)
        {
            group(general)
            {
                Editable = false;

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
                field("Date and Time"; Rec."Date and Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date and Time field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }
            part("Quantity Line"; "POS Stock Lines")
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
                    Rec.postStock();
                    CurrPage.Close();
                end;
            }
            action("Clear Stock")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = NewItemNonStock;
                trigger OnAction()
                begin
                    Rec.clearStock();
                    CurrPage.Close();
                end;
            }
        }
    }
}