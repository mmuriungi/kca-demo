page 51452 "CAT-Cafeteria Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(GH; "Headline RC Team Member")
            {
                ApplicationArea = Basic, Suite;
            }
            part(AA; "Approvals Activities")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }


    actions
    {
        area(creation)
        {


        }
        area(processing)
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
                Image = Sales;
                ShortcutKey = 'F9';
                RunObject = Page "POS Sales Staff";
                RunPageMode = Create;
            }
            action("Non-Revenue Sales")
            {
                AccessByPermission = TableData "POS Sales Header" = IMD;
                ApplicationArea = Basic, suite;
                Image = Revenue;
                ShortcutKey = 'F10';
                RunObject = Page "Non-Revenue Sale";
                RunPageMode = Create;
            }

        }
        area(embedding)
        {
            action(PS1)
            {
                ApplicationArea = All;
                Caption = 'POS Setup';
                Image = SetupPayment;
                RunObject = Page "POS Setup";
            }
        }
        area(sections)
        {
            group("Member Registration")
            {
                action("Cafe Members")
                {
                    ApplicationArea = All;
                    Image = SalesInvoice;
                    RunObject = Page "Cafe Members";
                }
            }
            group("Cafe Items")
            {
                action("All POS Items")
                {
                    ApplicationArea = All;
                    Image = SalesInvoice;
                    RunObject = Page "POS Items";
                }
                action("Items In Stock")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Items in Stock";
                }
                action("Items Out of Stock")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Items Out of Stock";
                }
            }
            group("Cafe Sales")
            {
                action("POS1")
                {
                    Caption = 'Staff Sales';
                    ApplicationArea = All;
                    Image = PostedPayment;
                    RunObject = Page "Staff Sales";
                }
                action("POS2")
                {
                    Caption = 'Student Sales';
                    ApplicationArea = All;
                    Image = PostedPayment;
                    RunObject = Page "Student Sales";
                }

                action("POSSales")
                {
                    Caption = 'ALl POS Sales';
                    ApplicationArea = All;
                    Image = PostedPayment;
                    RunObject = Page "POS Sales Header List";
                }
                action("POS3")
                {
                    Caption = 'Posted Sales';
                    ApplicationArea = All;
                    Image = PostedPayment;
                    RunObject = Page "Posted Sales";
                }

            }
            group("Stock Adjustments")
            {
                action("Cafe Store")
                {
                    ApplicationArea = All;
                    RunObject = Page "Cafe Store";
                }
                action("Stock Adjustment")
                {
                    ApplicationArea = All;
                    RunObject = Page "POS Stock Header List";
                }
                action("Posted Stocks")
                {
                    Image = AdjustEntries;
                    RunObject = Page "Posted Stocks";
                }
                action("Cleared Stocks")
                {
                    Image = AdjustEntries;
                    RunObject = Page "Cleared Stock";
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;
                action("Pending My Approval")
                {
                    Caption = 'Pending My Approval';
                    RunObject = Page "Requests to Approve";
                    ApplicationArea = BAsic, Suite;
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                    ApplicationArea = BAsic, Suite;
                }
                action("Clearance Requests")
                {
                    Caption = 'Clearance Requests';
                    RunObject = Page "ACA-Clearance Approval Entries";
                    ApplicationArea = BAsic, Suite;
                }
            }
            group(CafeSateUps)
            {
                Caption = 'Cafe Setups';
                Visible = false;
                action(CAFEFoodItem)
                {
                    Caption = 'Food Items';
                    RunObject = Page "CAFE Food Item List";
                    Image = ItemCosts;
                    ApplicationArea = BAsic, Suite;
                }
                action(FoodItemJournals)
                {
                    Caption = 'Food Journals';
                    RunObject = Page "Food Item Journals";
                    Image = Journals;
                    ApplicationArea = BAsic, Suite;
                }
                action(MealsPhyInvJournal)

                {
                    Caption = 'Meals Inventory';
                    RunObject = Page "Meals Phy. Inv. Journal";
                    Image = InventoryJournal;
                    ApplicationArea = BAsic, Suite;
                }
                action(CafeteriaMenuPrices)

                {
                    Caption = 'Food Prices';
                    RunObject = Page "Cafeteria Menu Prices";
                    Image = PostedCreditMemo;
                    ApplicationArea = BAsic, Suite;
                }
                action(MealsCentralSetup)

                {
                    Caption = 'Meals Proc. Central Setup';
                    RunObject = Page "Meal-Proc. Central Setup";
                    Image = CancelledEntries;
                    ApplicationArea = BAsic, Suite;
                }
                action(MealBatchNoSetup)

                {
                    Caption = '"Meal Batch No Setup"';
                    RunObject = Page "Meal Batch No. Setup";
                    Image = ChangeBatch;
                    ApplicationArea = BAsic, Suite;
                }
                action(CafeteriaLocations)

                {
                    Caption = 'Cafeteria Locations';
                    RunObject = Page "Cafeteria Locations";
                    Image = PostedDeposit;
                    ApplicationArea = BAsic, Suite;
                }
                action(ACAHostelPermissions)

                {
                    Caption = 'Hostel Permissions';
                    RunObject = Page "ACA-Hostel Permissions";
                    Image = Permission;
                    ApplicationArea = BAsic, Suite;
                }
                action(MealsProductionPermissions)

                {
                    Caption = 'Meals Prod. Permissions';
                    RunObject = Page "Meal-Proc. Permissions";
                    Image = PrepaymentInvoice;
                    ApplicationArea = BAsic, Suite;
                }
                action(CAFEFoodItemList)

                {
                    Caption = 'Food Item';
                    RunObject = Page "CAFE Food Item List";
                    Image = PostedCreditMemo;
                    ApplicationArea = BAsic, Suite;
                }
                action(CashUserTemplate)

                {
                    Caption = 'Cash Office User Template';
                    RunObject = Page "Cash Office User Template UP";
                    Image = CashFlowSetup;
                    ApplicationArea = BAsic, Suite;
                }
                action(PostedFoodStocksDate)

                {
                    Caption = 'Posted Stocks';
                    RunObject = Page "Posted Food Stocks/Date";
                    Image = PostedCreditMemo;
                    ApplicationArea = BAsic, Suite;
                }
            }

            group(MealsProduction)
            {
                Caption = 'Production';
                Visible = false;
                action(MealProcBatchList)
                {
                    Caption = 'Prod. Batches';
                    RunObject = Page "Meal-Proc. Batch List";
                    Image = ProdBOMMatrixPerVersion;
                    ApplicationArea = BAsic, Suite;
                }
                action(ProdApprovals)
                {
                    Caption = 'Production Approvals';
                    RunObject = Page "Meal-Proc. Approvals";
                    Image = PostedOrder;
                    ApplicationArea = BAsic, Suite;
                }
                action(ApprovedProd)

                {
                    Caption = 'Approved Meal Prod. Batches';
                    RunObject = Page "Meal-Proc. Released";
                    Image = ProductionSetup;
                    ApplicationArea = BAsic, Suite;
                }
                action(PostedMealProcBatches)
                {
                    Caption = 'Posted Batches';
                    RunObject = Page "Posted Meal-Proc. Batches";
                    Image = ProfileCalendar;
                    ApplicationArea = BAsic, Suite;
                }
                action(MealProcPostedPlans)

                {
                    Caption = 'Meal Posted Plans';
                    RunObject = Page "Meal-Proc. Posted Plans";
                    Image = ProductDesign;
                    ApplicationArea = BAsic, Suite;
                }
                action(MealProcTransfer)

                {
                    Caption = 'Meal-Proc. Transfer';
                    RunObject = Page "Meal-Proc. Transfer";
                    Image = Production;
                    ApplicationArea = BAsic, Suite;
                }

            }

        }
        area(reporting)
        {
            group("Cafeteria Reports")
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
            group(Periodic)
            {
                Caption = 'Periodic Reports';

                action("Cafe Revenue Report")
                {
                    Caption = 'Cafe Revenue Report';
                    Image = Report2;

                    RunObject = Report "CAT-Cafe Revenue Reports";
                    // ApplicationArea = All;
                }
                action("Cafe` Menu")
                {
                    Caption = 'Cafe` Menu';
                    Image = Report2;


                    //RunObject = Report "CAT-Cafeteria Menu";
                    ApplicationArea = All;
                }
                action("Report Catering Daily Summary S")
                {
                    Caption = 'Catering Daily SUmmary Sales';
                    Image = Report2;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'

                    //RunObject = Report "Catering Daily Summary Sales";
                }
                action("Summary Sales Report")
                {
                    Caption = 'Summary Sales Report';
                    Image = PrintReport;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'

                    // RunObject = Report "Catering Sales Summary";
                }
                action("Daily Sales Summary (All)")
                {
                    Image = Report2;
                    //RunObject = Report 51814;
                }
                action("Student Summary Prepayment")
                {
                    Image = "Report";
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'

                    RunObject = Report "UpdateStud Dept";
                    // ApplicationArea = BAsic, Suite;
                }
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                    // ApplicationArea = BAsic, Suite;
                }
            }
        }
    }
}

profile "Cafeteria"
{
    ProfileDescription = 'CAFETE';
    RoleCenter = "CAT-Cafeteria Role Center";
    Caption = 'Cafeteria Role';
}
