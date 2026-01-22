page 52136 "New POS"
{
    PageType = RoleCenter;
    Caption = 'New POS';

    layout
    {
        area(RoleCenter)
        {
            part(Headline; "Headline RC Team Member")
            {
                ApplicationArea = Basic, Suite;
            }
            part("POS Menu List"; "POS Menu List")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Help And Chart Wrapper"; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Report Inbox Part"; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Student Sales")
            {
                RunPageMode = Create;
                Caption = 'Student Sales';
                ToolTip = 'Add some tooltip here';
                ShortcutKey = 'F9';
                Image = New;
                RunObject = page "POS Sales Student Card";
                ApplicationArea = Basic, Suite;
            }
            action("Staff Sales")
            {
                RunPageMode = Create;
                Caption = 'Staff Sales';
                ToolTip = 'Add some tooltip here';
                Image = New;
                RunObject = page "POS Sales Staff";
                ShortcutKey = 'F7';
                ApplicationArea = Basic, Suite;
            }
            action(Setups)
            {
                RunPageMode = Create;
                Caption = 'Setups';
                ToolTip = 'Add some tooltip here';
                Image = Setup;
                RunObject = page "POS Setup";
                ApplicationArea = Basic, Suite;
            }
        }
        // area(Processing)
        // {
        //     group(New)
        //     {
        //         action("AppNameMasterData")
        //         {
        //             RunPageMode = Create;
        //             Caption = 'AppNameMasterData';
        //             ToolTip = 'Register new AppNameMasterData';
        //             RunObject = page "AppNameMasterData Card";
        //             Image = DataEntry;
        //             ApplicationArea = Basic, Suite;
        //         }
        //     }
        //     group("AppNameSomeProcess Group")
        //     {
        //         action("AppNameSomeProcess")
        //         {
        //             Caption = 'AppNameSomeProcess';
        //             ToolTip = 'AppNameSomeProcess description';
        //             Image = Process;
        //             RunObject = Codeunit "AppNameSomeProcess";
        //             ApplicationArea = Basic, Suite;
        //         }
        //     }
        //     group("AppName Reports")
        //     {
        //         action("AppNameSomeReport")
        //         {
        //             Caption = 'AppNameSomeReport';
        //             ToolTip = 'AppNameSomeReport description';
        //             Image = Report;
        //             RunObject = report "AppNameSomeReport";
        //             ApplicationArea = Basic, Suite;
        //         }
        //     }
        // }
        area(Reporting)
        {
            action("Cashier Sales Report")
            {
                Caption = 'Cashier Sales Report';
                Image = Report;
                RunObject = report "POS cashier Sales Report";
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
            }
            action("POS Daily Totals")
            {
                Caption = 'POS Daily Totals';
                Image = Report;
                RunObject = report "POS Daily Totals";
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
            }
            action("Sales Per Item Summary Two")
            {
                Caption = 'Sales Per Item Summary Two';
                Image = Report;
                RunObject = report "Sales Per Item Summary Two";
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
            }
        }
        area(Embedding)
        {
            action("POS Receipts List (STD)")
            {
                RunObject = page "POS Receipts List (STD)";
                ApplicationArea = Basic, Suite;
            }
            action("POS Receipts List (Staff)")
            {
                RunObject = page "POS Receipts List (Staff)";
                ApplicationArea = Basic, Suite;
            }

        }
        area(Sections)
        {
            group("POS Batch Posting")
            {
                Caption = 'POS Batch Posting';
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Image = Setup;

                action("Cafeteria Sales Batches")
                {
                    RunObject = Page "Cafeteria Sales Batches LST";
                    ApplicationArea = Basic, Suite;

                }
                action("Posted Sales Batches")
                {
                    RunObject = Page "Posted Cafe Sales Batches";
                    ApplicationArea = Basic, Suite;
                }
            }
            group("POS Sales")
            {
                action("POS Sales List")
                {
                    RunObject = Page "POS Sales Header List";
                    ApplicationArea = Basic, Suite;
                }
                action("POS Stock List")
                {
                    Caption = 'Stock Adjustments';
                    RunObject = Page "POS Stock Header List";
                    ApplicationArea = Basic, Suite;
                }
                action("Stock Posted List")
                {
                    RunObject = Page "POS Stock Header List";
                    ApplicationArea = Basic, Suite;
                }
            }
            group("POS Items")
            {
                action("POS Items List")
                {
                    RunObject = Page "POS Items";
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

}
