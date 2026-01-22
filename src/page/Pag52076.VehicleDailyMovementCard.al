page 52076 "Vehicle Daily Movement Card"
{
    ApplicationArea = All;
    Caption = 'Vehicle Daily Movement Card';
    PageType = Card;
    SourceTable = "Vehicle Daily Movement";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Date"; Rec."Date Out")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.', Comment = '%';
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.', Comment = '%';
                }
                field("Time Out"; Rec."Time Out")
                {
                    ToolTip = 'Specifies the value of the Time Out field.', Comment = '%';
                }
                field("Milage Out"; Rec."Milage Out")
                {
                    ToolTip = 'Specifies the value of the Milage Out field.', Comment = '%';
                }
                field("Time In"; Rec."Time In")
                {
                    ToolTip = 'Specifies the value of the Time In field.', Comment = '%';
                }
                field("Milage In"; Rec."Milage In")
                {
                    ToolTip = 'Specifies the value of the Milage In field.', Comment = '%';
                }
                field("Drivers Name"; Rec."Drivers Name")
                {
                    ToolTip = 'Specifies the value of the Drivers Name field.', Comment = '%';
                }
                field("Gate Officer"; Rec."Gate Officer")
                {
                    ToolTip = 'Specifies the value of the Gate Officer field.', Comment = '%';
                }
            }
        }
    }
}
