page 51047 "HRM-Job Interview"
{
    PageType = List;
    SourceTable = "HRM-Job Interview";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interview Code"; Rec."Interview Code")
                {
                }
                field("Interview Description"; Rec."Interview Description")
                {
                }
                field(Score; Rec.Score)
                {
                }
                field("Total Score"; Rec."Total Score")
                {
                }
                field(comments; Rec.comments)
                {
                }
                field(Interviewer; Rec.Interviewer)
                {
                }
                field("Interviewer Name"; Rec."Interviewer Name")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicants)
            {
                Caption = 'Applicants';
                action("Hiring Criteria")
                {
                    Caption = 'Hiring Criteria';
                    Image = Agreement;
                    Promoted = true;
                    RunObject = Page "HRM-Hiring Criteria";
                    RunPageLink = "Application Code" = FIELD("Applicant No");
                }
            }
        }
    }
}

