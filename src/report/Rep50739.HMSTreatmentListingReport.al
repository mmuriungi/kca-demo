report 50739 "HMS Treatment Listing Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSTreatmentListingReport.rdlc';

    dataset
    {
        dataitem(DataItem3701; "HMS-Treatment Form Header")
        {
            DataItemTableView = SORTING("Treatment No.");
            RequestFilterFields = "Treatment No.", "Doctor ID";
            column(Date_Printed_____FORMAT_TODAY_0_4_; 'Date Printed: ' + FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(Printed_By______USERID; 'Printed By: ' + USERID)
            {
            }
            column(HMS_Treatment_Form_Header__Treatment_No__; "Treatment No.")
            {
            }
            column(HMS_Treatment_Form_Header__Treatment_Type_; "Treatment Type")
            {
            }
            column(HMS_Treatment_Form_Header__Treatment_Date_; "Treatment Date")
            {
            }
            column(HMS_Treatment_Form_Header__Doctor_ID_; "Doctor ID")
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(HMS_Treatment_Form_Header_Status; Status)
            {
            }
            column(HMS_Treatment_Form_Header__Treatment_Location_; "Treatment Location")
            {
            }
            column(HMS_Treatment_Form_Header__Patient_Type_; "Patient Type")
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(Number_of_Treatment_s__Listed______FORMAT__HMS_Treatment_Form_Header__COUNT_; 'Number of Treatment(s) Listed: ' + FORMAT(COUNT))
            {
            }
            column(University_HEALTH_SERVICESCaption; University_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(TREATMENT_LISTING_REPORTCaption; TREATMENT_LISTING_REPORTCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(TypeCaption; TypeCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(HMS_Treatment_Form_Header__Doctor_ID_Caption; FIELDCAPTION("Doctor ID"))
            {
            }
            column(PF_No_Caption; PF_No_CaptionLbl)
            {
            }
            column(HMS_Treatment_Form_Header_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(Patient_Loc_Caption; Patient_Loc_CaptionLbl)
            {
            }
            column(Pat__TypeCaption; Pat__TypeCaptionLbl)
            {
            }
            column(Patient_nameCaption; Patient_nameCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Patient.RESET;
                PFNo := '';
                PatientName := '';
                IF Patient.GET("Patient No.") THEN BEGIN
                    PatientName := Patient.Surname + ' ' + Patient."Middle Name" + Patient."Last Name";
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
                LastFieldNo := FIELDNO("Treatment No.");
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
        TREATMENT_LISTING_REPORTCaptionLbl: Label 'TREATMENT LISTING REPORT';
        No_CaptionLbl: Label 'No.';
        TypeCaptionLbl: Label 'Type';
        DateCaptionLbl: Label 'Date';
        PF_No_CaptionLbl: Label 'PF No.';
        Patient_Loc_CaptionLbl: Label 'Patient Loc.';
        Pat__TypeCaptionLbl: Label 'Pat. Type';
        Patient_nameCaptionLbl: Label 'Patient name';
}

