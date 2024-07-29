report 54238 "Prescription Drugs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSPrescription Drugs.rdl';
    Caption = 'Prescription Drugs';
    dataset
    {
        dataitem("HMS-Pharmacy Header"; "HMS-Pharmacy Header")
        {
            column(Full_Name; "Full Name")
            {

            }
            column(Treatment_No_; "Treatment No.")
            {

            }
            column(Pharmacy_Date; "Pharmacy Date")
            {

            }
            dataitem(HMSTreatmentFormDrug; "HMS-Treatment Form Drug")
            {
                DataItemTableView = where("Treatment No." = const());
                column(TreatmentNo; "Treatment No.")
                {
                }
                column(DrugNo; "Drug No.")
                {
                }
                column(DrugName; "Drug Name")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Dosage; Dosage)
                {
                }
                column(Company_Name; info.Name)
                {

                }
                column(Company_Picture; info.Picture)
                {

                }
                column(Company_email; info."E-Mail")
                {

                }
                column(TotalNumberOfTablets; " Total Number Of Tablets")
                {
                }
                column(Dosage_Frequencies_; "Dosage Frequencies ")
                {
                }
                column(Route_of_Administration; "Route of Administration")
                {
                }
                column(Quantity_to_issue; "Quantity to issue")
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
    var
        myInt: Integer;
    begin
        if info.get() then
            info.Reset();
        info.CalcFields(Picture);

    end;

    var
        info: Record "Company Information";
}
