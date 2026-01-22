page 52178542 "Proc-Opening Commitee"
{

    PageType = ListPart;
    SourceTable = "Proc-Committee Membership";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;
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

                field("Opening Confirmed"; Rec."Opening Confirmed")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Opening Confirmed field.';
                }



            }
        }
    }
}