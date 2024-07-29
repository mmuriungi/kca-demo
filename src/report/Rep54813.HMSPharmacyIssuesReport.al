report 54813 "HMS Pharmacy Issues Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSPharmacyIssuesReport.rdl';

    dataset
    {
        dataitem(DataItem1251; "HMS-Pharmacy Line")
        {
            DataItemTableView = SORTING("Pharmacy No.", "Drug No.");
            RequestFilterFields = "Pharmacy No.";
            column(Date_Printed_____FORMAT_TODAY_0_4_; 'Date Printed:' + FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Printed_By______USERID; 'Printed By: ' + USERID)
            {
            }
            column(HMS_Pharmacy_Line__Pharmacy_No__; "Pharmacy No.")
            {
            }
            column(HMS_Pharmacy_Line__Drug_No__; "Drug No.")
            {
            }
            column(HMS_Pharmacy_Line__Drug_Name_; "Drug Name")
            {
            }
            column(HMS_Pharmacy_Line_Quantity; Quantity)
            {
            }
            column(HMS_Pharmacy_Line__Measuring_Unit_; "Measuring Unit")
            {
            }
            column(HMS_Pharmacy_Line__Actual_Qty_; "Actual Qty")
            {
            }
            column(HMS_Pharmacy_Line__Issued_Quantity_; "Issued Quantity")
            {
            }
            column(HMS_Pharmacy_Line__Issued_Units_; "Issued Units")
            {
            }
            column(HMS_Pharmacy_Line_Pharmacy; Pharmacy)
            {
            }
            column(HMS_Pharmacy_Line_Remaining; Remaining)
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(HMS_Pharmacy_Line_Date; Date)
            {
            }
            column(HMS_Pharmacy_Line_Dosage; Dosage)
            {
            }
            column(Number_of_Drug_Issues_Listed______FORMAT__HMS_Pharmacy_Line__COUNT_; 'Number of Drug Issues Listed: ' + FORMAT(COUNT))
            {
            }
            column(University_HEALTH_SERVICESCaption; University_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(PHARMACY_ISSUES_LISTING_REPORTCaption; PHARMACY_ISSUES_LISTING_REPORTCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(HMS_Pharmacy_Line__Drug_No__Caption; FIELDCAPTION("Drug No."))
            {
            }
            column(HMS_Pharmacy_Line__Drug_Name_Caption; FIELDCAPTION("Drug Name"))
            {
            }
            column(HMS_Pharmacy_Line_QuantityCaption; FIELDCAPTION(Quantity))
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(HMS_Pharmacy_Line__Actual_Qty_Caption; FIELDCAPTION("Actual Qty"))
            {
            }
            column(Issued_QtyCaption; Issued_QtyCaptionLbl)
            {
            }
            column(Iss__UnitsCaption; Iss__UnitsCaptionLbl)
            {
            }
            column(HMS_Pharmacy_Line_PharmacyCaption; FIELDCAPTION(Pharmacy))
            {
            }
            column(HMS_Pharmacy_Line_RemainingCaption; FIELDCAPTION(Remaining))
            {
            }
            column(PF_No_Caption; PF_No_CaptionLbl)
            {
            }
            column(Patient_nameCaption; Patient_nameCaptionLbl)
            {
            }
            column(HMS_Pharmacy_Line_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(HMS_Pharmacy_Line_DosageCaption; FIELDCAPTION(Dosage))
            {
            }

            trigger OnAfterGetRecord()
            begin
                Patient.RESET;
                PFNo := '';
                PatientName := '';
                Header.RESET;
                Header.GET("Pharmacy No.");
                IF Patient.GET(Header."Patient No.") THEN BEGIN
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
        Header: Record "HMS-Pharmacy Header";
        University_HEALTH_SERVICESCaptionLbl: Label 'University HEALTH SERVICES';
        PHARMACY_ISSUES_LISTING_REPORTCaptionLbl: Label 'PHARMACY ISSUES LISTING REPORT';
        No_CaptionLbl: Label 'No.';
        UOMCaptionLbl: Label 'UOM';
        Issued_QtyCaptionLbl: Label 'Issued Qty';
        Iss__UnitsCaptionLbl: Label 'Iss. Units';
        PF_No_CaptionLbl: Label 'PF/No.';
        Patient_nameCaptionLbl: Label 'Patient name';
}

