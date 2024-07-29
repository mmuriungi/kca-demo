page 51102 "HRM-Appraisal Emp. Categories"
{
    PageType = List;
    SourceTable = "HRM-Employee Category";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}

