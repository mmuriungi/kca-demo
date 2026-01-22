page 50626 "HRM-J. Specification"
{
    PageType = Document;
    SourceTable = "HRM-Company Jobs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("Job ID"; Rec."Job ID")
                {
                }
                field("Job Description"; Rec."Job Description")
                {
                }
                field("Total Score"; Rec."Total Score")
                {
                }
            }
            part(KPA; "HRM-Job Requirement Lines (B)")
            {
                SubPageLink = "Job Id" = FIELD("Job ID");
            }
            field(Control1000000006; '')
            {
                CaptionClass = Text19024070;
                ShowCaption = false;
                Style = Standard;
                StyleExpr = TRUE;
            }
        }
    }

    actions
    {
    }

    var
        Text19024070: Label 'Job Specification';
}

