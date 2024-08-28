report 50734 "HMS Process Employee & Deps"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSProcessEmployeeDeps.rdl';
    ProcessingOnly = false;

    dataset
    {
        dataitem(DataItem5769; "HMS-Patient")
        {
            DataItemTableView = SORTING("Patient No.");
            RequestFilterFields = "Patient No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(USERID; USERID)
            {
            }
            column(HMS_Patient__Patient_No__; "Patient No.")
            {
            }
            column(HMS_Patient__Patient_No___Control1102760011; "Patient No.")
            {
            }
            column(HMS_Patient__Date_Registered_; "Date Registered")
            {
            }
            column(HMS_Patient__Patient_Type_; "Patient Type")
            {
            }
            column(HMS_Patient__Employee_No__; "Employee No.")
            {
            }
            column(HMS_Patient__Relative_No__; "Relative No.")
            {
            }
            column(HMS_Patient_Title; Title)
            {
            }
            column(HMS_Patient_Surname; Surname)
            {
            }
            column(HMS_Patient__Middle_Name_; "Middle Name")
            {
            }
            column(HMS_Patient__Last_Name_; "Last Name")
            {
            }
            column(HMS_Patient_Gender; Gender)
            {
            }
            column(HMS_Patient__Date_Of_Birth_; "Date Of Birth")
            {
            }
            column(HMS_PatientCaption; HMS_PatientCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HMS_Patient__Patient_No___Control1102760011Caption; FIELDCAPTION("Patient No."))
            {
            }
            column(HMS_Patient__Date_Registered_Caption; FIELDCAPTION("Date Registered"))
            {
            }
            column(HMS_Patient__Patient_Type_Caption; FIELDCAPTION("Patient Type"))
            {
            }
            column(HMS_Patient__Employee_No__Caption; FIELDCAPTION("Employee No."))
            {
            }
            column(HMS_Patient__Relative_No__Caption; FIELDCAPTION("Relative No."))
            {
            }
            column(HMS_Patient_TitleCaption; FIELDCAPTION(Title))
            {
            }
            column(HMS_Patient_SurnameCaption; FIELDCAPTION(Surname))
            {
            }
            column(HMS_Patient__Middle_Name_Caption; FIELDCAPTION("Middle Name"))
            {
            }
            column(HMS_Patient__Last_Name_Caption; FIELDCAPTION("Last Name"))
            {
            }
            column(HMS_Patient_GenderCaption; FIELDCAPTION(Gender))
            {
            }
            column(HMS_Patient__Date_Of_Birth_Caption; FIELDCAPTION("Date Of Birth"))
            {
            }
            column(HMS_Patient__Patient_No__Caption; FIELDCAPTION("Patient No."))
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Patient No.");
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

    trigger OnPreReport()
    begin
        //HMSPatient.CopyEmployeeToHMS();
        //HMSPatient.CopyDependantToHMS();
        HMSPatient.CopyBeneficiarytToHMS();
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        HMSPatient: Codeunit "HMS Patient";
        HMS_PatientCaptionLbl: Label 'HMS Patient';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

