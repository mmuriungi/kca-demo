page 50029 "Auditee Review"
{
    CardPageID = "Audit Report Card";
    PageType = List;
    SourceTable = "Audit Header";
    SourceTableView = WHERE (Type = FILTER ("Audit Report"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field(Date; Date)
                {
                }
                field("Created By"; "Created By")
                {
                }
                field(Status; Status)
                {
                }
                field(Description; Description)
                {
                }
                field(Auditee; Auditee)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        SETRANGE(Auditee, USERID);
    end;
}

