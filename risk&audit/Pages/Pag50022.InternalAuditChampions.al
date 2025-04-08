page 50022 "Internal Audit Champions"
{
    Caption = 'Risk Champion';
    PageType = List;
    SourceTable = "Internal Audit Champions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                    Caption = 'Area';
                    ApplicationArea = Basic, Suite;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Escalator ID"; "Escalator ID")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

