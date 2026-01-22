report 50737 "HMS Referral Request Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSReferralRequestForm.rdl';

    dataset
    {
        dataitem(DataItem3701; "HMS-Treatment Form Header")
        {
            DataItemTableView = SORTING("Treatment No.");
            RequestFilterFields = "Treatment No.";
            column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
            {
            }
            column(UPPERCASE_Company__Post_Code__; UPPERCASE(Company."Post Code"))
            {
            }
            column(TEL____Company__Phone_No___________Company__Phone_No__2_; 'TEL:' + Company."Phone No." + '/' + Company."Phone No. 2")
            {
            }
            column(UPPERCASE_Company_City_; UPPERCASE(Company.City))
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(HMS_Treatment_Form_Header__Treatment_No__; "Treatment No.")
            {
            }
            column(Age; Age)
            {
            }
            column(Sex______Gender; 'Sex: ')
            {
            }
            column(Name_of_Patient______UPPERCASE_PatientName_; 'Name of Patient: ' + UPPERCASE(PatientName))
            {
            }
            column(PF_NO______PFNo; 'PF/NO: ' + PFNo)
            {
            }
            column(Department___; 'Department: ')
            {
            }
            column(Doctors_Name______DoctorName; 'Doctors Name: ' + DoctorName)
            {
            }
            column(University_HEALTH_SERVICESCaption; University_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(X_RAY_REQUEST_FORMCaption; X_RAY_REQUEST_FORMCaptionLbl)
            {
            }
            column(Our_Ref_Caption; Our_Ref_CaptionLbl)
            {
            }
            column(DataItem1102760012; To______________________________________________________________________________________Lbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102760014; EmptyStringCaption_Control1102760014Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760015; EmptyStringCaption_Control1102760015Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760016; EmptyStringCaption_Control1102760016Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760017; EmptyStringCaption_Control1102760017Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760018; EmptyStringCaption_Control1102760018Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760022; EmptyStringCaption_Control1102760022Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760023; EmptyStringCaption_Control1102760023Lbl)
            {
            }
            column(Sign_Caption; Sign_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102760029; EmptyStringCaption_Control1102760029Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760030; EmptyStringCaption_Control1102760030Lbl)
            {
            }
            column(Radiologist_Report_Caption; Radiologist_Report_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102760035; EmptyStringCaption_Control1102760035Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760036; EmptyStringCaption_Control1102760036Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760037; EmptyStringCaption_Control1102760037Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760038; EmptyStringCaption_Control1102760038Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760039; EmptyStringCaption_Control1102760039Lbl)
            {
            }
            column(Sign_Caption_Control1102760040; Sign_Caption_Control1102760040Lbl)
            {
            }
            column(Date_Caption_Control1102760041; Date_Caption_Control1102760041Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760042; EmptyStringCaption_Control1102760042Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760043; EmptyStringCaption_Control1102760043Lbl)
            {
            }
            dataitem(DataItem6636; "HMS-Treatment Referral")
            {
                DataItemLink = "Treatment No." = FIELD("Treatment No.");
            }

            trigger OnAfterGetRecord()
            begin
                Patient.RESET;
                PatientName := '';
                Age := '';
                //Gender := '';

                IF Patient.GET("Patient No.") THEN BEGIN
                    PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                    Gender := Patient.Gender;
                    IF Patient."Patient Type" = Patient."Patient Type"::Others THEN BEGIN
                        PFNo := Patient."Student No.";
                    END
                    ELSE
                        IF Patient."Patient Type" = Patient."Patient Type"::" " THEN BEGIN
                            PFNo := Patient."Patient No.";
                        END
                        ELSE BEGIN
                            PFNo := Patient."Employee No.";
                        END;
                    IF Patient."Date Of Birth" = 0D THEN BEGIN
                        Age := 'Age:';
                    END
                    ELSE BEGIN
                        Age := HRDates.DetermineAge(Patient."Date Of Birth", TODAY);
                    END;
                END;

                DoctorName := '';
                Doctor.RESET;
                IF Doctor.GET("HMS-Treatment Form Header"."Doctor ID") THEN BEGIN
                    Doctor.CALCFIELDS(Doctor."Doctor's Name");
                    DoctorName := Doctor."Doctor's Name";
                END;
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
        Company.RESET;
        Company.GET();
    end;

    var
        Company: Record 79;
        Patient: Record "HMS-Patient";
        "HMS-Treatment Form Header": Record "HMS-Treatment Form Header";
        Age: Text[100];
        Gender: Text[100];
        HRDates: Codeunit "Hr Dates";
        PatientName: Text[100];
        PFNo: Code[20];
        Department: Text[100];
        Doctor: Record "HMIS-Visits/Registrations";
        DoctorName: Text[100];
        University_HEALTH_SERVICESCaptionLbl: Label 'University HEALTH SERVICES';
        Date_CaptionLbl: Label 'Date:';
        X_RAY_REQUEST_FORMCaptionLbl: Label 'X-RAY REQUEST FORM';
        Our_Ref_CaptionLbl: Label 'Our Ref:';
        To______________________________________________________________________________________Lbl: Label 'To:...............................................................................................................................';
        EmptyStringCaptionLbl: Label '...............................................................................................................................';
        EmptyStringCaption_Control1102760014Lbl: Label '...............................................................................................................................';
        EmptyStringCaption_Control1102760015Lbl: Label '...............................................................................................................................';
        EmptyStringCaption_Control1102760016Lbl: Label '__________________________________________________________________________________________________________________';
        EmptyStringCaption_Control1102760017Lbl: Label '__________________________________________________________________________________________________________________';
        EmptyStringCaption_Control1102760018Lbl: Label '__________________________________________________________________________________________________________________';
        EmptyStringCaption_Control1102760022Lbl: Label '__________________________________________________________________________________________________________________';
        EmptyStringCaption_Control1102760023Lbl: Label '__________________________________________________________________________________________________________________';
        Sign_CaptionLbl: Label 'Sign:';
        EmptyStringCaption_Control1102760029Lbl: Label '__________________________________________________________________________________________________________________';
        EmptyStringCaption_Control1102760030Lbl: Label '__________________________________________________________________________________________________________________';
        Radiologist_Report_CaptionLbl: Label 'Radiologist Report:';
        EmptyStringCaption_Control1102760035Lbl: Label '............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................';
        EmptyStringCaption_Control1102760036Lbl: Label '............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................';
        EmptyStringCaption_Control1102760037Lbl: Label '............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................';
        EmptyStringCaption_Control1102760038Lbl: Label '............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................';
        EmptyStringCaption_Control1102760039Lbl: Label '............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................';
        Sign_Caption_Control1102760040Lbl: Label 'Sign:';
        Date_Caption_Control1102760041Lbl: Label 'Date:';
        EmptyStringCaption_Control1102760042Lbl: Label '............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................';
        EmptyStringCaption_Control1102760043Lbl: Label '............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................';
}

