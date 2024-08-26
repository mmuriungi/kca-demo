page 50579 "HRM-Attachment Register"
{
    PageType = List;
    SourceTable = "HRM-Attachment Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Names; rec.Names)
                {
                }
                field(Institution; rec.Institution)
                {
                }
                field("Course/Level"; rec."Course/Level")
                {
                }
                field("Attachement Period"; rec."Attachement Period")
                {
                }
                field("Contract No"; rec."Contract No")
                {
                }
                field("Department Attached"; rec."Department Attached")
                {
                }
                field("Department Name"; rec."Department Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

