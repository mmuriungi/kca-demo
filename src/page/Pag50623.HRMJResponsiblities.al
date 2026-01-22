page 50623 "HRM-J. Responsiblities"
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
            }
            part(KPA; "HRM-Job Responsiblities")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
            field(Control1000000006; '')
            {
                CaptionClass = Text19035248;
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
        Text19035248: Label 'Key Responsibilities';
}

