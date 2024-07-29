page 50121 "PROC-Procurement Plan list"
{
    CardPageID = "PROC-Procurement Plan Header";
    PageType = List;
    SourceTable = "PROC-Procurement Plan Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Budget Name"; Rec."Budget Name")
                {
                }
                field("Department Code"; Rec."Department Code")
                {
                }
                field(Project; Rec.Schools)
                {
                }
                field("Procurement Plan Period"; Rec."Procurement Plan Period")
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

