#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 78023 "ACA-Special Exams Reasons"
{
    PageType = List;
    SourceTable = "ACA-Special Exams Reason";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Reason Code";Rec."Reason Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }
}

