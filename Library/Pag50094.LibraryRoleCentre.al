page 50094 "Library Role Centre"
{
    Caption = 'Library Role Centre';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control1904484608; "Library Activities")
            {
                Caption = 'Library Activities';
                ApplicationArea = All;
            }
            part(Control1907692008; "Library Patrons")
            {
                Caption = 'Library Patrons';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action("Library Students")
            {
                Caption = 'Library Students';
                Image = Customer;
                RunObject = Page "Library Student Card";
                ApplicationArea = All;
            }
            action("Library Staff")
            {
                Caption = 'Library Staff';
                Image = Employee;
                RunObject = Page "HRM-Employee List";
                ApplicationArea = All;
            }
            action("Koha Setup")
            {
                Caption = 'Koha Setup';
                Image = Setup;
                RunObject = Page "Koha Setup";
                ApplicationArea = All;
            }
            action("Library Books")
            {
                Caption = 'Library Books';
                Image = Item;
                RunObject = Page "Item List";
                ApplicationArea = All;
            }
        }
        area(processing)
        {
            group("Library Management")
            {
                Caption = 'Library Management';
                Image = Library;

                // action("Sync Students to Koha")
                // {
                //     Caption = 'Sync Students to Koha';
                //     Image = SynchronizeWithExchange;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     var
                //         Student: Record Customer;
                //         KohaHandler: Codeunit "Koha Handler";
                //     begin
                //         if Confirm('Do you want to sync all students to Koha?') then begin
                //             Student.Reset();
                //             Student.SetRange("Customer Type", Student."Customer Type"::Student);
                //             if Student.FindSet() then
                //                 repeat
                //                     KohaHandler.CreateStudentPatron(Student);
                //                 until Student.Next() = 0;
                //         end;
                //     end;
                // }
                // action("Sync Staff to Koha")
                // {
                //     Caption = 'Sync Staff to Koha';
                //     Image = SynchronizeWithExchange;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     var
                //         Employee: Record "HRM-Employee C";
                //         KohaHandler: Codeunit "Koha Handler";
                //     begin
                //         if Confirm('Do you want to sync all staff to Koha?') then begin
                //             Employee.Reset();
                //             if Employee.FindSet() then
                //                 repeat
                //                     KohaHandler.CreateStaffPatron(Employee);
                //                 until Employee.Next() = 0;
                //         end;
                //     end;
                // }
                action("Library Reports")
                {
                    Caption = 'Library Reports';
                    Image = Report;
                    ApplicationArea = All;
                }
            }
            group("Common Requisitions")
            {
                Caption = 'Common Requisitions';

                action("Stores Requisitions")
                {
                    Caption = 'Stores Requisitions';
                    ApplicationArea = All;
                    RunObject = Page "PROC-Store Requisition";
                }
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    ApplicationArea = All;
                    RunObject = Page "FIN-Imprests List";
                }
                action("Transport Requisition")
                {
                    Caption = 'Transport Requisition';
                    RunObject = Page "FLT-Transport Req. List";
                    ApplicationArea = All;
                }
            }
        }
    }
}

profile "Library"
{
    ProfileDescription = 'Library';
    RoleCenter = "Library Role Centre";
    Caption = 'Library Profile';
}
