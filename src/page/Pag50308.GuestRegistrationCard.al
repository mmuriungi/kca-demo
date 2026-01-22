// Page: Guest Registration Card
page 50308 "Guest Registration Card"
{
    PageType = Card;
    SourceTable = "Guest Registration";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Visitor Name"; Rec."Visitor Name")
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID No field.', Comment = '%';
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No field.', Comment = '%';
                }

                field("Reason for Visit"; Rec."Reason for Visit")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = All;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Plate Number"; Rec."Vehicle Plate Number")
                {
                    ApplicationArea = All;
                }
                field("Is Staff"; Rec."Is Staff")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
