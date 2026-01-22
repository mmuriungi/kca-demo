page 51612 "Merged Request Lines"
{
    Caption = 'Merged Request Lines';
    PageType = ListPart;
    SourceTable = "Merged Requisitions";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transport Req"; Rec."Transport Req")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Req field.', Comment = '%';
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Request field.', Comment = '%';
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination field.', Comment = '%';
                }
                field("Duration to be Away"; Rec."Duration to be Away")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration to be Away field.', Comment = '%';
                }
                field("Number of Passenger"; Rec."Number of Passenger")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number of Passenger field.', Comment = '%';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested By field.', Comment = '%';
                }
            }
        }
    }
}
