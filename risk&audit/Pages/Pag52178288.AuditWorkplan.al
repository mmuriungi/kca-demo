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
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Audit Period"; Rec."Audit Period")
                {
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("General Objective"; Rec."General Objective")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

            }
            part("WorkPlan Objectives"; "WorkPlan Objectives")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
            part("WorkPlan Favorable"; "WorkPlan Favorable")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
            field(Unfavorable; Rec.Unfavorable)
            {
                MultiLine = true;
                ApplicationArea = All;
            }
            part("WorkPlan Recommendation"; "WorkPlan Recommendation ")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
            field("Auditee Comments"; Rec."Auditee Comments")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            part("Auditee Team"; "Auditee Team")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control18; Links)
            {
                ApplicationArea = All;
            }
            systempart(Control17; Notes)
            {
                ApplicationArea = All;
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

