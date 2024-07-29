report 54801 "HMS Admission Listing Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSAdmissionListingSummary.rdl';

    dataset
    {
        dataitem(DataItem8448; "HMS-Admission Form Header")
        {
            DataItemTableView = SORTING("Admission No.");
            RequestFilterFields = "Admission No.";
            column(Date_Printed____FORMAT_TODAY_0_4_; 'Date Printed:' + FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(Printed_By______USERID; 'Printed By: ' + USERID)
            {
            }
            column(HMS_Admission_Form_Header__Admission_No__; "Admission No.")
            {
            }
            column(HMS_Admission_Form_Header__Admission_Date_; "Admission Date")
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(HMS_Admission_Form_Header_Ward; Ward)
            {
            }
            column(HMS_Admission_Form_Header_Bed; Bed)
            {
            }
            column(HMS_Admission_Form_Header_Doctor; Doctor)
            {
            }
            column(HMS_Admission_Form_Header_Status; Status)
            {
            }
            column(HMS_Admission_Form_Header__Admission_Reason_; "Admission Reason")
            {
            }
            column(PatientName; PatientName)
            {
            }
            /*  column(ADMISSION_RECORDS_LISTED_____FORMAT__HMS_Admission_Form_Header__COUNT_; 'ADMISSION RECORDS LISTED:' + FORMAT("HMS-Admission Form Header".COUNT))
             {
             } */
            column(University_HEALTH_SERVICESCaption; University_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ADMISSION_LISTING_REPORTCaption; ADMISSION_LISTING_REPORTCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(PF_No_Caption; PF_No_CaptionLbl)
            {
            }
            column(HMS_Admission_Form_Header_WardCaption; FIELDCAPTION(Ward))
            {
            }
            column(HMS_Admission_Form_Header_BedCaption; FIELDCAPTION(Bed))
            {
            }
            column(HMS_Admission_Form_Header_DoctorCaption; FIELDCAPTION(Doctor))
            {
            }
            column(HMS_Admission_Form_Header_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(Patient_nameCaption; Patient_nameCaptionLbl)
            {
            }
            column(ReasonCaption; ReasonCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Patient.RESET;
                PatientName := '';
                PFNo := '';
                IF Patient.GET("Patient No.") THEN BEGIN
                    PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
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
                END;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Admission No.");
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
        PatientName: Text[200];
        PFNo: Code[20];
        University_HEALTH_SERVICESCaptionLbl: Label 'University HEALTH SERVICES';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ADMISSION_LISTING_REPORTCaptionLbl: Label 'ADMISSION LISTING REPORT';
        No_CaptionLbl: Label 'No.';
        DateCaptionLbl: Label 'Date';
        PF_No_CaptionLbl: Label 'PF No.';
        Patient_nameCaptionLbl: Label 'Patient name';
        ReasonCaptionLbl: Label 'Reason';
}

