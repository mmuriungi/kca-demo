page 50982 "HRM-Appraisal Formats"
{
    PageType = ListPart;
    SourceTable = "HRM-Appraisal Formats";
    SourceTableView = SORTING("Appraisal Code", Sequence)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field(Sequence; Rec.Sequence)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("In Put"; Rec."In Put")
                {
                }
                field("Entry By"; Rec."Entry By")
                {
                }
                field("After Entry Of Prev. Group"; Rec."After Entry Of Prev. Group")
                {
                }
                field("Allow Previous Groups Rights"; Rec."Allow Previous Groups Rights")
                {
                }
            }
        }
    }

    actions
    {
    }
}

