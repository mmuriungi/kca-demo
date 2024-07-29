page 54341 "POS Role Center"

{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part("POS Menu Items"; "POS Menu List")
            {
                Caption = 'Food Menu List';
                Visible = true;
                ApplicationArea = All;
            }
            group(Mitems)
            {

                // part("POS Adjustment"; "POS Stock Adjustments")
                // {
                //     Caption = 'Food Adjustment List';
                //     Visible = true;
                //     ApplicationArea = All;
                // }

            }
            group("Stock Adjustments")
            {

            }
            /* group("Transport")
            {
                part(HOD; "Approvals Activities One")
                {
                    ApplicationArea = Suite;
                }
            } */


        }

    }

    actions
    {
        area(Processing)
        {
            group(Sales)
            {
                action("Students Sales")
                {
                    AccessByPermission = TableData "POS Sales Header" = IMD;
                    ApplicationArea = Basic, suite;
                    Image = ExportMessage;
                    ShortcutKey = 'F7';
                    RunObject = Page "POS Sales Student Card";
                    RunPageMode = Create;
                }
                action("Staff Sales")
                {
                    AccessByPermission = TableData "POS Sales Header" = IMD;
                    ApplicationArea = Basic, suite;
                    Image = ExportMessage;
                    ShortcutKey = 'F9';
                    RunObject = Page "POS Sales Staff";
                    RunPageMode = Create;
                }
            }
        }
        area(Sections)
        {
            group("POS Sales")
            {
                // action("POS Setup")
                // {
                //     ApplicationArea = All;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     Image = SetupPayment;
                //     RunObject = Page "POS Setup";
                // }
                action("POS Items")
                {
                    ApplicationArea = All;
                    Image = SalesInvoice;
                    RunObject = Page "POS Items";
                }
                /* action("Stock Adjuctment")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = AdjustEntries;
                    RunObject = Page "POS Stock Header List";
                } */
                action("POSSales")
                {
                    Caption = 'POS Sales';
                    ApplicationArea = All;
                    Image = PostedPayment;
                    RunObject = Page "POS Sales Header List";
                }

            }

            group(Common_req)
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
                action("Leave Applications")
                {
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                    ApplicationArea = All;
                }
                action("My Approved Leaves")
                {
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "HRM-My Approved Leaves List";
                    ApplicationArea = All;
                }
                action("Page FLT Transport Requisition2")
                {
                    Caption = 'Transport Requisition';
                    RunObject = Page "FLT-Transport Req. List";
                    ApplicationArea = All;
                }
                action(Travel_Notices2)
                {
                    Caption = 'Travel Notice';
                    Image = Register;
                    RunObject = Page "FLT-Safari Notices List";
                    ApplicationArea = All;
                }
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    ApplicationArea = All;
                    RunObject = Page "CAT-Meal Booking List";
                }

                action("File Requisitions")
                {
                    Image = Register;
                    ApplicationArea = All;
                    RunObject = Page "REG-File Requisition List";
                }
                action("Purchase Requisition Header")
                {
                    Caption = 'Purchase Requisition';
                    RunObject = page "Purchase Requisition Header";
                    ApplicationArea = All;
                }

            }
        }

        area(Reporting)
        {

            action("POS REPORT")
            {
                ApplicationArea = All;
                image = PostDocument;
                RunObject = report "POS cashier Sales Report";
            }
            action("Total Summary")
            {
                ApplicationArea = All;
                Image = Totals;
                RunObject = Report "POS cashier Sales Totals";
            }
            action("Sales Per Item")
            {
                ApplicationArea = All;
                Image = SalesPerson;
                RunObject = Report "Sales Per Item POS";
            }
            action("Sales Per item Summary")
            {
                ApplicationArea = All;
                Image = AddWatch;
                RunObject = Report "Sales Per Item Summary";
            }
        }
    }
}