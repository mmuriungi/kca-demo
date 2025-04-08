page 52178288 "Audit Workplan"
{
    PageType = Card;
    SourceTable = "Audit Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                }
                field(Date; Date)
                {
                }
                field("Created By"; "Created By")
                {
                }
                field(Status; Status)
                {
                }
                field(Description; Description)
                {
                }
                field("No. Series"; "No. Series")
                {
                }
                field(Posted; Posted)
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Audit Period"; "Audit Period")
                {
                }
                field(Period; Period)
                {
                }
                field(Type; Type)
                {
                }
                field("Dimension Set ID"; "Dimension Set ID")
                {
                }
                field("General Objective"; "General Objective")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

            }
            part("WorkPlan Objectives"; "WorkPlan Objectives")
            {
                SubPageLink = "No." = field("No.");
            }
            part("WorkPlan Favorable"; "WorkPlan Favorable")
            {
                SubPageLink = "No." = field("No.");
            }
            field(Unfavorable; Unfavorable)
            {
                MultiLine = true;
                ApplicationArea = All;
            }
            part("WorkPlan Recommendation"; "WorkPlan Recommendation ")
            {
                SubPageLink = "No." = field("No.");
            }
            field("Auditee Comments"; "Auditee Comments")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            part("Auditee Team"; "Auditee Team")
            {
                SubPageLink = "No." = field("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control18; Links)
            {
            }
            systempart(Control17; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Type := Type::"Audit WorkPlan";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::"Audit WorkPlan";
    end;
}

