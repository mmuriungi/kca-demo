page 51848 "ACA-Student Profile"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
        }
    }

    actions
    {
        area(processing)
        {
            action("Student Login")
            {
                Image = Lock;
                InFooterBar = true;
                RunObject = Page "ACA-Student Password";
                ApplicationArea = All;
            }
            separator(__)
            {
            }
            separator(Login)
            {
            }
            action("Staff Login")
            {
                Image = Lock;
                RunObject = Page "ACA-Staff Password";
                ApplicationArea = All;
            }
        }
        area(creation)
        {
            separator(Form)
            {
            }
            action("Application Form")
            {
                Image = New;
                RunObject = Page "ACA-Application Form Header";
                ApplicationArea = All;
            }
        }
    }
}

