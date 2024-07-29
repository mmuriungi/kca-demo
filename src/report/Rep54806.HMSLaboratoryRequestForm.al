report 54806 "HMS Laboratory Request Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSLaboratoryRequestForm.rdl';

    dataset
    {
        dataitem(DataItem3701; "HMS-Treatment Form Header")
        {
            DataItemTableView = SORTING("Treatment No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Treatment No.";
            column(FORMAT__Treatment_Date__0_4_; FORMAT("Treatment Date", 0, 4))
            {
            }
            column(HMS_Treatment_Form_Header__Patient_No__; "Patient No.")
            {
            }
            column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
            {
            }
            column(Patient_Surname_________Patient__Middle_Name__________Patient__Last_Name_; Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name")
            {
            }
            column(AgeText; AgeText)
            {
            }
            column(Gender; Gender)
            {
            }
            column(HMS_Treatment_Form_Header__Treatment_Remarks_; "Treatment Remarks")
            {
            }
            column(LabNo; LabNo)
            {
            }
            column(DoctorName; DoctorName)
            {
            }
            column(University_HEALTH_SERVICESCaption; University_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(LABORATORY_REQUEST_FORMCaption; LABORATORY_REQUEST_FORMCaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(Department_Caption; Department_CaptionLbl)
            {
            }
            column(Age_Caption; Age_CaptionLbl)
            {
            }
            column(Gender_Caption; Gender_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(PF_No__Caption; PF_No__CaptionLbl)
            {
            }
            column(Clinical_NotesCaption; Clinical_NotesCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(Date_DueCaption; Date_DueCaptionLbl)
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(Request_No__Caption; Request_No__CaptionLbl)
            {
            }
            column(Doctor_s_NameCaption; Doctor_s_NameCaptionLbl)
            {
            }
            column(HMS_Treatment_Form_Header_Treatment_No_; "Treatment No.")
            {
            }
            dataitem(DataItem2412; "HMS-Treatment Form Laboratory")
            {
                DataItemLink = "Treatment No." = FIELD("Treatment No.");
                column(HMS_Treatment_Form_Laboratory__Laboratory_Test_Package_Code_; "Laboratory Test Package Code")
                {
                }
                column(HMS_Treatment_Form_Laboratory__Laboratory_Test_Package_Name_; "Laboratory Test Package Name")
                {
                }
                column(HMS_Treatment_Form_Laboratory__Date_Due_; "Date Due")
                {
                }
                column(HMS_Treatment_Form_Laboratory_Results; Results)
                {
                }
                column(HMS_Treatment_Form_Laboratory_Treatment_No_; "Treatment No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Patient.RESET;
                PatientName := '';
                IF Patient.GET("Patient No.") THEN BEGIN
                    PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                    AgeText := HRDates.DetermineAge(Patient."Date Of Birth", TODAY);
                    Gender := Patient.Gender;
                END;
                Doctor.RESET;
                IF Doctor.GET("Doctor ID") THEN BEGIN
                    Doctor.CALCFIELDS(Doctor."Doctor's Name");
                    DoctorName := Doctor."Doctor's Name";
                END;
                /*Get the laboratory request number from the laboratory table*/
                Lab.RESET;
                Lab.SETRANGE(Lab."Link Type", 'TREATMENT');
                Lab.SETRANGE(Lab."Link No.", "Treatment No.");
                IF Lab.FIND('-') THEN BEGIN LabNo := Lab."Laboratory No." END;

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
        Patient: Record "HMS-Patient";
        AgeText: Text[100];
        HRDates: Codeunit "Hr Dates";
        PatientName: Text[100];
        Gender: Text[30];
        Doctor: Record "HMIS-Visits/Registrations";
        DoctorName: Text[100];
        Lab: Record "HMS-Laboratory Form Header";
        LabNo: Code[20];
        University_HEALTH_SERVICESCaptionLbl: Label 'University HEALTH SERVICES';
        LABORATORY_REQUEST_FORMCaptionLbl: Label 'LABORATORY REQUEST FORM';
        Name_CaptionLbl: Label 'Name:';
        Department_CaptionLbl: Label 'Department:';
        Age_CaptionLbl: Label 'Age:';
        Gender_CaptionLbl: Label 'Gender:';
        Date_CaptionLbl: Label 'Date:';
        PF_No__CaptionLbl: Label 'PF/No.:';
        Clinical_NotesCaptionLbl: Label 'Clinical Notes';
        DescriptionCaptionLbl: Label 'Description';
        CodeCaptionLbl: Label 'Code';
        Date_DueCaptionLbl: Label 'Date Due';
        RemarksCaptionLbl: Label 'Remarks';
        Request_No__CaptionLbl: Label 'Request No.:';
        Doctor_s_NameCaptionLbl: Label 'Doctor''s Name';
}

