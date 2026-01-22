page 51987 "CA-RoleCenter"
{
    PageType = RoleCenter;
    Caption = 'Role Center';

    layout
    {
        area(rolecenter)
        {

            part(Page; 9030)
            {
                ApplicationArea = All;
            }
            part(HOD; "Approvals Activities One")
            {
                ApplicationArea = Suite;
            }


        }
    }

    actions
    {
        area(sections)
        {





            group(Complaints)
            {
                Caption = 'Complaints';
                Image = Alerts;
                action(Grievances)
                {
                    ApplicationArea = all;
                    Caption = 'Complaints List';
                    RunObject = Page "Complaint List";
                }
                action("Committee Complaints")
                {
                    ApplicationArea = all;
                    Caption = 'Committee Complaints';
                    RunObject = Page "Committee Complaint List";
                }
                action(Pending)
                {
                    ApplicationArea = all;
                    Caption = 'Pending Complaints';
                    // RunObject = Page "Complaints Pending";
                }
                action(ClosedCasesEnd)
                {
                    ApplicationArea = all;
                    Caption = 'Closed Cases';
                    //RunObject = Page "Complaints Closed";
                }
                action("Employee List")
                {
                    ApplicationArea = all;
                    Caption = 'Employee List';
                    //unObject = Page "Emp. List";
                }


                /*group("Branding")
                {
                    Caption = 'Branding';
                    action("Branding List")
                    {
                        Caption = 'Branding Requisition';
                        Image = MovementWorksheet;
                        RunObject = Page "CA-Branding Req. List";
                        ApplicationArea = All;
                    }
                    action("CA-Branding DD List")
                    {
                        Caption = 'Branding DD List';
                        Image = MovementWorksheet;
                        RunObject = Page "CA-Branding DD List";
                        ApplicationArea = All;
                    }
                    action("CA-Branding DDCAQA List")
                    {
                        Caption = 'Branding DDCAQA List';
                        Image = MovementWorksheet;
                        RunObject = Page "CA-Branding DDCAQA List";
                        ApplicationArea = All;
                    }
                    action("CA-Branding Comm. Officer List")
                    {
                        Caption = 'Branding Comm. Officer List';
                        Image = MovementWorksheet;
                        RunObject = Page "CA-Branding Comm. Officer List";
                        ApplicationArea = All;
                    }
                    action("Posted Branding List")
                    {
                        Caption = 'Posted Branding Requisitions';
                        Image = MovementWorksheet;
                        RunObject = Page "CA-Branding Req. List-Posted";
                        ApplicationArea = All;
                    }
                }*/
                /* group("CSR")
                 {
                     action("CSR Memo")
                     {
                         Caption = 'CSR Requisition list';
                         Image = PlannedOrder;
                         RunObject = page "CA-CSR Req. List";
                         ApplicationArea = All;
                     }
                     action("CSR CO")
                     {
                         Caption = 'CSR Communication Officer';
                         Image = PlannedOrder;
                         Visible = false;
                         // RunObject = page 51749;
                         ApplicationArea = All;
                     }
                     action("CSR Director")
                     {
                         Caption = 'CSR Director';
                         Image = PlannedOrder;
                         RunObject = page "CA-CSR Director registry. List";
                         ApplicationArea = All;
                     }
                     action("CSR DDCAQA")
                     {
                         Caption = 'CSR DDCAQA';
                         Image = PlannedOrder;
                         RunObject = page "CA-CSR DDCAQA. List";
                         ApplicationArea = All;
                     }
                     action("CSR SCM")
                     {
                         Caption = 'CSR SCM';
                         Image = PlannedOrder;
                         Visible = false;
                         // RunObject = page 51748;
                         ApplicationArea = All;
                     }
                     action("CSR List")
                     {
                         Caption = 'CSR Memo';
                         Image = PlannedOrder;
                         RunObject = page "CA-CSR Req. List";
                         ApplicationArea = All;
                     }
                     action("Approved CSR List")
                     {
                         Caption = 'Approved CSR Memo';
                         Image = PlannedOrder;
                         RunObject = page "CA-CSR Req. Approved";
                         ApplicationArea = All;
                     }
                 }
                 group("Feedback")
                 {
                     action("Feedback2")
                     {
                         Caption = 'Feedback List';
                         Image = Users;
                         RunObject = page "CA-Feedback List";
                         ApplicationArea = All;
                     }
                 }*/
                group("Risks Register")
                {

                    action("Risk List")
                    {
                        RunObject = Page "AUDIT - Risk analysis lines";
                        ApplicationArea = All;
                    }
                    action("Submitted Risks Under Audit")
                    {
                        RunObject = Page "Audit List in Unde Auditing";
                        ApplicationArea = All;
                    }
                }
                group("Audit Planner")
                {

                    action("Audit-Plan-Master")
                    {
                        RunObject = Page "Audit-Plan-Master";
                        ApplicationArea = All;
                    }
                }
                group("Audit Assessment")
                {

                    action("Audit Assessment List")
                    {
                        RunObject = Page "Audit Assessment";
                        ApplicationArea = All;
                    }
                    action("Audit Review List")
                    {
                        RunObject = Page "Audit Assessmnt Review List";
                        ApplicationArea = All;
                    }
                    action("Archived Audit List")
                    {
                        RunObject = Page "Audit Assemnt Archived";
                        ApplicationArea = All;
                    }
                }
            }
            /*   group(Performance_Contracts)
              {

                  Caption = 'Perfomance Contract Management';

                  action("Performance Contracts")
                  {
                      Image = "1099Form";
                      Caption = 'Performance Criteria Category';
                      
                      PromotedIsBig = true;
                      ApplicationArea = All;
                      RunObject = page 70221;
                  }
                  action("Performance Criterial")
                  {
                      Image = "1099Form";
                      Caption = 'Performance Criterial List';
                      
                      PromotedIsBig = true;
                      ApplicationArea = All;
                      RunObject = page 70227;
                  }
                  action("Performance Contract Director")
                  {
                      Image = "1099Form";
                      Caption = 'Performance Contract Director';
                      
                      PromotedIsBig = true;
                      ApplicationArea = All;
                      RunObject = page 70226;
                  }
                  action("Performance Contracts BOD, Director")
                  {
                      Image = "1099Form";
                      Caption = 'Performance Contract BOD, Director';
                      
                      PromotedIsBig = true;
                      ApplicationArea = All;
                      RunObject = page 70207;
                  }
                  action("Performance Citeria DDs")
                  {
                      Image = "1099Form";
                      Caption = 'Performance Contract DDs';
                      
                      ApplicationArea = All;
                      PromotedIsBig = true;
                      RunObject = page 70210;
                  }
                  action("Performance Citeria SDDRD, DD, RD, DRD, ")
                  {
                      Image = "1099Form";
                      Caption = 'Performance Contract SDDRD, DD, RD, DRD, ';
                      
                      PromotedIsBig = true;
                      ApplicationArea = All;
                      RunObject = page 70213;
                  }
                  action("Performance Citeria Heads of Sections")
                  {
                      Image = "1099Form";
                      Caption = 'Performance Contract Heads of Sections';
                      
                      PromotedIsBig = true;
                      ApplicationArea = All;
                      RunObject = page 70195;
                  }
                  action("Performance Citeria Technical staff")
                  {
                      Image = "1099Form";
                      Caption = 'Performance Contract Technical staff';
                      
                      ApplicationArea = All;
                      PromotedIsBig = true;
                      RunObject = page 70198;
                  }
                  action("Performance Setup")
                  {
                      Image = "1099Form";
                      Caption = 'Performance  Setup';
                      
                      PromotedIsBig = true;
                      ApplicationArea = All;
                      RunObject = page "Project Setup";
                  }


              }
   */

            group("Appraisal")
            {


                Caption = 'HRM-Appraisals';
                Image = Setup;
                action("HRM- Setup")
                {
                    Caption = 'HRM-Setup';
                    Image = Card;
                    ApplicationArea = All;
                    RunObject = Page "HRM-Setup";
                }
                action("PRL-Transaction Code List")
                {
                    Caption = 'Transaction Code List';
                    Image = Card;
                    ApplicationArea = All;
                    RunObject = Page "PRL-Transaction Codes List";
                }
                action("Payroll Period List")
                {
                    Caption = 'Payroll Period List';
                    Image = Card;
                    ApplicationArea = All;
                    RunObject = Page "PRL-Payroll Periods";
                }
                action("HRM-Setup List")
                {
                    Caption = 'HRM-Setup List';
                    Image = Card;
                    ApplicationArea = All;
                    RunObject = Page "HRM-SetUp List";
                }
                action("HRM-Score Setup")
                {
                    Caption = 'HRM-Score Setup';
                    Image = Card;
                    ApplicationArea = All;
                    RunObject = Page "HRM-Score Setup";
                }
                action("HRM-JOB Requirements")
                {
                    Caption = 'HRM-Job Requiremnts';
                    Image = ViewDetails;
                    ApplicationArea = All;
                    RunObject = Page "HRM-Job Requirements (B)";
                }
                // action("HRM-Appraisal Types")
                // {
                //     Caption = 'HRM-Apparaisal Types';
                //     Image = ViewDetails;
                //     
                //     PromotedIsBig = true;
                //     RunObject = Page 68456;
                // }
                action("HRM-Appraisal Indicators")
                {
                    Caption = 'HRM-appraisal Indicators';
                    Image = ViewDetails;

                    ApplicationArea = All;
                    RunObject = Page "Appraisal Indicators";
                }
                action("HRM-Appraisal Appraisee")
                {
                    Caption = 'HRM-Appraisal (Individual staff)';
                    Image = ViewDetails;

                    ApplicationArea = All;
                    RunObject = Page "Appraisal Appraisee";
                }
                action("Appraisal-Sup")
                {
                    Caption = 'HRM-Appraisal-Supervisor';
                    Image = ViewDetails;

                    ApplicationArea = All;
                    // RunObject = Page "Appraisal Supervisor";
                }
                action("Appraisal-HOD")
                {
                    Caption = 'HRM-Appraisal HOD';
                    Image = ViewDetails;

                    ApplicationArea = All;
                    // RunObject = Page "Appraisal HOD List";
                }
                action("Appraisal-HR")
                {
                    Caption = 'HRM-Appraisal-DDHR';
                    Image = ViewDetails;

                    ApplicationArea = All;
                    //  RunObject = Page "Appraisal HR";
                }
                action("HRM-Confirmation Employee Appraisal List")
                {
                    Caption = 'HRM-Confirmation JSAC SSASC';
                    Image = ViewDetails;

                    ApplicationArea = All;
                    // RunObject = Page "Appraisal JSAC/SSASC List";
                }
                action("HRM-Confirmation HR Appraisal List")
                {
                    Caption = 'HRM-Confirmation Full Board';
                    Image = ViewDetails;

                    ApplicationArea = All;
                    //RunObject = Page "Appraisal Full Board List";
                }
                action("HRM-Appraisal Closed List")
                {
                    Caption = 'HRM-Appraisal Closed List';
                    Image = ViewDetails;

                    ApplicationArea = All;
                    //RunObject = Page "Appraisal  Closed List";
                }
                action("Casual Payments List")
                {
                    Caption = 'Casual Payments List';
                    Image = ViewDetails;

                    ApplicationArea = All;
                    RunObject = Page "Casual Payment Header List.";
                }
            }


            group(ProcessPCA)
            {
                Caption = 'Pay Change Advice Processing';
                action(PCA)
                {
                    Caption = 'PR-PCA List';
                    Image = Change;
                    ApplicationArea = All;
                    //  RunObject = page "prPCA list";
                }
                action(prPostedPCAMassList)
                {
                    Caption = 'Mass PCA List';
                    Image = Change;
                    ApplicationArea = All;
                    // RunObject = page prPCAMassList;
                }
                action(PostedMAssPCAList)
                {
                    Caption = 'Posted Mass PCA List';
                    Image = Change;

                    ApplicationArea = Basic;
                    //  RunObject = page  prPostedPCAMassList;
                }
                action(OthermPCAList)
                {
                    Caption = 'Other Mass PCA List';
                    Image = Change;
                    ApplicationArea = All;
                    // RunObject = page "Other mPCA list";
                }
                action("Casual Employees List")
                {
                    Caption = 'Casual Employees List';

                    ApplicationArea = All;

                    RunObject = Page "Casual Payment Header List.";
                }
            }
            group(Reports)
            {
                Caption = 'FLT Reports';


                action(Vehicles)
                {
                    Caption = 'Vehicle List';
                    Image = "Report";

                    ApplicationArea = All;
                    RunObject = Report "FLT Vehicle List";
                }
                action(Drivers)
                {
                    Caption = 'Driver List';
                    Image = "Report";

                    ApplicationArea = All;
                    RunObject = Report "FLT Driver List";
                }
                action(WT)
                {
                    Caption = 'Work Ticket';
                    Image = "Report";
                    ApplicationArea = All;
                    RunObject = Report "FLT Daily Work Ticket";
                }
            }
            group(Vehicle_Man)
            {
                Caption = 'Vehicle Management';

                action("Vehicle Card")
                {
                    Caption = 'Vehicle Card';
                    Image = Register;
                    ApplicationArea = All;

                    RunObject = Page "FLT-Vehicle Card List";
                }
                action("Driver Card")
                {
                    Caption = 'Driver Card';
                    Image = History;
                    ApplicationArea = All;

                    RunObject = Page "FLT-Driver List";
                }
            }
            group(Transport_re)
            {
                Caption = 'Transport Requisitions';

                action("Transport Requisition")
                {
                    Caption = 'Transport Requisition';
                    RunObject = Page "FLT-Transport Req. List";
                    ApplicationArea = All;
                }
                action("Submitted Transport Requisition")
                {
                    Caption = 'Submitted Transport Requisition';
                    RunObject = Page "FLT-Submitted Transport List";
                    ApplicationArea = All;
                }
                action("Approved Transport Requisition")
                {
                    Caption = 'Approved Transport Requisition';
                    RunObject = Page "FLT-Approved transport Req";
                    ApplicationArea = All;
                }
                action("Closed Transport Requisition")
                {
                    Caption = 'Closed Transport Requisition';
                    RunObject = Page "FLT-Transport - Closed List";
                    ApplicationArea = All;
                }
            }
            group(Safari_Notices)
            {
                Caption = 'Travel Notices';

                action(Travel_Notices)
                {
                    Caption = 'Travel Notice';
                    Image = Register;

                    ApplicationArea = All;
                    RunObject = Page "FLT-Safari Notices List";
                }
                action("Approved Travel Notices")
                {
                    Caption = 'Approved Travel Notices';
                    Image = History;

                    ApplicationArea = All;
                    RunObject = Page "FLT-Posted Safari Notices List";
                }
            }
            group(Fuel_reqs)
            {
                Caption = 'Fuel Requisitions';
                ;
                action(Fuel_Req)
                {
                    Caption = 'Fuel Requisitions';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "FLT-Fuel Req. List";
                }
                action(sub_Fuel_Req)
                {
                    Caption = 'Submitted Fuel Requisitions';
                    Image = History;
                    ApplicationArea = All;

                    RunObject = Page "FLT-Fuel Req. Submitted List";
                }
                action(Unpaid_Fuel_Req)
                {
                    Caption = 'Unpaid Fuel Requisitions';
                    Image = History;
                    ApplicationArea = All;

                    RunObject = Page "FLT-Fuel Req. Unpaid";
                }
                action(Closed_Fuel_Req)
                {
                    Caption = 'Closed/Paid Fuel Requisitions';
                    Image = History;

                    ApplicationArea = All;
                    RunObject = Page "FLT-Fuel Req. Closed List";
                }
                action(Batch_fuel_Pay)
                {
                    Caption = 'Batch Fuel Payments';
                    Image = History;
                    ApplicationArea = All;

                    RunObject = Page "FLT-Fuel Pymnt Batch List";
                }
            }
            group("Work Tickets")
            {
                Caption = 'Work Tickets';

                action(workTick)
                {
                    Caption = 'Daily Work Tickets';
                    Image = Register;


                    RunObject = Page "FLT-Daily Work Ticket List";
                    ApplicationArea = All;
                }
                action(Closed_Work_Tick)
                {
                    Caption = 'Closed Daily Work Tickets';
                    Image = History;

                    ApplicationArea = All;
                    RunObject = Page "FLT-Closed Work Ticket List";
                }
            }
            group(Maint_Req)
            {
                Caption = 'Maintenance Request';

                action(main_Req)
                {
                    Caption = 'Maintenance Request';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "FLT-Maint. Req. List";
                }
                action(subMmain_Req)
                {
                    Caption = 'Submitted Maintenance Request';
                    Image = History;

                    ApplicationArea = All;
                    RunObject = Page "FLT-Maint. Req. Sub. List";
                }
                action(Appr_main_Req)
                {
                    Caption = 'Approved Maintenance Request';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "FLT-Approved  Maintenance Req";
                }
                action("HR Asset-Transfer List")
                {
                    Caption = 'HR Asset-Transfer List';
                    Image = Register;

                    ApplicationArea = All;

                    // RunObject = Page "HR Asset Transfer List";
                }
                action("HR EffectedAsset-Transfer List")
                {
                    Caption = 'HR Effected Asset-Transfer List';
                    Image = Register;

                    ApplicationArea = All;

                    // RunObject = Page "HR EffectedAsset Transfer List";
                }
                action("Maintenance Plan List")
                {
                    Caption = 'Maintenance Plan List';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "Maintenance Plan List";
                }
                action("Actual Maintenance List")
                {
                    Caption = 'Actual Maintenance List';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "Actual Maintenance List";
                }
                action("Asset Incident List")
                {
                    Caption = 'Asset Incident List';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "Asset Incident List";
                }
                action("Asset Repair List")
                {
                    Caption = 'Asset Repair List';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "Asset Repair List";
                }
                action("Approved Repair Vehicle List")
                {
                    Caption = 'Approved Repair Vehicle List';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "Approved Repair List  Vehicles";
                }
                action("Approved Repair List others")
                {
                    Caption = 'Approved Repair List others';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "Approved Repair List  Others";
                }
                action("Motor Vehicle Checklist List")
                {
                    Caption = 'Motor Vehicle Checklist List';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "Motor Vehicle Checklist";
                }
                action("Gate Pass List")
                {
                    Caption = 'Gate Pass List';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "Gatepass List";
                }
                action("Approved Gate Pass List")
                {
                    Caption = 'Approved Gate Pass List';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "Approved Gatepass List";
                }
                action("Security Gate Pass List")
                {
                    Caption = 'Security Gate Pass List';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "Security Gatepass List";
                }
                action("Gate Pass Return List")
                {
                    Caption = 'Gate Pass Return List';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "Gatepass Return List";
                }

                action(Closed_main_Req)
                {
                    Caption = 'Closed Maintenance Request';
                    Image = History;

                    ApplicationArea = All;
                    RunObject = Page "FLT-Closed Maint. Req. List";
                }
            }
            group(Setup)
            {
                Caption = 'Setups';

                action(FleetMan_setup)
                {
                    Caption = 'Fleet Mgt Setup';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "FLT-Setup";
                }
                action(HRM_setup)
                {
                    Caption = 'HRM_setup';
                    Image = Register;

                    ApplicationArea = All;

                    RunObject = Page "HRM-Setup";
                }
                action(flet_man_app_setup)
                {
                    Caption = 'Fleet Mgt Approval Setup';
                    Image = History;

                    ApplicationArea = All;
                    RunObject = Page "FLT-Approval Setup";
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';

                action("Pending My Approval")
                {
                    Caption = 'Pending My Approval';
                    RunObject = Page "Requests to Approve";
                    ApplicationArea = All;
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                    ApplicationArea = All;
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

                    RunObject = Page "REG-File Requisition List";
                    ApplicationArea = All;
                }
                action("Purchase Requisition Header")
                {
                    Caption = 'Purchase Requisition';
                    RunObject = page "Purchase Requisition Header";
                    ApplicationArea = All;
                }

            }
            group(QAAudit)
            {
                Caption = 'QA Audit';
                action("QA Audit")
                {
                    Caption = 'QA Audit';
                    Image = Allocate;

                    ApplicationArea = All;

                    RunObject = Page "IMS Audit Notification List";
                }
                action("QA Audit List")
                {
                    Caption = 'QA Audit List';
                    Image = Allocate;

                    ApplicationArea = All;

                    RunObject = Page "QA Audit List";
                }
            }
        }
    }


    var
        myInt: Integer;
}