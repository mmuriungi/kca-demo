page 51172 "PRL-Shot Listing Creteria"
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
                }
                field("Job Description"; Rec."Job Description")
                {
                }
                field("Total Score"; Rec."Total Score")
                {
                }
                field("Stage filter"; Rec."Stage filter")
                {
                    Caption = 'Recruitment Stage filter';
                }
            }
            part(Control1000000008; "PRL-Short Listing Lines")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
        }
    }

    actions
    {
    }
}

