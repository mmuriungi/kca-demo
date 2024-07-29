page 51062 "HRM-Appraisal Goal Set. List"
{
    CardPageID = "HRM-Appraisal Goal Setting H";
    PageType = List;
    SourceTable = "HRM-Appraisal Goal Setting H";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Job Title"; Rec."Job Title")
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
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Appraisal Stage"; Rec."Appraisal Stage")
                {
                }
                field(Sent; Rec.Sent)
                {
                }
                field(Recommendations; Rec.Recommendations)
                {
                }
            }
        }
    }

    actions
    {
    }
}

