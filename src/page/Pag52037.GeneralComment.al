page 52037 "General Comment"
{
    PageType = StandardDialog;



    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Comment; Comment)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        Comment: Text[250];

    procedure FnGetTerminationComment(): Text
    begin
        exit(Comment);
    end;
}