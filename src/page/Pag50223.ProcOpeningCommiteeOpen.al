page 50223 "Proc-Opening Commitee.Open"
{

    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Proc-Committee Membership";
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
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field("Initiate Opening"; Rec."Initiate Opening")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Initiate Opening field.';
                }
                field("Opening Confirmed"; Rec."Opening Confirmed")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Opening Confirmed field.';
                }
                field("Date openned"; Rec."Date openned")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date openned field.';
                }
                field("Opening Time"; Rec."Opening Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Opening Time field.';
                }

            }
        }
    }
}