page 55404 "Audit Assesmnt Archived Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Audit Asssessment Header";
    SourceTableView = WHERE(Status = CONST(Completed));

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                /*  field(Department; Rec.Department)
                 {
                 } */
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                }
                field(Scope; Rec.Scope)
                {
                    ApplicationArea = All;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = All;
                }
                field("Ext. Document No"; Rec."Ext. Document No")
                {
                    ApplicationArea = All;
                }
                field("Current Location"; Rec."Current Location")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Modified on"; Rec."Modified on")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Assessment Start Date"; Rec."Assessment Start Date")
                {
                    ApplicationArea = All;
                }
                field("Assessment End Date"; Rec."Assessment End Date")
                {
                    ApplicationArea = All;
                }
                /* field(Asessor; Asessor)
                {
                } */
                field("Assessor Name"; Rec."Assessor Name")
                {
                    ApplicationArea = All;
                }
                field("Re-Assign Assessor"; Rec."Re-Assign Assessor")
                {
                    ApplicationArea = All;
                }
                field("Re-Assign Assessor Name"; Rec."Re-Assign Assessor Name")
                {
                    ApplicationArea = All;
                }
            }
            part("Risk Observations/Findings"; "Audit Assessment Findings")
            {
                ApplicationArea = All;
                //SubPageLink = "Risk Assessment Code"=FIELD(No);
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Attached Documents")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 1173;
                RunPageLink = "No." = FIELD(No);
                ApplicationArea = All;
            }
        }
    }
}

