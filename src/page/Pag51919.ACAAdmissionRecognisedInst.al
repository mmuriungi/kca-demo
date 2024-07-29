page 51919 "ACA-Admission Recognised Inst."
{
    PageType = List;
    SourceTable = "ACA-Admission Recognised Inst.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

