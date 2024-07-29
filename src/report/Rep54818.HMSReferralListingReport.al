report 54818 "HMS Referral Listing Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSReferralListingReport.rdl';

    dataset
    {
        dataitem(DataItem6553; "HMS-Referral Header")
        {
            DataItemTableView = SORTING("Treatment no.");
            RequestFilterFields = "Treatment no.";
            column(Date_Printed_____FORMAT_TODAY_0_4_; 'Date Printed:' + FORMAT(TODAY, 0, 4))
            {
            }
            column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
            {
            }

            column(Printed_By_____USERID; 'Printed By:' + USERID)
            {
            }
            column(HMS_Referral_Header__Treatment_no__; "Treatment no.")
            {
            }
            column(HMS_Referral_Header__Hospital_No__; "Hospital No.")
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(HMS_Referral_Header__Date_Referred_; "Date Referred")
            {
            }
            column(HMS_Referral_Header__Referral_Reason_; "Referral Reason")
            {
            }
            column(HMS_Referral_Header_Status; Status)
            {
            }
            column(HospName; HospName)
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(REFERRALS_LISTED______FORMAT__HMS_Referral_Header__COUNT_; 'REFERRALS LISTED: ' + FORMAT(COUNT))
            {
            }
            column(University_HEALTH_SERVICESCaption; University_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(REFERRAL_LISTING_REPORTCaption; REFERRAL_LISTING_REPORTCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(HMS_Referral_Header__Hospital_No__Caption; FIELDCAPTION("Hospital No."))
            {
            }
            column(PFNoCaption; PFNoCaptionLbl)
            {
            }
            column(HMS_Referral_Header__Date_Referred_Caption; FIELDCAPTION("Date Referred"))
            {
            }
            column(HMS_Referral_Header__Referral_Reason_Caption; FIELDCAPTION("Referral Reason"))
            {
            }
            column(HMS_Referral_Header_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(HospitalCaption; HospitalCaptionLbl)
            {
            }
            column(Patient_nameCaption; Patient_nameCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Hosp.RESET;
                HospName := '';
                IF Hosp.GET("HMS-Referral Header"."Hospital No.") THEN BEGIN
                    HospName := Hosp.Name;
                END;

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
                LastFieldNo := FIELDNO("Treatment no.");
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
        "HMS-Referral Header": Record "HMS-Referral Header";
        PatientName: Text[200];
        PFNo: Code[20];
        Hosp: Record 23;
        HospName: Text[100];
        University_HEALTH_SERVICESCaptionLbl: Label 'University HEALTH SERVICES';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        REFERRAL_LISTING_REPORTCaptionLbl: Label 'REFERRAL LISTING REPORT';
        No_CaptionLbl: Label 'No.';
        PFNoCaptionLbl: Label 'Label1102760018';
        HospitalCaptionLbl: Label 'Hospital';
        Patient_nameCaptionLbl: Label 'Patient name';
}

