page 50183 "Audit Workplan"
{
    PageType = Card;
    SourceTable = "Audit Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Audit Period"; Rec."Audit Period")
                {
                }
                field(Period; Rec.Period)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
                field("General Objective"; Rec."General Objective")
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
            field(Unfavorable; Rec.Unfavorable)
            {
                MultiLine = true;
                ApplicationArea = All;
            }
            part("WorkPlan Recommendation"; "WorkPlan Recommendation ")
            {
                SubPageLink = "No." = field("No.");
            }
            field("Auditee Comments"; Rec."Auditee Comments")
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
        Rec.Type := Rec.Type::"Audit WorkPlan";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit WorkPlan";
    end;
}

