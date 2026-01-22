page 51499 "Transport Approval Setup"
{
    PageType = Worksheet;
    SourceTable = "Transport Approval Setup";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Head of Department/Section"; Rec."Head of Department")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Head of Department field.';
                }
                field("Registrar VC"; Rec."Registrar VC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Officer field.';
                }
                field(" Head Of Transport"; Rec."Head Of Transport")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registrar HRM field.';
                }
            }
        }
    }
}