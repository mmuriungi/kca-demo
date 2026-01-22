report 50729 "HMS Observation Listing Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSObservationListingReport.rdl';

    dataset
    {
        dataitem(DataItem8630; "HMS-Observation Form Header")
        {
            DataItemTableView = SORTING("Observation No.");
            RequestFilterFields = "Observation No.";
            column(DATE_PRINTED_____UPPERCASE_FORMAT_TODAY_0_4__; 'DATE PRINTED:' + UPPERCASE(FORMAT(TODAY, 0, 4)))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(PRINTED_BY____USERID; 'PRINTED BY:' + USERID)
            {
            }
            column(HMS_Observation_Form_Header__Observation_No__; "Observation No.")
            {
            }
            column(HMS_Observation_Form_Header__Observation_Date_; "Observation Date")
            {
            }
            column(HMS_Observation_Form_Header__Observation_Time_; "Observation Time")
            {
            }
            column(HMS_Observation_Form_Header__Observation_Remarks_; "Observation Remarks")
            {
            }
            column(HMS_Observation_Form_Header_Closed; Closed)
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(OBSERVATIONS_LISTED_____FORMAT__HMS_Observation_Form_Header__COUNT_; 'OBSERVATIONS LISTED: ' + FORMAT(COUNT))
            {
            }
            column(University_HEALTH_SERVICESCaption; University_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(TimeCaption; TimeCaptionLbl)
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(HMS_Observation_Form_Header_ClosedCaption; FIELDCAPTION(Closed))
            {
            }
            column(PF_No_Caption; PF_No_CaptionLbl)
            {
            }
            column(Patient_nameCaption; Patient_nameCaptionLbl)
            {
            }
            column(OBSERVATION_LISTING_REPORTCaption; OBSERVATION_LISTING_REPORTCaptionLbl)
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
        PFNo: Code[20];
        PatientName: Text[100];
        Patient: Record "HMS-Patient";
        University_HEALTH_SERVICESCaptionLbl: Label 'University HEALTH SERVICES';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        No_CaptionLbl: Label 'No.';
        DateCaptionLbl: Label 'Date';
        TimeCaptionLbl: Label 'Time';
        RemarksCaptionLbl: Label 'Remarks';
        PF_No_CaptionLbl: Label 'PF No.';
        Patient_nameCaptionLbl: Label 'Patient name';
        OBSERVATION_LISTING_REPORTCaptionLbl: Label 'OBSERVATION LISTING REPORT';
}

