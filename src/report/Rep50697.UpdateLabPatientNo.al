report 50697 "Update Lab Patient No"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LabPatientNo.rdl';

    dataset
    {
        dataitem(labry; "HMS-Treatment Form Laboratory")
        {

            column(TreatmentNo_labry; "Treatment No.")
            {
            }
            column(LaboratoryTestPackageCode_labry; "Laboratory Test Package Code")
            {
            }
            column(LaboratoryTestPackageName_labry; "Laboratory Test Package Name")
            {
            }
            column(DateDue_labry; "Date Due")
            {
            }

            trigger OnAfterGetRecord()
            begin
                labry2.Reset();
                labry2.SetRange("Treatment No.", "Treatment No.");
                labry2.SetRange("Laboratory Test Package Code", "Laboratory Test Package Code");
                if labry2.Find('-') then begin
                    repeat
                        labry2."Patient No." := labry2."Treatment No.";
                        labry2.Modify(true);
                    until labry2.Next() = 0;
                end;
            end;


        }
    }
    var
        labry2: Record "HMS-Treatment Form Laboratory";
}