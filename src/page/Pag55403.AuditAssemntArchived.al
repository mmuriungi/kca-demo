page 55403 "Audit Assemnt Archived"
{
    CardPageID = "Audit Assesmnt Archived Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Audit Asssessment Header";
    SourceTableView = WHERE(Status = CONST(Completed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field(Scope; Rec.Scope)
                {
                    ApplicationArea = All;
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                }
                field("Assessment Start Date"; Rec."Assessment Start Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

