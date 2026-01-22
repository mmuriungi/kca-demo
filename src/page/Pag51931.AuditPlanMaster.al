page 51931 "Audit-Plan-Master"
{
    CardPageID = "Audit-Activity Card";
    PageType = List;
    SourceTable = "Audit-Activity";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Depart Code"; Rec."Depart Code")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Activities; Rec.Activities)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duration)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Budget; Rec.Budget)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Audit Planner")
            {
                Image = "Report";
                RunObject = Report "Audit Planner Report";
                ApplicationArea = All;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Created By" := USERID;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec."Created By" := USERID;
    end;
}

