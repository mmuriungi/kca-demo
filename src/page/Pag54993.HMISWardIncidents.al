page 54993 "HMIS Ward Incidents"
{
    PageType = List;
    SourceTable = "Ward Incidents Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incident No."; Rec."Incident No.")
                {
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ward Block No."; Rec."Ward Block No.")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Day/Night"; Rec."Day/Night")
                {
                    ApplicationArea = All;
                }
                field("Report Summary"; Rec."Report Summary")
                {
                    ApplicationArea = All;
                }
                field("Report Details"; Rec."Report Details")
                {
                    ApplicationArea = All;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    ApplicationArea = All;
                }
                field("Incident Time"; Rec."Incident Time")
                {
                    ApplicationArea = All;
                }
                field("Report By"; Rec."Report By")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

