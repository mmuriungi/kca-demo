report 54814 "HMS Pharmacy List Detailed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSPharmacyListDetailed.rdl';

    dataset
    {
        dataitem(DataItem7110; "HMS-Pharmacy Header")
        {
            DataItemTableView = SORTING("Pharmacy No.");
            RequestFilterFields = "Pharmacy No.";
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + FORMAT(TODAY, 0, 4))
            {
            }
            column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
            {
            }

            column(PRINTED_BY______USERID; 'PRINTED BY: ' + USERID)
            {
            }
            column(HMS_Pharmacy_Header__Pharmacy_No__; "Pharmacy No.")
            {
            }
            column(HMS_Pharmacy_Header__Pharmacy_Date_; "Pharmacy Date")
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(HMS_Pharmacy_Header__Issued_By_; "Issued By")
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(HMS_Pharmacy_Header_Status; Status)
            {
            }
            column(University_HEALTH_SERVICESCaption; University_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(PHARMACY_LISTING_REPORTCaption; PHARMACY_LISTING_REPORTCaptionLbl)
            {
            }
            column(HMS_Pharmacy_Line__Drug_No__Caption; "HMS-Pharmacy Line".FIELDCAPTION("Drug No."))
            {
            }
            column(HMS_Pharmacy_Line__Drug_Name_Caption; "HMS-Pharmacy Line".FIELDCAPTION("Drug Name"))
            {
            }
            column(HMS_Pharmacy_Line_DosageCaption; "HMS-Pharmacy Line".FIELDCAPTION(Dosage))
            {
            }
            column(StoreCaption; StoreCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(Actl_QtyCaption; Actl_QtyCaptionLbl)
            {
            }
            column(Issued_QtyCaption; Issued_QtyCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(HMS_Pharmacy_Header__Issued_By_Caption; FIELDCAPTION("Issued By"))
            {
            }
            column(PFNoCaption; PFNoCaptionLbl)
            {
            }
            column(Patient_nameCaption; Patient_nameCaptionLbl)
            {
            }
            column(HMS_Pharmacy_Header_StatusCaption; FIELDCAPTION(Status))
            {
            }
            dataitem(DataItem1251; "HMS-Pharmacy Line")
            {
                DataItemLink = "Pharmacy No." = FIELD("Pharmacy No.");
                column(HMS_Pharmacy_Line__Drug_No__; "Drug No.")
                {
                }
                column(HMS_Pharmacy_Line__Drug_Name_; "Drug Name")
                {
                }
                column(HMS_Pharmacy_Line_Quantity; Quantity)
                {
                }
                column(HMS_Pharmacy_Line__Actual_Qty_; "Actual Qty")
                {
                }
                column(HMS_Pharmacy_Line__Issued_Quantity_; "Issued Quantity")
                {
                }
                column(HMS_Pharmacy_Line_Dosage; Dosage)
                {
                }
                column(HMS_Pharmacy_Line_Pharmacy; Pharmacy)
                {
                }
                column(HMS_Pharmacy_Line_Pharmacy_No_; "Pharmacy No.")
                {
                }
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
                LastFieldNo := FIELDNO("Pharmacy No.");
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
        PHARMACY_LISTING_REPORTCaptionLbl: Label 'PHARMACY LISTING REPORT';
        StoreCaptionLbl: Label 'Store';
        QtyCaptionLbl: Label 'Qty';
        Actl_QtyCaptionLbl: Label 'Actl Qty';
        Issued_QtyCaptionLbl: Label 'Issued Qty';
        No_CaptionLbl: Label 'No.';
        DateCaptionLbl: Label 'Date';
        PFNoCaptionLbl: Label 'Label1102760018';
        Patient_nameCaptionLbl: Label 'Patient name';
        "HMS-Pharmacy Line": Record "HMS-Pharmacy Line";
}

