page 51217 "HRM-Employee Categories List"
{
    PageType = List;
    SourceTable = "HRM-Employee Categories";
    Caption = 'HRM-Employee Categories List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Section; Rec.Section)
                {
                }
            }
        }
    }

    actions
    {
    }
}

