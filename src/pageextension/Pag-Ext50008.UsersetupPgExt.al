pageextension 50008 UsersetupPgExt extends "User Setup"
{
    layout
    {
        addbefore("Allow Posting To")
        {
            field("Can Extend Surrender Period"; Rec."Can Extend Surrender Period")
            {
                ApplicationArea = all;
            }
            field(HOD; Rec.HOD)
            {
                ApplicationArea = all;
            }
        }
        addafter("Allow Posting To")
        {
            field("Approver ID"; Rec."Approver ID")
            {
                ApplicationArea = All;
            }
        }
        addafter(PhoneNo)
        {
            field(payroll; Rec.Leave)
            {
                ApplicationArea = all;

            }
            field("Can Post Customer Refund"; Rec."Can Post Customer Refund")
            {
                ApplicationArea = all;

            }
            field("Can Post Cust. Deposits"; Rec."Can Post Cust. Deposits")
            {
                ApplicationArea = all;

            }
            field("User Signature"; Rec."User Signature")
            {
                ApplicationArea = All;
            }
            field("Approval Title"; Rec."Approval Title")
            {
                ApplicationArea = All;
                Caption = 'Designation';
            }
            field("Approval Role"; Rec."Approval Role")
            {
                ApplicationArea = All;
            }
            field("Proffessional OP"; Rec."Proffessional OP")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Proffessional OP field.', Comment = '%';
            }
            field("Accounting Officer"; Rec."Accounting Officer")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Accounting Officer field.', Comment = '%';
            }
            field("Can View Payroll"; rec."Can View Payroll")
            {
                ApplicationArea = All;

            }
            field("Allow Change Company"; Rec."Allow Change Company")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Change Company field.';
            }
            field("Allow Open My Settings"; Rec."Allow Open My Settings")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Open My Settings field.';
            }
            field("Allow Change Role"; Rec."Allow Change Role")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Change Role field.';
            }
            field("Allow Change Work Day"; Rec."Allow Change Work Day")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Change Work Day field.';
            }

            field("Can Reverse Sales"; Rec."Can Reverse Sales")
            {
                ToolTip = 'Specifies the value of the Can Reverse Sales field.';
                ApplicationArea = All;
            }
            field("Can Process Graduation"; Rec."Can Process Graduation")
            {
                ToolTip = 'Specifies the value of the Can Process Graduation field.';
                ApplicationArea = All;
            }

            field("Can Stop Reg."; Rec."Can Stop Reg.")
            {
                ToolTip = 'Specifies the value of the Can Stop Reg. field.';
                ApplicationArea = All;
            }
            field("Can Process Senate Marks"; Rec."Can Process Senate Marks")
            {
                ToolTip = 'Specifies the value of the Can Process Senate Marks field.';
                ApplicationArea = All;
            }
            field("Can Edit Semester"; Rec."Can Edit Semester")
            {
                ToolTip = 'Specifies the value of the Can Edit Semester field.';
                ApplicationArea = All;
            }
            field("Can Upload Marks"; Rec."Can Upload Marks")
            {
                ToolTip = 'Specifies the value of the Can Upload Marks field.';
                ApplicationArea = All;
            }

            field("Staff No"; Rec."Staff No")
            {
                ToolTip = 'Specifies the value of the Staff No field.';
                ApplicationArea = All;
            }
            field(Leave; Rec.Leave)
            {
                ToolTip = 'Specifies the value of the Leave field.';
                ApplicationArea = All;
            }
            field(Lecturer; Rec.Lecturer)
            {
                ToolTip = 'Specifies the value of the Lecturer field.';
                ApplicationArea = All;
            }
            field("Employee No."; Rec."Employee No.")
            {
                ToolTip = 'Specifies the value of the Employee No. field.';
                ApplicationArea = All;
            }
            field("Create Salary"; Rec."Create Salary")
            {
                ToolTip = 'Specifies the value of the Create Salary field.';
                ApplicationArea = All;
            }
            field("Create GL"; Rec."Create GL")
            {
                ToolTip = 'Specifies the value of the Create GL field.';
                ApplicationArea = All;
            }
            field("Create FA"; Rec."Create FA")
            {
                ToolTip = 'Specifies the value of the Create FA field.';
                ApplicationArea = All;
            }
            field("Create Items"; Rec."Create Items")
            {
                ToolTip = 'Specifies the value of the Create Items field.';
                ApplicationArea = All;
            }
            field("Create Customer"; Rec."Create Customer")
            {
                ToolTip = 'Specifies the value of the Create Customer field.';
                ApplicationArea = All;
            }
            field("Create Course_Reg"; Rec."Create Course_Reg")
            {
                ToolTip = 'Specifies the value of the Create Course_Reg field.';
                ApplicationArea = All;
            }

            field("Approve Results Cancellation"; Rec."Approve Results Cancellation")
            {
                ToolTip = 'Specifies the value of the Approve Results Cancellation field.';
                ApplicationArea = All;
            }
            field("Approve Payroll Closure"; Rec."Approve Payroll Closure")
            {
                ToolTip = 'Specifies the value of the Approve Payroll Closure field.';
                ApplicationArea = All;
            }
            field("Create Emp. Transactions"; Rec."Create Emp. Transactions")
            {
                ToolTip = 'Specifies the value of the Create Emp. Transactions field.';
                ApplicationArea = All;
            }
            field("Create Employee"; Rec."Create Employee")
            {
                ToolTip = 'Specifies the value of the Create Employee field.';
                ApplicationArea = All;
            }
            field("Create PR Transactions"; Rec."Create PR Transactions")
            {
                ToolTip = 'Specifies the value of the Create PR Transactions field.';
                ApplicationArea = All;
            }
            field("Create Supplier"; Rec."Create Supplier")
            {
                ToolTip = 'Specifies the value of the Create Supplier field.';
                ApplicationArea = All;
            }
            field("Imprest Account"; Rec."Imprest Account")
            {
                ToolTip = 'Specifies the value of the Imprest Account field.';
                ApplicationArea = All;
            }
            field("Imprest Amount Approval Limit"; Rec."Imprest Amount Approval Limit")
            {
                ToolTip = 'Specifies the value of the Imprest Amount Approval Limit field.';
                ApplicationArea = All;
            }
            field("Initiate Results Cancellation"; Rec."Initiate Results Cancellation")
            {
                ToolTip = 'Specifies the value of the Initiate Results Cancellation field.';
                ApplicationArea = All;
            }
            field("Petty C Amount Approval Limit"; Rec."Petty C Amount Approval Limit")
            {
                ToolTip = 'Specifies the value of the Petty C Amount Approval Limit field.';
                ApplicationArea = All;
            }
            field("PV Amount Approval Limit"; Rec."PV Amount Approval Limit")
            {
                ToolTip = 'Specifies the value of the PV Amount Approval Limit field.';
                ApplicationArea = All;
            }
            field("Purchase Amount Approval Limit"; Rec."Purchase Amount Approval Limit")
            {
                ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                ApplicationArea = All;
            }
            field("Request Amount Approval Limit"; Rec."Request Amount Approval Limit")
            {
                ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                ApplicationArea = All;
            }
            field("Revoke Results Cancellation"; Rec."Revoke Results Cancellation")
            {
                ToolTip = 'Specifies the value of the Revoke Results Cancellation field.';
                ApplicationArea = All;
            }
            field("Sales Amount Approval Limit"; Rec."Sales Amount Approval Limit")
            {
                ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                ApplicationArea = All;
            }
            field("Store Req. Amt Approval Limit"; Rec."Store Req. Amt Approval Limit")
            {
                ToolTip = 'Specifies the value of the Store Req. Amt Approval Limit field.';
                ApplicationArea = All;
            }
            field("ReOpen/Release"; Rec."ReOpen/Release")
            {
                ToolTip = 'Specifies the value of the ReOpen/Release field.';
                ApplicationArea = All;
            }
            field("Post Bank Rec"; Rec."Post Bank Rec")
            {
                ToolTip = 'Specifies the value of the Post Bank Rec field.';
                ApplicationArea = All;
            }
            field(Registrar;Rec.Registrar)
            {
                ApplicationArea = All;
            }
            field("Procurement Notification";Rec."Procurement Notification")
            {
                ApplicationArea = All;
            }

        }
    }
    actions
    {
        addlast(Processing)
        {
            action(UserSignature)
            {
                Caption = 'Import Signature';
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "APP-User-Setup Signatures";
                RunPageLink = "User ID" = field("User ID");
            }
        }

    }
}
