page 55409 "Audit Assessmnt Review List"
{
    CardPageID = "Audit Assessnt Review card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Audit Asssessment Header";
    SourceTableView = WHERE(Status = FILTER(Review));

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

