report 50177 "Leave Applications"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Leave Applications.rdl';

    dataset
    {
        dataitem("HRM-Employee C"; "HRM-Employee C")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            /* column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            } */
            column(USERID; UserId)
            {
            }
            column(HR_Employee_C__Last_Name_; "Last Name")
            {
            }
            column(HR_Employee_C__Middle_Name_; "Middle Name")
            {
            }
            column(HR_Employee_C__First_Name_; "First Name")
            {
            }
            column(HR_Employee_C__No__; "No.")
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Employee_C__Last_Name_Caption; FieldCaption("Last Name"))
            {
            }
            column(HR_Employee_C__Middle_Name_Caption; FieldCaption("Middle Name"))
            {
            }
            column(HR_Employee_C__First_Name_Caption; FieldCaption("First Name"))
            {
            }
            column(HR_Employee_C__No__Caption; FieldCaption("No."))
            {
            }

            column(LeaveCaption; LeaveCaptionLbl)
            {
            }
            column(CommentCaption; CommentCaptionLbl)
            {
            }
            dataitem("HRM-Emp. Leave Application"; "HRM-Emp. Leave Application")
            {
                DataItemLink = "Employee No" = FIELD("No.");
                column(Employee_Leave_Application__Application_Code_; "Application Code")
                {
                }
                column(Employee_Leave_Application__Leave_Code_; "Leave Code")
                {
                }
                column(Employee_Leave_Application__Days_Applied_; "Days Applied")
                {
                }
                column(Employee_Leave_Application__Start_Date_; "Start Date")
                {
                }
                column(Employee_Leave_Application__End_Date_; "End Date")
                {
                }
                column(Employee_Leave_Application__Application_Date_; "Application Date")
                {
                }
                column(Employee_Leave_Application__Approved_Days_; "Approved Days")
                {
                }
                column(Employee_Leave_Application__Approved_Start_Date_; "Approved Start Date")
                {
                }
                column(Employee_Leave_Application__Verified_By_Manager_; "Verified By Manager")
                {
                }
                column(Employee_Leave_Application__Verification_Date_; "Verification Date")
                {
                }
                column(Employee_Leave_Application_Status; Status)
                {
                }
                column(Employee_Leave_Application__Approved_End_Date_; "Approved End Date")
                {
                }
                column(Employee_Leave_Application__Approval_Date_; "Approval Date")
                {
                }
                column(Employee_Leave_Application_Comments; Comments)
                {
                }
                column(Employee_Leave_Application_Employee_No; "Employee No")
                {
                }
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        EmployeeCaptionLbl: Label 'Employee';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        LeaveCaptionLbl: Label 'Leave';
        CommentCaptionLbl: Label 'Comment';
}

