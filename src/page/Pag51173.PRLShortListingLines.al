page 51173 "PRL-Short Listing Lines"
{
    AutoSplitKey = false;
    PageType = ListPart;
    SourceTable = "HRM-Shortlisting creteria";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Qualification Type"; Rec."Qualification Type")
                {
                }
                field(Requirements; Rec.Requirements)
                {
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Score; Rec.Score)
                {
                    Caption = 'Desired Score';
                }
                field("Desired Score"; Rec."Desired Score")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

