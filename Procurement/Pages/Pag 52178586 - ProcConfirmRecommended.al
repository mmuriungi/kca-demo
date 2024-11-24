page 52178586 "Proc-Confirm Recommended"
{
    Caption = 'Evaluation Committee Confirmation';
    PageType = ListPart;
    SourceTable = "Proc-Confirm Recommended";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Telephone No."; Rec."Telephone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Telephone No. field.';
                }
                field(Recommendation; Rec.Recommendation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recommendation field.';
                }
                field(Confirmed; Rec.Confirmed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Confirmed field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Time Confirmed"; Rec."Time Confirmed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Confirmed field.';
                }
                field("View"; Rec."View")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the View field.';
                }
            }
        }
    }
}