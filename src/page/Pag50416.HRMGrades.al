page 50416 "HRM-Grades"
{
    PageType = Worksheet;
    SourceTable = "HRM-Grades";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Grade; Rec.Grade)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Annual Leave Days"; Rec."Annual Leave Days")
                {
                }
            }
        }
    }

    actions
    {
    }
}

