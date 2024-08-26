report 50720 "HMS Appointments Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSAppointmentsListing.rdl';

    dataset
    {
        dataitem(DataItem8549; "HMS-Appointment Form Header")
        {
            DataItemTableView = SORTING("Appointment No.");
            RequestFilterFields = "Appointment No.", "Appointment Date", "Appointment Time", "Patient Type";
            column(DATE_PRINTED____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(HMS_Appointment_Form_Header__Appointment_No__; "Appointment No.")
            {
            }
            column(HMS_Appointment_Form_Header__Appointment_Date_; "Appointment Date")
            {
            }
            column(HMS_Appointment_Form_Header__Appointment_Type_; "Appointment Type")
            {
            }
            column(HMS_Appointment_Form_Header_Doctor; Doctor)
            {
            }
            column(HMS_Appointment_Form_Header__Patient_Type_; "Patient Type")
            {
            }
            column(UPPERCASE_FORMAT_Status__; UPPERCASE(FORMAT(Status)))
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(HMS_Appointment_Form_Header__Appointment_Time_; "Appointment Time")
            {
            }
            /* column(TOTAL_APPOINTMENTS_LISTED_____FORMAT__HMS_Appointment_Form_Header__COUNT_; 'TOTAL APPOINTMENTS LISTED:' + FORMAT("HMS-Appointment Form Header".COUNT))
            {
            } */
            column(PRINTED_BY____USERID; 'PRINTED BY:' + USERID)
            {
            }
            column(University_HEALTH_SERVICESCaption; University_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(APPOINTMENTS_LISTINGCaption; APPOINTMENTS_LISTINGCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(TypeCaption; TypeCaptionLbl)
            {
            }
            column(HMS_Appointment_Form_Header_DoctorCaption; FIELDCAPTION(Doctor))
            {
            }
            column(HMS_Appointment_Form_Header__Patient_Type_Caption; FIELDCAPTION("Patient Type"))
            {
            }
            column(StatusCaption; StatusCaptionLbl)
            {
            }
            column(Patient_NameCaption; Patient_NameCaptionLbl)
            {
            }
            column(PF_No_Caption; PF_No_CaptionLbl)
            {
            }
            column(TimeCaption; TimeCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Patient.RESET;
                PFNo := '';
                PatientName := '';
                IF Patient.GET("Patient No.") THEN BEGIN
                    PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                    IF Patient."Patient Type" = Patient."Patient Type"::Others THEN BEGIN
                        PFNo := Patient."Student No.";
                    END
                    ELSE
                        IF Patient."Patient Type" = Patient."Patient Type"::Student THEN BEGIN
                            PFNo := Patient."Employee No."
                        END
                        ELSE
                            IF Patient."Patient Type" = Patient."Patient Type"::Employee THEN BEGIN
                                PFNo := Patient."Employee No.";
                            END
                            ELSE
                                IF Patient."Patient Type" = Patient."Patient Type"::" " THEN BEGIN
                                    PFNo := Patient."Patient No.";
                                END
                                ELSE BEGIN
                                    PFNo := Patient."Patient No.";
                                END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Appointment No.");
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
        Patient: Record "HMS-Patient";
        PFNo: Code[20];
        PatientName: Text[200];
        University_HEALTH_SERVICESCaptionLbl: Label 'University HEALTH SERVICES';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        APPOINTMENTS_LISTINGCaptionLbl: Label 'APPOINTMENTS LISTING';
        No_CaptionLbl: Label 'No.';
        DateCaptionLbl: Label 'Date';
        TypeCaptionLbl: Label 'Type';
        StatusCaptionLbl: Label 'Status';
        Patient_NameCaptionLbl: Label 'Patient Name';
        PF_No_CaptionLbl: Label 'PF No.';
        TimeCaptionLbl: Label 'Time';
}

