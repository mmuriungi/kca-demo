page 51449 "HMS-Hospital Role Centre"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {

            part("HMS CUE"; "HMS-Cue")
            {
                Caption = 'HMS CUE';
                ApplicationArea = All;

            }

            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            part(HOD; "Approvals Activities One")
            {
                ApplicationArea = Suite;
            }



        }
    }

    actions
    {
        area(processing)
        {

            group(Referrals)
            {
                Caption = 'Referrals';
                Image = Confirm;
                action(RefHosp)
                {
                    Caption = 'Referral Hospitals';
                    Image = SetupColumns;
                    RunObject = Page "HMIS-Referal Facilities List";
                    ApplicationArea = All;
                }
                action(ActiveRef)
                {
                    Caption = 'Active Referrals';
                    Image = Setup;

                    RunObject = Page "HMS Referral Header Active";
                    ApplicationArea = All;
                }
                action(hitRef)
                {
                    Caption = 'Completed Referrals';
                    Image = Employee;

                    RunObject = Page "HMS Referral Header Released";
                    ApplicationArea = All;
                }
            }
            group(Immunizations)
            {
                Caption = 'Immunizations';
                Image = SNInfo;
                action(Immunization)
                {
                    Image = NewOrder;
                    RunObject = Page "HMS Immunization Header";
                    ApplicationArea = All;
                }
                action(ImmHist)
                {
                    Caption = 'Immunization History';
                    Image = History;
                    RunObject = Page "HMS Immunization Posted";
                    ApplicationArea = All;
                }
            }
            group("Stock take")
            {
                Caption = 'Stock take';
                action("Stock take Process")
                {
                    Caption = 'Stock take Process';

                    Image = PaymentForecast;

                    RunObject = report "stock take report";
                    ApplicationArea = All;
                }
                action("Near Expirery  Batch Numbers")
                {
                    Caption = 'Near Expiry  Batch Numbers';

                    Image = PaymentForecast;

                    RunObject = report "Near Expirery  Batch Numbers";
                    ApplicationArea = All;
                }
                action("Sales")
                {
                    Caption = 'Phamacy Sales';

                    Image = PaymentForecast;

                    RunObject = report "HMS-Sales";
                    ApplicationArea = All;
                }
            }
            group(Reports)
            {
                Caption = 'HMS Reports';
                Image = SNInfo;
                action(Results)
                {
                    Caption = 'Lab results';
                    Image = AddToHome;
                    RunObject = Report "Laboratory Requests Report";
                    ApplicationArea = All;
                }
                action(Observation)
                {
                    Caption = 'Observations';
                    Image = "Report";
                    RunObject = Report "Daily Patient Visit";
                    ApplicationArea = All;
                }
                action("Procedures Report")
                {
                    Image = "Report";
                    RunObject = Report "Clinic Procedures Report";
                    ApplicationArea = All;
                }
                action("Diagnosis Report")
                {
                    Image = "Report";
                    RunObject = Report "Clinic Diagnosis Report";
                    ApplicationArea = All;
                }
                action(Daily_Att_OutPat)
                {
                    Caption = 'HMS Appointments';
                    Image = "Report";
                    RunObject = Report "HMS Appointments Listing";
                    ApplicationArea = All;
                }
                action(DailyClinicRequests)
                {
                    Caption = 'Daily Patient Register';
                    Image = "Report";
                    RunObject = Report "Daily Patient Visit";
                    ApplicationArea = All;
                }
                /*
                 action(labtest2)
                 {
                     Caption = 'Lab Tests Detailed';
                     Image = "Report";


                     RunObject = Report "HMS Laboratory Test Detailed";
                     ApplicationArea = All;
                 }
                 action(labtest3)
                 {
                     Caption = 'Lab tests Findings';
                     Image = "Report";


                     RunObject = Report "HMS Laboratory Test Finding";
                     ApplicationArea = All;
                 }
                 action(pham_Drug_1)
                 {
                     Caption = 'Process Student Patients';
                     Image = "Report";


                     RunObject = Report "HMS Pharmacy Issues Report";
                     ApplicationArea = All;
                 }
                 action(PatList)
                 {
                     Caption = 'Patient listing';
                     Image = "Report";


                     RunObject = Report "HMS Patient Listing Report";
                     ApplicationArea = All;
                 }
                 action(Admission_List)
                 {
                     Caption = 'Admission listing';
                     Image = "Report";


                     RunObject = Report "HMS Admission Listing Summary";
                     ApplicationArea = All;
                 }
                 action(Ref_list)
                 {
                     Caption = 'Referrals Listing';
                     Image = "Report";
                     RunObject = Report "HMS Referral Listing Report";
                     ApplicationArea = All;
                 }
                 action(Daily_Att_OutPat)
                 {
                     Caption = 'Daily Attendance (Outpatient)';
                     Image = "Report";
                     RunObject = Report "HMS Daily Attendance Report";
                     ApplicationArea = All;
                 }
                 action(Inj_Reg)
                 {
                     Caption = 'Injection Register';
                     Image = "Report";


                     RunObject = Report "HMS Injection Register Report";
                     ApplicationArea = All;
                 }
                 action(Proc_Emp_and_Deps)
                 {
                     Caption = 'Appointments';
                     Image = ExecuteAndPostBatch;


                     RunObject = Report "HMS Process Employee & Deps";
                     ApplicationArea = All;
                 }

                 action("Drugs Stock")
                 {
                     Caption = 'Drugs Stock';
                     Image = AddWatch;

                     RunObject = Report "Stock Summary Clinic";
                     ApplicationArea = All;
                 } */
            }
        }
        area(sections)
        {
            group(Registration)
            {
                action("Patients List")
                {
                    Image = Register;

                    RunObject = Page "HMS-Patient List";
                    ApplicationArea = All;
                }
                action("Active  Visits")
                {
                    Image = Register;
                    caption = 'Track Patient Location';
                    RunObject = Page "Patient Location";
                    //RunPageLink = Location  : filter ();
                    ApplicationArea = All;
                }
            }
            group(Appointments2)
            {
                Caption = 'Appointments';
                Image = Statistics;
                action(Appointments)
                {
                    Caption = 'Appointments';
                    Image = Register;
                    RunObject = Page "HMS-Appointment Form List";
                    RunPageLink = Status = filter(New);
                }
                action("Appointments Control")
                {
                    Caption = 'Pending Appointments ';
                    Image = History;
                    RunObject = Page "pending appointments";
                    //RunPageLink = Status = filter(Booked);
                }
                action("Appointments History")
                {
                    Caption = 'Closed Appointments ';
                    Image = History;
                    RunObject = Page "Closed Appointments ";

                }
            }
            // group(ObsRoom)
            // {
            //     Caption = 'Observation Room';
            //     Image = RegisteredDocs;
            //     action(Observations)
            //     {
            //         Caption = 'Observations';
            //         RunObject = Page 68144;
            //     }
            //     action("Observation History")
            //     {
            //         Caption = 'Observation History';
            //         RunObject = Page 68146;
            //     }
            // }
            group(DocVisit)
            {
                Caption = 'Consultation Room';
                Image = Journals;
                action(Observations)
                {
                    Caption = 'Observations';
                    RunObject = Page "HMS-Observations List";
                    ApplicationArea = All;
                }
                action("Observation History")
                {
                    Caption = 'Observation History';
                    RunObject = Page "HMS-Observation History List";
                    ApplicationArea = All;
                }
                action(DocVisits)
                {
                    Caption = 'Doctor''s Visits';
                    Image = Register;
                    RunObject = Page "HMS-Treatment List";
                    ApplicationArea = All;
                }
                action("Doctor's Visit History")
                {
                    Caption = 'Doctor''s Visit History';
                    Image = History;
                    RunObject = Page "HMS-Treatment History List";
                    ApplicationArea = All;
                }
            }
            group(Lab)
            {
                Caption = 'Lab. Visits';
                Image = FiledPosted;
                action(sentrequests)
                {
                    Caption = 'Sent Requests';
                    RunObject = page "HMS-Lab Test Requests list";
                    ApplicationArea = all;
                }
                action("Lab Reagents")
                {
                    ApplicationArea = All;
                    Image = RegisterPutAway;
                    RunObject = page "Lab Reagents";
                }
                action("laboratory Test Templates")
                {
                    Caption = 'laboratory Test Templates';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Lab Test List";
                    ApplicationArea = All;
                }
                /* action(Lab_List)
                {
                    Caption = 'Test Requests';
                    Image = Register;
                    RunObject = Page "HMS Laboratory List";
                    Visible = false;
                    ApplicationArea = All;
                }
                action(findings)
                {
                    Caption = 'Test Findings';
                    Image = History;

                    RunObject = Page "HMS-Laboratory Form List 2";
                    ApplicationArea = All;
                } */
                action(Hist)
                {
                    Caption = 'Lab Visit History';
                    Image = History;
                    RunObject = Page "Lab History list";
                    ApplicationArea = All;
                }
                action(AllSpecimens)
                {
                    Caption = 'All Specimen';
                    Image = History;
                    RunObject = Page AllSpecimentList;
                    ApplicationArea = All;
                }
            }
            group(Pharmacy)
            {
                Caption = 'Pharmacy';
                Image = Departments;


                action(Pharm)
                {
                    Caption = 'Pharmacy List';
                    Image = Register;
                    RunObject = Page "HMS Pharmacy List";
                    ApplicationArea = All;
                }
                action(Pharm_Hist)
                {
                    Caption = 'Pharmacy History';
                    Image = History;
                    RunObject = Page "HMS-Treatment Form List 2";
                    ApplicationArea = All;
                }
                action("Posted Pharmacy List")
                {
                    Caption = 'Posted Pharmacy List';
                    RunObject = Page "HMS-Pharmacy Posted";
                    ApplicationArea = All;
                }
                action("Drug List")
                {
                    Caption = 'Main Store Drug List';
                    RunObject = Page "Drug List";
                    ApplicationArea = All;
                }
                action("Issued Drugs From Main Store")
                {
                    Caption = 'Main Store Drug List';
                    RunObject = Page "pharmacy issued";

                    ApplicationArea = All;
                }
                action("Pharmacy Store")
                {
                    Caption = 'Pharmacy Store';
                    ApplicationArea = All;
                    Image = DistributionGroup;
                    RunObject = Page "Pharmacy Items";
                }
                action("Non-Pharms Store")
                {
                    Caption = 'Non-Pharmaciticals';
                    ApplicationArea = All;
                    Image = DistributionGroup;
                    RunObject = Page "Non-Pharmaciticals";

                }
                action("Addjust Store")
                {
                    ApplicationArea = All;
                    Image = DistributionGroup;
                    RunObject = Page "Pharmacy Stock Header List";
                }
                action("Drug Batch Near Expiry")
                {
                    Caption = 'Drug Batch Near Expiry';
                    ApplicationArea = All;
                    Image = DistributionGroup;
                    RunObject = Page "expiry drugs";
                }
                action("Pharmacy Request")
                {
                    ApplicationArea = All;
                    Image = ApplyTemplate;
                    RunObject = Page "Pharmacy Request List";
                }

            }
            group("Items Disposal")
            {
                Caption = 'Items Disposal';
                action("Items Disposal List")
                {
                    ApplicationArea = All;
                    Image = ApplyTemplate;
                    RunObject = Page "Item Disposal List";
                    RunPageView = where(Status = filter(Open | "Pending Approval"));

                }
                action("Approved Disposal")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Disposal';
                    RunObject = Page "Item Disposal List";
                    RunPageView = where(Status = filter(Approved));
                }
                action("Rejected Disposal")
                {
                    ApplicationArea = All;
                    Caption = 'Rejected Disposal';
                    RunObject = Page "Item Disposal List";
                    RunPageView = where(Status = filter(rejected));
                }
            }
            group("Items Transfer")
            {
                action("Items Transfer List")
                {
                    ApplicationArea = All;
                    Image = ApplyTemplate;
                    RunObject = Page "Item Transfer List";
                    RunPageView = where("Approval Status" = filter(Open | Pending));
                }
                action("Approved Transfer")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Transfer';
                    RunObject = Page "Item Transfer List";
                    RunPageView = where("Approval Status" = filter(Approved));
                }
                action("Rejected Transfer")
                {
                    ApplicationArea = All;
                    Caption = 'Rejected Transfer';
                    RunObject = Page "Item Transfer List";
                    RunPageView = where("Approval Status" = filter(rejected));
                }
                action("Posted Transfer")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Transfer';
                    RunObject = Page "Item Transfer List";
                    RunPageView = where(Status = filter(Posted));
                }
            }
            group("Medical Claims")
            {
                Caption = 'Medical Claims';
                action("Medical Schemes")
                {
                    ApplicationArea = All;
                    Caption = 'Medical Schemes';
                    RunObject = Page "Medical Schemes";
                }
                action("Medical Facilities")
                {
                    ApplicationArea = All;
                    Caption = 'Medical Facilities';
                    RunObject = Page "Medical Facilities";
                }
                action("Medical & Claims")
                {
                    ApplicationArea = All;
                    Caption = 'Medical Claims';
                    RunObject = Page "Medical Claims List";
                }
                group("Batch Claims")
                {
                    action("Medical Claim Batches")
                    {
                        Caption = 'Medical Claim Batches';
                        ApplicationArea = All;
                        Image = CalculateSimulation;
                        RunObject = Page "Medical Claims Batch List";
                    }
                }
            }

            group(HMS_Admissions)
            {
                Caption = 'Admissions';
                Image = LotInfo;
                Visible = false;
                action(Pat_Admissions)
                {
                    Caption = 'Patient Admissions';
                    Image = Register;
                    RunObject = Page "HMS-Admission Form Header List";
                    ApplicationArea = All;
                }
                action("Admission Progress")
                {
                    Caption = 'Admission Progress';
                    Image = History;
                    RunObject = Page "HMS-Admission Progress List";
                    ApplicationArea = All;
                }
            }

            group(Setups)
            {
                Caption = 'Hospital Setups';
                Image = SNInfo;
                /* action(HMSNumSet)
                {
                    Caption = 'HMS Setup';
                    RunObject = page "HMS-Setup Card List";
                    
                } */

                action(ImmunHist)
                {
                    Caption = 'Immunization History';
                    Image = History;
                    RunObject = Page "HMS-Immunization Posted List";
                    ApplicationArea = All;
                }
                action(Setup)
                {
                    Caption = 'Setup Card';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Card";
                    ApplicationArea = All;
                }
                action(Lab_test)
                {
                    Caption = 'laboratory Test Templates';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Lab Test List";
                    ApplicationArea = All;
                }
                action(Systems_Card)
                {
                    Caption = 'Systems Card';
                    Image = SetupList;

                    RunObject = Page "HMS-Systems Card";
                    ApplicationArea = All;
                }
                action(Setup_Doctor)
                {
                    Caption = 'Setup Doctor';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Doctor Card";
                    ApplicationArea = All;
                }
                action(Setup_Blood_Group)
                {
                    Caption = 'Setup Blood Group';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Blood Group Card";
                    ApplicationArea = All;
                }
                action(Blood_Group_Donation)
                {
                    Caption = 'Blood Group Donation';
                    Image = SetupList;

                    RunObject = Page "HMS-Blood Group Donation Card";
                    ApplicationArea = All;
                }
                action(Drug_Interaction)
                {
                    Caption = 'Drug Interaction';
                    Image = SetupList;

                    RunObject = Page "HMS Drug Interaction Header";
                    ApplicationArea = All;
                }
                action(Observation_Signs)
                {
                    Caption = 'Observation Signs';
                    Image = SetupList;

                    RunObject = Page "HMS Observation Signs";
                    ApplicationArea = All;
                }
                action(Appointment_Typ)
                {
                    Caption = 'Appointment Type';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Appointment Typ Card";
                    ApplicationArea = All;
                }
                action(Triage)
                {
                    Caption = 'Triage Tests Setup';
                    Image = SetupList;

                    //RunObject = Page 68097;
                    ApplicationArea = All;
                }
                action("Setup Process")
                {
                    Caption = 'Process Setup';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Process Card";
                    ApplicationArea = All;
                }
                action(Injection)
                {
                    Caption = 'Injection';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Injection Card";
                    ApplicationArea = All;
                }
                action(Diagnosis)
                {
                    Caption = 'Diagnosis';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Diagnosis Card";
                    ApplicationArea = All;
                }
                action(Allergy)
                {
                    Caption = 'Allergy';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Allergy Card";
                    ApplicationArea = All;
                }
                action(signs)
                {
                    Caption = 'Signs';
                    Image = SetupList;

                    RunObject = Page "HMS Signs";
                    ApplicationArea = All;
                }
                action(Symptoms)
                {
                    Caption = 'Symptoms';
                    Image = SetupList;

                    RunObject = Page "HMS Syptoms";
                    ApplicationArea = All;
                }
                action(messuring_Uni)
                {
                    Caption = 'Measuring Units';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Measuring Unit Card";
                    ApplicationArea = All;
                }
                action(specimen)
                {
                    Caption = 'Specimen Card';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Specimen Card";
                    ApplicationArea = All;
                }

                action(Rad_Types)
                {
                    Caption = 'Radiology Types';
                    Image = SetupList;

                    RunObject = Page "HMS-Setup Radiology Type Card";
                    ApplicationArea = All;
                }
                action(Setup_Disctarge_Process)
                {
                    Caption = 'Setup Discharge Process';
                    Image = SetupList;

                    RunObject = Page "HMS Setup Disctarge Process";
                    ApplicationArea = All;
                }
                action(wards)
                {
                    Caption = 'Ward Setup';
                    Image = SetupList;

                    RunObject = Page "HMS ward Setup";
                    ApplicationArea = All;
                }
                action(Beds)
                {
                    Caption = 'Beds';
                    Image = SetupList;

                    RunObject = Page "HMS Beds";
                    ApplicationArea = All;
                }
                action(Hos_Charges)
                {
                    Caption = 'Hospital Charges Setup';
                    Image = SetupList;

                    RunObject = Page "HMS-Hospital Charges Setup";
                    ApplicationArea = All;
                }
            }
            group(Refs)
            {
                Caption = 'Referrals';
                Image = RegisteredDocs;
                Visible = true;
                action(ref)
                {
                    Caption = 'Referrals';
                    Image = Register;
                    RunObject = Page "HMS-Referral Header List";
                    ApplicationArea = All;
                }
                action(ref_Hist)
                {
                    Caption = 'Referrals History';
                    Image = History;

                    RunObject = Page "HMS-Referral Header List2";
                    ApplicationArea = All;
                }
            }
            group(Immuns)
            {
                Caption = 'Immunizations';
                Image = ReferenceData;
                action(Immun)
                {
                    Caption = 'Immunizations';
                    Image = Register;
                    RunObject = Page "HMS-Immunization Header List";
                    ApplicationArea = All;
                }
                action(Immun_History)
                {
                    Caption = 'Immunizations History';
                    Image = History;

                    RunObject = Page "HMS-Immunization Posted List";
                    ApplicationArea = All;
                }
            }
            group(Billing)
            {
                Caption = 'Hospital Billing';
                Image = Intrastat;
                action("Patient Billing")
                {
                    Caption = 'Patient Billing';
                    Image = Insurance;

                    RunObject = Page "HMS-Patient Billing";
                    ApplicationArea = All;
                }
                action(Hospital_Customer_List)
                {
                    Caption = 'Hospital Customer List';
                    RunObject = Page "HMS-Customers List";
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                    ApplicationArea = All;
                }
                action("Clearance Requests")
                {
                    Caption = 'Clearance Requests';
                    RunObject = Page "ACA-Clearance Approval Entries";
                    ApplicationArea = All;
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {
                    Caption = 'Stores Requisitions';
                    RunObject = Page "PROC-Store Requisition";
                    ApplicationArea = All;
                }
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "FIN-Imprests List";
                    ApplicationArea = All;
                }
                action("Leave Applications")
                {
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                    ApplicationArea = All;
                }

                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                    ApplicationArea = All;
                }
                action("Claim  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Claim Requisitions';
                    RunObject = Page "FIN-Staff Claim List";
                    ToolTip = 'Create Claim requisition from Users.';
                }
                action(Action1000000003)
                {
                    ApplicationArea = all;
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                }
                action("Purchase  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Requisitions';
                    RunObject = Page "FIN-Purchase Requisition";
                    ToolTip = 'Create purchase requisition from departments.';
                }
                action("Transport Requisition")
                {
                    ApplicationArea = All;
                    Image = MapAccounts;
                    RunObject = Page "FLT-Transport Req. List";
                }
                action("Pharmacy Requests")
                {
                    ApplicationArea = All;
                    Image = ApplyTemplate;
                    RunObject = Page "Pharmacy Request List";
                }

            }
        }
    }
}

