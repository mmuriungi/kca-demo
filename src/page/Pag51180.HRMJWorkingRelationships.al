page 51180 "HRM-J. Working Relationships"
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
            part(KPA; "HRM-Job Working Relationships")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
            field(Control1000000006; '')
            {
                CaptionClass = Text19007263;
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
        Text19007263: Label 'Working Relationships';
}

