report 50727 "HMS Laboratory Test Finding"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSLaboratoryTestFinding.rdl';

    dataset
    {
        dataitem(DataItem7278; "HMS-Laboratory Form Header")
        {
            DataItemTableView = SORTING("Laboratory No.");
            RequestFilterFields = "Laboratory No.";
            column(Date_Printed______FORMAT_TODAY_0_4_; 'Date Printed: ' + FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(Printed_By______USERID; 'Printed By: ' + USERID)
            {
            }
            column(HMS_Laboratory_Form_Header__Laboratory_No__; "Laboratory No.")
            {
            }
            column(HMS_Laboratory_Form_Header__Laboratory_Date_; "Laboratory Date")
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(HMS_Laboratory_Form_Header__Supervisor_ID_; "Supervisor ID")
            {
            }
            column(HMS_Laboratory_Form_Header_Status; Status)
            {
            }
            column(HMS_Laboratory_Form_Header__Patient_Type_; "Patient Type")
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(Number_of_Laboratory_Tests_Listed______FORMAT__HMS_Laboratory_Form_Header__COUNT_; 'Number of Laboratory Tests Listed: ' + FORMAT(COUNT))
            {
            }
            column(University_HEALTH_SERVICESCaption; University_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(LABORATORY_TESTS_LISTINGCaption; LABORATORY_TESTS_LISTINGCaptionLbl)
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
            column(ResponsibleCaption; ResponsibleCaptionLbl)
            {
            }
            column(HMS_Laboratory_Form_Header_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(HMS_Laboratory_Form_Header__Patient_Type_Caption; FIELDCAPTION("Patient Type"))
            {
            }
            column(Patient_nameCaption; Patient_nameCaptionLbl)
            {
            }
            column(Test_PackageCaption; Test_PackageCaptionLbl)
            {
            }
            column(TestCaption; TestCaptionLbl)
            {
            }
            column(SpecimenCaption; SpecimenCaptionLbl)
            {
            }
            column(StatusCaption; StatusCaptionLbl)
            {
            }
            dataitem(DataItem7451; "HMS-Laboratory Test Line")
            {
                DataItemLink = "Laboratory No." = FIELD("Laboratory No.");
                column(HMS_Laboratory_Test_Line__HMS_Laboratory_Test_Line___Laboratory_Test_Code_; "Laboratory Test Code")
                {
                }
                column(HMS_Laboratory_Test_Line__Laboratory_Test_Name_; "Laboratory Test Name")
                {
                }
                column(HMS_Laboratory_Test_Line__Specimen_Name_; "Specimen Name")
                {
                }
                column(HMS_Laboratory_Test_Line_Completed; Completed)
                {
                }
                column(HMS_Laboratory_Test_Line__Assigned_User_ID_; "Assigned User ID")
                {
                }
                column(HMS_Laboratory_Test_Line__Collection_Date_; "Collection Date")
                {
                }
                column(HMS_Laboratory_Test_Line__Collection_Time_; "Collection Time")
                {
                }
                column(HMS_Laboratory_Test_Line__Measuring_Unit_Code_; "Measuring Unit Code")
                {
                }
                column(HMS_Laboratory_Test_Line__Count_Value_; "Count Value")
                {
                }
                column(HMS_Laboratory_Test_Line_Remarks; Remarks)
                {
                }
                column(HMS_Laboratory_Test_Line_Completed_Control1102760046; Completed)
                {
                }
                column(HMS_Laboratory_Test_Line_Positive; Positive)
                {
                }
                column(HMS_Laboratory_Test_Line__Assigned_User_ID_Caption; FIELDCAPTION("Assigned User ID"))
                {
                }
                column(HMS_Laboratory_Test_Line__Collection_Date_Caption; FIELDCAPTION("Collection Date"))
                {
                }
                column(HMS_Laboratory_Test_Line__Collection_Time_Caption; FIELDCAPTION("Collection Time"))
                {
                }
                column(HMS_Laboratory_Test_Line__Measuring_Unit_Code_Caption; FIELDCAPTION("Measuring Unit Code"))
                {
                }
                column(HMS_Laboratory_Test_Line__Count_Value_Caption; FIELDCAPTION("Count Value"))
                {
                }
                column(HMS_Laboratory_Test_Line_RemarksCaption; FIELDCAPTION(Remarks))
                {
                }
                column(HMS_Laboratory_Test_Line_Completed_Control1102760046Caption; FIELDCAPTION(Completed))
                {
                }
                column(HMS_Laboratory_Test_Line_PositiveCaption; FIELDCAPTION(Positive))
                {
                }
                column(HMS_Laboratory_Test_Line_Laboratory_No_; "Laboratory No.")
                {
                }
                column(HMS_Laboratory_Test_Line_Specimen_Code; "Specimen Code")
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
                END
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Laboratory No.");
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
        LABORATORY_TESTS_LISTINGCaptionLbl: Label 'LABORATORY TESTS LISTING';
        No_CaptionLbl: Label 'No.';
        DateCaptionLbl: Label 'Date';
        PF_No_CaptionLbl: Label 'PF/No.';
        ResponsibleCaptionLbl: Label 'Responsible';
        Patient_nameCaptionLbl: Label 'Patient name';
        Test_PackageCaptionLbl: Label 'Test Package';
        TestCaptionLbl: Label 'Test';
        SpecimenCaptionLbl: Label 'Specimen';
        StatusCaptionLbl: Label 'Status';
}

