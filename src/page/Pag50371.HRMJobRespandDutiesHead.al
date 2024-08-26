page 50371 "HRM-Job Resp. and Duties Head"
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
                field("Job ID"; Rec."Job ID")
                {
                    Editable = false;
                }
                field("Job Description"; Rec."Job Description")
                {
                    Editable = false;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    Enabled = false;
                }
                part(Control1000000008; "HRM-Job Resp./Duties Lines")
                {
                    SubPageLink = "Job ID" = FIELD("Job ID");
                }
            }
        }
    }

    actions
    {
    }
}

