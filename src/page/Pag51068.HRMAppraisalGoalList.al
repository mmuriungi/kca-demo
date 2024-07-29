page 51068 "HRM-Appraisal Goal List"
{
    CardPageID = "HRM-Appraisal Goal (B)";
    PageType = List;
    SourceTable = "HRM-Appraisal Goal Setting H";
    SourceTableView = WHERE("Appraisal Stage" = CONST(EndYearEvaluation),
                            Status = CONST(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Supervisor; Rec.Supervisor)
                {
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    Editable = false;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
                field(Sent; Rec.Sent)
                {
                }
            }
        }
    }

    actions
    {
    }
}

