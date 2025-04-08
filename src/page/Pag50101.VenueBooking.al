// page 50101 "Venue Booking"
// {
//     ApplicationArea = All;
//     Caption = 'Venue Booking';
//     PageType = RoleCenter;

//     layout
//     {
//         area(rolecenter)
//         {
//             part("Dashboard Greetings"; "Dashboard Greetings")

//             {
//                 ApplicationArea = all;
//             }
//             part(ApprovalsActivities; "Approvals Activities")
//             {
//                 ApplicationArea = Suite;
//             }

//             group(Control26)
//             {
//                 ShowCaption = false;

//                 systempart(Control24; Links)
//                 {
//                     ApplicationArea = All;
//                 }
//                 systempart(Control23; MyNotes)
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }
//     actions
//     {
//         area(sections))
//         {
//             action("New Booking")
//             {
//                 ApplicationArea = all;
//                 Caption = 'New Booking';
//                 RunObject = page "Venue Booking List";
//                 //RunPageLink = "Booking Id" = field("Booking Id", Rec."Booking Id");
//             }
//             action("Meal Booking")
//             {
//                 applicationArea = all;
//                 Caption = 'Meal Booking';
//                 RunObject = page "Meal Booking List";

//             }
//         }
//         area(creation)
//         {
//             group("Set up")
//             {
//             action("Venue Set up")
//             {
// applicationArea = all;
//                 Caption = 'Venue Set up';
//                 RunObject = page v;
//             }
//             action("Meal Set up")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Meal Set up';
//                 RunObject = page "Meal Set up List";
//             }

//         }
//     }
    
// }
