report 54242 "Non-Range Results"
{
    Caption = 'Non-Range Results';


    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/NonRangedLabResultsPreview.rdl';

    dataset
    {
        dataitem("HMS-Treatment Form Laboratory"; "HMS-Treatment Form Laboratory")
        {
            column(Patient_No_; "Patient No.")
            {
            }
            column(Comments; Comments)
            {
            }
            column(Treatment_No_; "Treatment No.")
            {
            }
            column(Compnay_Name; info.Name)
            {
            }
            column(Compnay_Picture; info.Picture)
            {
            }
            column(Compnay_Email; info."E-Mail")
            {
            }
            column(Laboratory_Test_Package_Code; "Laboratory Test Package Code")
            {
            }

            dataitem(HMSSetupTestSpecimen; "HMS-Setup Test Specimen")
            {
                DataItemLink = "Lab Test" = field("Laboratory Test Package Code");

                DataItemLinkReference = "HMS-Treatment Form Laboratory";
                DataItemTableView = sorting("Lab Test Description");
                ;

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
                column(Non_Ranged_Result; "Non-Ranged Result")
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
                    field(LabTestPackageCode; LabTestPackageCode)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Select the Laboratory Test Package Code to filter the report.';
                    }
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
        "HMS-Treatment Form Laboratory".SetRange("Laboratory Test Package Code", LabTestPackageCode);

        info.get();
        info.CalcFields(Picture);
    end;

    var
        info: Record "Company Information";
        LabTestPackageCode: Code[20]; // Variable to store the selected Laboratory Test Package Code
}
