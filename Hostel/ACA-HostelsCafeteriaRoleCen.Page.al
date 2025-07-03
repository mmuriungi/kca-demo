#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 69191 "ACA-Hostels/Cafeteria Role Cen"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control10)
            {
                part(Control8; "ACA-Hostel List")
                {
                    Caption = 'Hostels';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Hostel Status Summary Report")
            {
                ApplicationArea = Basic;
                Caption = 'Hostel Status Summary Report';
                Image = Status;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Hostel Status Summary Report";
            }
            action("AlloCation Analysis")
            {
                ApplicationArea = Basic;
                Caption = 'AlloCation Analysis';
                Image = Interaction;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Hostel Status Summary Graph";
            }
            action("Incidents Report")
            {
                ApplicationArea = Basic;
                Caption = 'Incidents Report';
                Image = Register;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Hostel Incidents Report";
            }
            action("Hostel Allocations")
            {
                ApplicationArea = Basic;
                Caption = 'Hostel Allocations';
                Image = Allocations;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Hostel Allocations Per Block";
            }
            action("Detailled Allocations")
            {
                ApplicationArea = Basic;
                Caption = 'Detailled Allocations';
                Image = AllocatedCapacity;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Hostel Allo. Per Room/Block";
            }
            action("Room Status")
            {
                ApplicationArea = Basic;
                Caption = 'Room Status';
                Image = Status;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Hostel Vaccant Per Room/Block";
            }
            action("Allocations List")
            {
                ApplicationArea = Basic;
                Caption = 'Allocations List';
                Image = Allocate;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Hostel Allo. Per Room (Det.)";
            }
        }
        area(reporting)
        {
            group(Cafeteria_Reports)
            {
                Caption = 'Cafe` Reports';
                action("Receipts Register")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipts Register';
                    Image = Report2;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report UnknownReport61900;
                }
                action("Daily Summary Saless")
                {
                    ApplicationArea = Basic;
                    Caption = 'Daily Summary Saless';
                    Image = Report2;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report UnknownReport51815;
                }
                action("Daily Sales Summary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Daily Sales Summary';
                    Image = Report2;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report UnknownReport51814;
                }
                action("Cafe Revenue Report")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cafe Revenue Report';
                    Image = Report2;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report UnknownReport51813;
                }
                action("Sales Summary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sales Summary';
                    Image = Report2;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report UnknownReport51811;
                }
                action("Cafe` Menu")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cafe` Menu';
                    Image = Report2;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report UnknownReport51809;
                }
            }
        }
        area(sections)
        {
            group("Hostel Management")
            {
                Caption = 'Hostel Management';
                Image = FixedAssets;
                action(HostelsList)
                {
                    ApplicationArea = Basic;
                    Caption = 'Hostels';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "ACA-Hostel List";
                }
                action(Allocations)
                {
                    ApplicationArea = Basic;
                    Caption = 'Hostel Allocations';
                    Image = Registered;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "ACA-Std Hostel Lists";
                }
                action("Hostel Bookings (Unallocated)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Hostel Bookings (Unallocated)';
                    RunObject = Page "ACA-Hostel Bookings (Unalloc.)";
                }
                action("Posted Allocations")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Allocations';
                    Image = Aging;
                    Promoted = true;
                    RunObject = Page "ACA-Std Hostel Lists Hist";
                }
                action("Student Information")
                {
                    ApplicationArea = Basic;
                    Caption = 'Student Information';
                    RunObject = Page "ACA-Std Information (Hostels)";
                }
                action("Hostel Billing")
                {
                    ApplicationArea = Basic;
                    Caption = 'Hostel Billing';
                    Image = Invoice;
                    Promoted = true;
                    RunObject = Page UnknownPage68835;
                    Visible = true;
                }
            }
            group(Setups)
            {
                Caption = 'Hostel Setups';
                Image = Setup;
                action("Hostels List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Hostels List';
                    RunObject = Page "ACA-Hostel List";
                }
                action("Inventory Items")
                {
                    ApplicationArea = Basic;
                    Caption = 'Inventory Items';
                    Image = InventorySetup;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "ACA-Hostel Invtry Items List";
                }
            }
            group(hist)
            {
                Caption = 'Hostel History';
                Image = History;
                action("Allocation (Uncleared)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Allocation (Uncleared)';
                    RunObject = Page "ACAHostel Bookings (All. List)";
                }
                action("Allocation History (Cleared)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Allocation History (Cleared)';
                    Image = Invoice;
                    Promoted = true;
                    RunObject = Page "ACA-Hostel Bookings (History)";
                }
                action("Historical Allocations")
                {
                    ApplicationArea = Basic;
                    Caption = 'Historical Allocations';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "ACA-Std Information (Hostels)h";
                }
            }
            group(CafeMan)
            {
                Caption = 'Cafe` Management';
                Visible = false;
                action("Sales Receipts (New)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sales Receipts (New)';
                    RunObject = Page UnknownPage69087;
                }
                action("Receipts (Unprinted)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipts (Unprinted)';
                    RunObject = Page UnknownPage69090;
                }
                action("Receipts (UnPosted)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipts (UnPosted)';
                    RunObject = Page UnknownPage69091;
                }
                action("Receipts (Cancelled)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipts (Cancelled)';
                    RunObject = Page UnknownPage69092;
                }
                action("Receipts (Posted)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipts (Posted)';
                    RunObject = Page UnknownPage69093;
                }
                action("Meals List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Meals List';
                    RunObject = Page UnknownPage69074;
                }
                action("Meals Inventory")
                {
                    ApplicationArea = Basic;
                    Caption = 'Meals Inventory';
                    RunObject = Page UnknownPage69078;
                }
            }
            group(CafeSetups)
            {
                Caption = 'Cafe` Setups';
                Visible = false;
                action("Sales Sections")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sales Sections';
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page UnknownPage68299;
                }
                action("Cafe` Staff")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cafe` Staff';
                    RunObject = Page UnknownPage68307;
                }
                action("Meals Setup")
                {
                    ApplicationArea = Basic;
                    Caption = 'Meals Setup';
                    RunObject = Page UnknownPage69074;
                }
                action("General Setup")
                {
                    ApplicationArea = Basic;
                    Caption = 'General Setup';
                    RunObject = Page UnknownPage69076;
                }
                action(Action1000000016)
                {
                    ApplicationArea = Basic;
                    Caption = 'Meals Inventory';
                    RunObject = Page UnknownPage69078;
                }
                action("Staff Setup")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff Setup';
                    RunObject = Page UnknownPage69082;
                }
            }
            group("Catering Management")
            {
                Caption = 'Catering Management';
                Visible = false;
                action("Procurement Plan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Procurement Plan';
                    RunObject = Page UnknownPage68120;
                }
                action("Store Requisitions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Store Requisitions';
                    RunObject = Page UnknownPage68218;
                }
                action("Purchase Requisitions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Purchase Requisitions';
                    RunObject = Page UnknownPage69400;
                }
                separator(Action1000000029)
                {
                    Caption = 'History';
                }
                action("Approved Store Reqiositions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Store Reqiositions';
                    RunObject = Page UnknownPage68608;
                }
                action("Posted Store Requisitions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Store Requisitions';
                    RunObject = Page UnknownPage68421;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;
                action("Pending My Approval")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pending My Approval';
                    RunObject = Page "Approval Entries";
                }
                action("My Approval requests")
                {
                    ApplicationArea = Basic;
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                }
                action("Clearance Requests")
                {
                    ApplicationArea = Basic;
                    Caption = 'Clearance Requests';
                    RunObject = Page UnknownPage68970;
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Stores Requisitions';
                    RunObject = Page UnknownPage68218;
                }
                action("Imprest Requisitions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Imprest Requisitions';
                    RunObject = Page UnknownPage68125;
                }
                action("Leave Applications")
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Applications';
                    RunObject = Page UnknownPage68107;
                }
                action("My Approved Leaves")
                {
                    ApplicationArea = Basic;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page UnknownPage68232;
                }
                action("Meal Booking")
                {
                    ApplicationArea = Basic;
                    Caption = 'Meal Booking';
                    RunObject = Page UnknownPage69302;
                }
            }
        }
    }
}

