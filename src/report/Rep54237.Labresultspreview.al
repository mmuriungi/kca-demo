report 54237 "Lab results preview"
{
    Caption = 'Lab results preview';

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LabResultsPriview.rdl';

    dataset
    {
        dataitem(HMSTreatmentFormLab; "HMS-Treatment Form Laboratory")
        {

            RequestFilterFields = "Patient No.";
            column(Patient_No_; "Patient No.")
            {
            }
            column(Comments; Comments)
            {
            }
            column(Company_Picture; info.Picture)
            {
            }
            column(Company_Name; info.Name)
            {
            }

            column(Company_Email; info."E-Mail")
            {
            }
            column(Treatment_No_; "Treatment No.")
            {
            }
            column(Laboratory_Test_Package_Code; "Laboratory Test Package Code")
            {
            }
            column(Full_Name; "Full Name")
            {
            }
            column(AGE; AGE)
            {
            }
            column(GENDER; GENDER)
            {
            }
            column(Treatment_Date; "Treatment Date")
            {
            }
            column(Treatment_time; "Treatment time")
            {
            }
            column(pName; pName)
            {

            }
            column(agez; agez)
            {

            }

            dataitem(HMSSetupTestSpecimen; "HMS-Setup Test Specimen")
            {
                DataItemLink = "lab test" = field("Laboratory Test Package Code");

                DataItemLinkReference = HMSTreatmentFormLab;
                DataItemTableView = sorting("Lab Test Description");


                column(specimencode; "specimen code")
                {
                }
                column(LabTest; "Lab Test")
                {
                }
                column(SpecimenName; "Specimen Name")
                {
                }
                column(LabTestDescription; "Lab Test Description")
                {
                }
                column(Result; Result)
                {
                }
                column(unit; unit)
                {
                }
                column(MaximumValue; "Maximum Value")
                {
                }
                column(Flag; Flag)
                {
                }
                column(MinimumValue; "Minimum Value")
                {
                }

                column(PatientNo; "Patient No.")
                {
                }
                column(TreatmentNo; "Treatment No.")
                {
                }
                column(LaboratoryTestPackageCode; "Laboratory Test Package Code")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                treatmentHeader.Reset();
                treatmentHeader.SetRange("Treatment No.", HMSTreatmentFormLab."Treatment No.");
                if treatmentHeader.Find('-') then begin
                    pName := treatmentHeader."Patient Name";
                    agez := treatmentHeader.age;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(LabTestPackageCode; LabTestPackageCode)
                    // {
                    //     ApplicationArea = All;
                    //     ToolTip = 'Select the Laboratory Test Package Code to filter the report.';
                    // }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        // Apply the filter based on the selected Laboratory Test Package Code
        HMSTreatmentFormLab.SetRange("Laboratory Test Package Code", LabTestPackageCode);

        info.get();
        info.CalcFields(Picture);
    end;

    var
        info: Record "Company Information";
        LabTestPackageCode: Code[20]; // Variable to store the selected Laboratory Test Package Code
        treatmentHeader: Record "HMS-Treatment Form Header";
        pName, agez : Text;
}