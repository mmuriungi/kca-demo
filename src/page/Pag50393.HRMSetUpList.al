page 50393 "HRM-SetUp List"
{
    CardPageID = "HRM-Setup";
    PageType = List;
    SourceTable = "HRM-Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Nos."; Rec."Employee Nos.")
                {
                    ApplicationArea = all;
                }
                field("Training Application Nos."; Rec."Training Application Nos.")
                {
                    ApplicationArea = all;
                }
                field("Leave Application Nos."; Rec."Leave Application Nos.")
                {
                    ApplicationArea = all;
                }
                field("Leave Planner Nos."; Rec."Leave Planner Nos.")
                {
                    ApplicationArea = All;
                }
                field("Disciplinary Cases Nos."; Rec."Disciplinary Cases Nos.")
                {
                    ApplicationArea = all;
                }
                field("Base Calendar"; Rec."Base Calendar")
                {
                    ApplicationArea = all;
                }

                field("Employee Requisition Nos."; Rec."Employee Requisition Nos.")
                {
                    ApplicationArea = all;
                }
                field("Leave Posting Period[FROM]"; Rec."Leave Posting Period[FROM]")
                {
                    ApplicationArea = all;
                }
                field("Leave Posting Period[TO]"; Rec."Leave Posting Period[TO]")
                {
                    ApplicationArea = all;
                }
                field("Job Application Nos"; Rec."Job Application Nos")
                {
                    ApplicationArea = all;
                }
                field("Exit Interview Nos"; Rec."Exit Interview Nos")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Nos"; Rec."Appraisal Nos")
                {
                    ApplicationArea = all;
                }
                field("Company Activities"; Rec."Company Activities")
                {
                    ApplicationArea = all;
                }
                field("Pay-change No."; Rec."Pay-change No.")
                {
                    ToolTip = 'Specifies the value of the Pay-change No. field.';
                    ApplicationArea = All;
                }
                field("Induction Nos"; Rec."Induction Nos")
                {
                    ApplicationArea = all;
                }
                field("Medical Claims Nos"; Rec."Medical Claims Nos")
                {
                    ApplicationArea = all;
                }
                field("Medical Claims Batch Nos."; Rec."Medical Claims Batch Nos.")
                {
                    ApplicationArea = all;
                }
                field("Medical Scheme Nos"; Rec."Medical Scheme Nos")
                {
                    ApplicationArea = all;
                }
                field("Days To Retirement"; Rec."Days To Retirement")
                {
                    ApplicationArea = all;
                }
                field("Retirement Age"; Rec."Retirement Age")
                {
                    ApplicationArea = all;
                }
                field("Back To Office Nos."; Rec."Back To Office Nos.")
                {
                    ApplicationArea = all;
                }
                field("TNA Nos."; Rec."TNA Nos.")
                {
                    ApplicationArea = all;
                }
                field("Pension Nos."; Rec."Pension Nos.")
                {
                    ApplicationArea = all;
                }
                field("Further Info Nos"; Rec."Further Info Nos")
                {
                    ApplicationArea = all;
                }
                field("Transport Requisition No"; Rec."Transport Requisition No")
                {
                    ApplicationArea = all;
                }

                field("Vehicle Nos"; Rec."Vehicle Nos")
                {
                    ApplicationArea = all;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = all;
                }
                field("Work Ticket No."; rec."Work Ticket No.")
                {
                    ApplicationArea = all;
                }
                field("Venue Booking"; rec."Venue Booking")
                {
                    ApplicationArea = all;
                }
                field("Fuel Register"; rec."Fuel Register")
                {
                    ApplicationArea = all;
                }
                field("Maintenance No"; rec."Maintenance No")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

